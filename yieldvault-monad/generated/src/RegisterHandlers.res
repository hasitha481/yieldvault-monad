@val external require: string => unit = "require"

let registerContractHandlers = (
  ~contractName,
  ~handlerPathRelativeToRoot,
  ~handlerPathRelativeToConfig,
) => {
  try {
    require(`../${Path.relativePathToRootFromGenerated}/${handlerPathRelativeToRoot}`)
  } catch {
  | exn =>
    let params = {
      "Contract Name": contractName,
      "Expected Handler Path": handlerPathRelativeToConfig,
      "Code": "EE500",
    }
    let logger = Logging.createChild(~params)

    let errHandler = exn->ErrorHandling.make(~msg="Failed to import handler file", ~logger)
    errHandler->ErrorHandling.log
    errHandler->ErrorHandling.raiseExn
  }
}

%%private(
  let makeGeneratedConfig = () => {
    let chains = [
      {
        let contracts = [
          {
            InternalConfig.name: "ERC20",
            abi: Types.ERC20.abi,
            addresses: [
              "0x62534e4bbd6d9ebac0ac99aeaa0aa48e56372df0"->Address.Evm.fromStringOrThrow
,
            ],
            events: [
              (Types.ERC20.Transfer.register() :> Internal.eventConfig),
              (Types.ERC20.Approval.register() :> Internal.eventConfig),
            ],
            startBlock: None,
          },
        ]
        let chain = ChainMap.Chain.makeUnsafe(~chainId=10143)
        {
          InternalConfig.confirmedBlockThreshold: 200,
          startBlock: 0,
          id: 10143,
          contracts,
          sources: NetworkSources.evm(~chain, ~contracts=[{name: "ERC20",events: [Types.ERC20.Transfer.register(), Types.ERC20.Approval.register()],abi: Types.ERC20.abi}], ~hyperSync=Some("https://10143.hypersync.xyz"), ~allEventSignatures=[Types.ERC20.eventSignatures]->Belt.Array.concatMany, ~shouldUseHypersyncClientDecoder=true, ~rpcs=[], ~lowercaseAddresses=false)
        }
      },
    ]

    Config.make(
      ~shouldRollbackOnReorg=true,
      ~shouldSaveFullHistory=false,
      ~isUnorderedMultichainMode=true,
      ~chains,
      ~enableRawEvents=true,
      ~batchSize=?Env.batchSize,
      ~preloadHandlers=true,
      ~lowercaseAddresses=false,
      ~shouldUseHypersyncClientDecoder=true,
    )
  }

  let config: ref<option<Config.t>> = ref(None)
)

let registerAllHandlers = () => {
  let configWithoutRegistrations = makeGeneratedConfig()
  EventRegister.startRegistration(
    ~ecosystem=configWithoutRegistrations.ecosystem,
    ~multichain=configWithoutRegistrations.multichain,
    ~preloadHandlers=configWithoutRegistrations.preloadHandlers,
  )

  registerContractHandlers(
    ~contractName="ERC20",
    ~handlerPathRelativeToRoot="src/EventHandlers.ts",
    ~handlerPathRelativeToConfig="src/EventHandlers.ts",
  )

  let generatedConfig = {
    // Need to recreate initial config one more time,
    // since configWithoutRegistrations called register for event
    // before they were ready
    ...makeGeneratedConfig(),
    registrations: Some(EventRegister.finishRegistration()),
  }
  config := Some(generatedConfig)
  generatedConfig
}

let getConfig = () => {
  switch config.contents {
  | Some(config) => config
  | None => registerAllHandlers()
  }
}

let getConfigWithoutRegistrations = makeGeneratedConfig
