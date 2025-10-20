/* TypeScript file generated from Handlers.res by genType. */

/* eslint-disable */
/* tslint:disable */

const HandlersJS = require('./Handlers.res.js');

import type {ERC20_Approval_eventFilters as Types_ERC20_Approval_eventFilters} from './Types.gen';

import type {ERC20_Approval_event as Types_ERC20_Approval_event} from './Types.gen';

import type {ERC20_Transfer_eventFilters as Types_ERC20_Transfer_eventFilters} from './Types.gen';

import type {ERC20_Transfer_event as Types_ERC20_Transfer_event} from './Types.gen';

import type {HandlerTypes_eventConfig as Types_HandlerTypes_eventConfig} from './Types.gen';

import type {chain as Types_chain} from './Types.gen';

import type {contractRegistrations as Types_contractRegistrations} from './Types.gen';

import type {fnWithEventConfig as Types_fnWithEventConfig} from './Types.gen';

import type {genericContractRegisterArgs as Internal_genericContractRegisterArgs} from 'envio/src/Internal.gen';

import type {genericContractRegister as Internal_genericContractRegister} from 'envio/src/Internal.gen';

import type {genericHandlerArgs as Internal_genericHandlerArgs} from 'envio/src/Internal.gen';

import type {genericHandler as Internal_genericHandler} from 'envio/src/Internal.gen';

import type {handlerContext as Types_handlerContext} from './Types.gen';

import type {onBlockArgs as Envio_onBlockArgs} from 'envio/src/Envio.gen';

import type {onBlockOptions as Envio_onBlockOptions} from 'envio/src/Envio.gen';

export const ERC20_Transfer_contractRegister: Types_fnWithEventConfig<Internal_genericContractRegister<Internal_genericContractRegisterArgs<Types_ERC20_Transfer_event,Types_contractRegistrations>>,Types_HandlerTypes_eventConfig<Types_ERC20_Transfer_eventFilters>> = HandlersJS.ERC20.Transfer.contractRegister as any;

export const ERC20_Transfer_handler: Types_fnWithEventConfig<Internal_genericHandler<Internal_genericHandlerArgs<Types_ERC20_Transfer_event,Types_handlerContext,void>>,Types_HandlerTypes_eventConfig<Types_ERC20_Transfer_eventFilters>> = HandlersJS.ERC20.Transfer.handler as any;

export const ERC20_Approval_contractRegister: Types_fnWithEventConfig<Internal_genericContractRegister<Internal_genericContractRegisterArgs<Types_ERC20_Approval_event,Types_contractRegistrations>>,Types_HandlerTypes_eventConfig<Types_ERC20_Approval_eventFilters>> = HandlersJS.ERC20.Approval.contractRegister as any;

export const ERC20_Approval_handler: Types_fnWithEventConfig<Internal_genericHandler<Internal_genericHandlerArgs<Types_ERC20_Approval_event,Types_handlerContext,void>>,Types_HandlerTypes_eventConfig<Types_ERC20_Approval_eventFilters>> = HandlersJS.ERC20.Approval.handler as any;

/** Register a Block Handler. It'll be called for every block by default. */
export const onBlock: (_1:Envio_onBlockOptions<Types_chain>, _2:((_1:Envio_onBlockArgs<Types_handlerContext>) => Promise<void>)) => void = HandlersJS.onBlock as any;

export const ERC20: { Transfer: { handler: Types_fnWithEventConfig<Internal_genericHandler<Internal_genericHandlerArgs<Types_ERC20_Transfer_event,Types_handlerContext,void>>,Types_HandlerTypes_eventConfig<Types_ERC20_Transfer_eventFilters>>; contractRegister: Types_fnWithEventConfig<Internal_genericContractRegister<Internal_genericContractRegisterArgs<Types_ERC20_Transfer_event,Types_contractRegistrations>>,Types_HandlerTypes_eventConfig<Types_ERC20_Transfer_eventFilters>> }; Approval: { handler: Types_fnWithEventConfig<Internal_genericHandler<Internal_genericHandlerArgs<Types_ERC20_Approval_event,Types_handlerContext,void>>,Types_HandlerTypes_eventConfig<Types_ERC20_Approval_eventFilters>>; contractRegister: Types_fnWithEventConfig<Internal_genericContractRegister<Internal_genericContractRegisterArgs<Types_ERC20_Approval_event,Types_contractRegistrations>>,Types_HandlerTypes_eventConfig<Types_ERC20_Approval_eventFilters>> } } = HandlersJS.ERC20 as any;
