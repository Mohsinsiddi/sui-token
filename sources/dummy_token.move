module dummy_token::my_coin {
    use std::option::{Self, Option};
    use sui::url::{Self, Url};
    use sui::tx_context::TxContext;
    use sui::coin::{Self, TreasuryCap, CoinMetadata};
    use sui::transfer;

    /// The type identifier of MY_COIN cryptocurrency
    public struct MY_COIN has drop {}

    /// Module initializer is called once on module publish.
    fun init(witness: MY_COIN, ctx: &mut TxContext) {
        // Define the coin metadata with image URL
        let (treasury, metadata) = coin::create_currency(
            witness,
            6, // decimals
            b"TK1", // symbol
            b"Token1", // name
            b"Test Token 1", // description
            option::some(url::new_unsafe_from_bytes(b"https://image.binance.vision/editor-uploads-original/9c15d9647b9643dfbc5e522299d13593.png")), // icon url
            ctx
        );

        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, ctx.sender())
    }

    /// Manager can mint new coins
    public fun mint(
        treasury_cap: &mut TreasuryCap<MY_COIN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext,
    ) {
        let coin = coin::mint(treasury_cap, amount, ctx);
        transfer::public_transfer(coin, recipient)
    }

    /// Returns the URL of the token's icon
    public fun icon_url(metadata: &CoinMetadata<MY_COIN>): Option<Url> {
        coin::get_icon_url(metadata)
    }
}