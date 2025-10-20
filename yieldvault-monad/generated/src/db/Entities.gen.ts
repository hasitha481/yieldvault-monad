/* TypeScript file generated from Entities.res by genType. */

/* eslint-disable */
/* tslint:disable */

export type id = string;

export type whereOperations<entity,fieldType> = { readonly eq: (_1:fieldType) => Promise<entity[]>; readonly gt: (_1:fieldType) => Promise<entity[]> };

export type Account_t = { readonly balance: bigint; readonly id: id };

export type Account_indexedFieldOperations = {};

export type Approval_t = {
  readonly amount: bigint; 
  readonly id: id; 
  readonly owner_id: id; 
  readonly spender_id: id
};

export type Approval_indexedFieldOperations = { readonly owner_id: whereOperations<Approval_t,id> };
