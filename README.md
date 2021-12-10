This project was bootstrapped with [Create Eth App](https://github.com/paulrberg/create-eth-app).

# DAO Global Hackathon Submission (Community & NFTs)
Project name: Spore
Submission Link: https://github.com/dsine420/spore
Date when work began: 11/21/21
Person of contact: Dylan Dilla, dylan@dsine.llc

## For the judges consideration
I found the hackathon towards the beginning of November shortly after it began. Despite having no Solidity experience, I decided to enter the competition and I began brainstorming dApp idea while going through different Solidity tutorials and documentation.

A week or so later, I came up with Spore. The idea behind Spore was originally something like this: A team could go onto Spore and propose a web3 project and request a payment from the community in return for making the project open source and available for anyone. If the community liked the proposal, the community would fundraise a target that exceeds the requested payment. The raised funds would be used to enter a liquidity pool or some other sort of income generating vehicle. These funds would generate passive income that would go towards paying the developers and the community. This creates a win/win/win situation. Developers get paid for their work in an income stream, community members receive new tools and passive income streams, and the community gets liquidity and new tools.

In more detail, after a project is approved, developers begin their work and both the team and the community members that contributed towards the project receive NFTs that represent a tradeable cashflow courtesy of [Superfluid Finance](https://github.com/superfluid-finance/protocol-monorepo/tree/cfa_wrapper_library/examples/tradeable-cashflow). This tradeable cashflow would be configured such that everyone receives an income flow proportionate to the amount of money they contributed to funding the project, except for the developers. The developers declare in their proposal what cut they receive.

Ultimately this project proved to be too complicated for the time frame and experience level I had. I spoke to Fran at Superfluid and he gave me the idea to make something for the "quadratic freelancer". And that is what I have submitted today. The code is incomplete but the plan here is that there would be a front end where users could browse projects and developers. This front end would interact with a Singleton "[ProjectHall](https://github.com/dsine420/spore/blob/master/packages/contracts/projects/ProjectHall.sol)". Each developer has a profile housing all of their projects. Users could open Superfluid Constant Flow streams between themselves and a developer to show their support for their work. Then users would receive content from the developers as NFTs. The developers would be able to send out different NFTs based on levels of support using the `createTokenForAllUsersWithFlow` [function](https://github.com/dsine420/spore/blob/master/packages/contracts/content/ContentToken.sol#L27). (larger constant flows => better content).

I will continue to work and develop this project as my experience deepens with Solidity. Thank you for your time and consideration!