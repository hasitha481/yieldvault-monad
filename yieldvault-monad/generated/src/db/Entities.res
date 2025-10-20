open Table
open Enums.EntityType
type id = string

type internalEntity = Internal.entity
module type Entity = {
  type t
  let name: string
  let schema: S.t<t>
  let rowsSchema: S.t<array<t>>
  let table: Table.table
  let entityHistory: EntityHistory.t<t>
}
external entityModToInternal: module(Entity with type t = 'a) => Internal.entityConfig = "%identity"
external entityModsToInternal: array<module(Entity)> => array<Internal.entityConfig> = "%identity"
external entitiesToInternal: array<'a> => array<Internal.entity> = "%identity"

@get
external getEntityId: internalEntity => string = "id"

exception UnexpectedIdNotDefinedOnEntity
let getEntityIdUnsafe = (entity: 'entity): id =>
  switch Utils.magic(entity)["id"] {
  | Some(id) => id
  | None =>
    UnexpectedIdNotDefinedOnEntity->ErrorHandling.mkLogAndRaise(
      ~msg="Property 'id' does not exist on expected entity object",
    )
  }

//shorthand for punning
let isPrimaryKey = true
let isNullable = true
let isArray = true
let isIndex = true

@genType
type whereOperations<'entity, 'fieldType> = {
  eq: 'fieldType => promise<array<'entity>>,
  gt: 'fieldType => promise<array<'entity>>
}

module Account = {
  let name = (Account :> string)
  @genType
  type t = {
    
    balance: bigint,
    id: id,
  }

  let schema = S.object((s): t => {
    
    balance: s.field("balance", BigInt.schema),
    id: s.field("id", S.string),
  })

  let rowsSchema = S.array(schema)

  @genType
  type indexedFieldOperations = {
    
  }

  let table = mkTable(
    (name :> string),
    ~fields=[
      mkField(
      "balance", 
      Numeric,
      ~fieldSchema=BigInt.schema,
      
      
      
      
      
      ),
      mkField(
      "id", 
      Text,
      ~fieldSchema=S.string,
      ~isPrimaryKey,
      
      
      
      
      ),
      mkDerivedFromField(
      "approvals", 
      ~derivedFromEntity="Approval",
      ~derivedFromField="owner",
      ),
    ],
  )

  let entityHistory = table->EntityHistory.fromTable(~schema)

  external castToInternal: t => Internal.entity = "%identity"
}

module Approval = {
  let name = (Approval :> string)
  @genType
  type t = {
    amount: bigint,
    id: id,
    owner_id: id,
    spender_id: id,
  }

  let schema = S.object((s): t => {
    amount: s.field("amount", BigInt.schema),
    id: s.field("id", S.string),
    owner_id: s.field("owner_id", S.string),
    spender_id: s.field("spender_id", S.string),
  })

  let rowsSchema = S.array(schema)

  @genType
  type indexedFieldOperations = {
    
      @as("owner_id") owner_id: whereOperations<t, id>,
    
  }

  let table = mkTable(
    (name :> string),
    ~fields=[
      mkField(
      "amount", 
      Numeric,
      ~fieldSchema=BigInt.schema,
      
      
      
      
      
      ),
      mkField(
      "id", 
      Text,
      ~fieldSchema=S.string,
      ~isPrimaryKey,
      
      
      
      
      ),
      mkField(
      "owner", 
      Text,
      ~fieldSchema=S.string,
      
      
      
      
      ~linkedEntity="Account",
      ),
      mkField(
      "spender", 
      Text,
      ~fieldSchema=S.string,
      
      
      
      
      ~linkedEntity="Account",
      ),
    ],
  )

  let entityHistory = table->EntityHistory.fromTable(~schema)

  external castToInternal: t => Internal.entity = "%identity"
}

let userEntities = [
  module(Account),
  module(Approval),
]->entityModsToInternal

let allEntities =
  userEntities->Js.Array2.concat(
    [module(InternalTable.DynamicContractRegistry)]->entityModsToInternal,
  )

let byName =
  allEntities
  ->Js.Array2.map(entityConfig => {
    (entityConfig.name, entityConfig)
  })
  ->Js.Dict.fromArray
