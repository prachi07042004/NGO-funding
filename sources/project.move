module NGO::EducationFund {
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;

    struct Fund has store, key {
        total_donations: u64,
    }

    /// Function to initialize an education fund.
    public fun create_fund(admin: &signer) {
        let fund = Fund { total_donations: 0 };
        move_to(admin, fund);
    }

    /// Function to donate funds to the education initiative.
    public fun donate(donor: &signer, fund_admin: address, amount: u64) acquires Fund {
        let fund = borrow_global_mut<Fund>(fund_admin);

        let donation = coin::withdraw<AptosCoin>(donor, amount);
        coin::deposit<AptosCoin>(fund_admin, donation);

        fund.total_donations = fund.total_donations + amount;
    }
}

