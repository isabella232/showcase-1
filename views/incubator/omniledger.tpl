<h2>Blockchains</h2>

<p>The hype of blockchains is still ongoing, and so it is important to understand where
    and how they can actually solve problems.
    The most important question to ask before using a blockchain is the following:<br>
    <i>Is there a single trusted legal entity to solve my problem?</i><br>
    If the answer to this question is <strong>YES</strong>, then you don't need a blockchain.
    An example is a bank account, where you do trust your bank to hold your money.
    Or health certificates, where you trust the state to hand them out correctly.
    On the other hand, if you don't want or cannot trust a single entity with your problem, then a blockchain
    can be a good solution.
    Examples of this include money transfers if you don't trust any bank, or authentication to services
    without trusting only one (like Google or Facebook).<br>
    Most blockchains, including OmniLedger, are based on the following principles:
</p>

<table border="0">
    <tr style="vertical-align: top;">
        <td width="33%" style="padding: 1em;">
            <h3>Decentralization</h3>
            <img src="/resources/incubator/images/omniledger/decentralized.png" width="33%"
                 style="float: left; padding: 1em;"/>
            Blockchains got a lot of publicity under the name of <strong>Bitcoin</strong>.
            For some it is a source of great wealth, for others it is a synonym for a lot
            of wasted energy. Few remember the origin of Bitcoin, which is about
            <strong>decentralization</strong>.
            Decentralization means that there is no central entity, but that the responsibility
            is spread out over several entities. In the example of Switzerland, one could
            say that the organization in cantons leads to a decentralized government.
        </td>
        <td width="33%" style="padding: 1em;">
            <h3>Transactions</h3>
            <img src="/resources/incubator/images/omniledger/transaction_general.png" width="33%"
                 style="float: left; padding: 1em;"/>
            <img src="/resources/incubator/images/omniledger/transaction_money.png" width="33%"
                 style="float: right; padding: 1em;"/>
            <br clear="left"/>
            A transaction is what is stored in a blockchain.
            In the case of Bitcoin, transactions describe the <strong>movement of money</strong>
            between different parties.
            Instead of having a central bank deciding which money transfers are valid,
            Bitcoin spreads this decision over many computers that have to agree on which transfers are valid.
            A new kind of transaction that is gaining traction in 2021 is Non Fungible Tokens, or
            <a href="https://en.wikipedia.org/wiki/Non-fungible_token">NFTs</a>,
            which represents the digital ownership of a physical object.
        </td>
        <td width="33%" style="padding: 1em;">
            <h3>Consensus</h3>
            <img src="/resources/incubator/images/omniledger/distributed-ledger.png" width="33%"
                 style="float: right; padding: 1em;"/>
            There are other blockchains than Bitcoin, but they all solve the problem of
            <strong>consensus</strong> for decentralized systems. Reaching a consensus between
            different entities is not easy, as some of the entities can try to cheat.
            So the conception of blockchains always takes into account that some of the
            participants will try to cheat. If too many are cheating, the consensus will fail,
            or invalid transactions might get accepted, leading to a failure of the
            decentralization.
        </td>
    </tr>
</table>

<h2>OmniLedger</h2>

<p>
    When building blockchains, there are a number of technical challenges to overcome.
    OmniLeger solves the following challenges:
</p>
<ul>
    <li><strong>Speed</strong> - if many people want to use the system, it needs to be fast. Speed is measured
        in two ways: transactions per second, and confirmation delay
    </li>
    <ul>
        <li><strong>Transactions per second</strong> - define how many money transfers can be processed by the system.
            VISA can process up to 10'000 transactions per second (tps), while Bitcoin can do about 7 tps.
            OmniLedger creates interdependent shards, so that the speed of the overall system
            can go well beyond 10'000 tps.
        </li>
        <li><strong>Confirmation delay</strong> - how long you have to wait to be sure your money transfer arrived.
            VISA takes about 5 seconds, Bitcoin takes about 1h. OmniLedger transactions take between 2 seconds and 1
            minute.
        </li>
    </ul>
    <li><strong>Attack resistance</strong> - if you receive money in the system, you want to make sure it
        stays there, and does not disappear all of a sudden. OmniLedger can prove that even with its high throughput,
        it is still safe and will not allow an attacker to spend the same money twice.
    </li>
</ul>
<p>
    In addition to these challenges, we implemented
    <a href="https://factory.c4dt.org/showcase/labs/DEDIS/calypso">Calypso</a>,
    which is a <strong>Secret storage</strong> service.
    This is needed, because today's blockchains are often world-readable, so it is important
    that you still can store secret data without everybody being able to read it.
    Calypso is not part of the original OmniLedger paper, but uses the
    OmniLedger blockchain implementation.
    </li>
</p>

<h2>Links to demos</h2>

<p>OmniLedger has already been used for a number of years, and there are a lot of projects that
    interact with this blockchain.
    Together with the <a href="https://dedis.ch">DEDIS</a> lab, C4DT is running a test-network
    since March 2019, and it is used on a daily basis for different services.</p>

<ul>
    <li><a href="https://wookiee.ch/columbus">Blockchain Explorer</a> -
        as our test network is public, you can explore the blocks to see the latest transactions.
    </li>
    <li><a href="https://status.dedis.ch">Node Status</a> -
        here you can see the status of the nodes running in our test network.
    </li>
    <li><a href="https://login.c4dt.org">Login Service</a> -
        this service is used by C4DT and its partners as authentication service to the internal
        pages. If you're interested, get in contact with <a href="mailto:linus.gasser@epfl.ch">Linus Gasser</a></li>
</ul>

<p>For more technical references like the paper describing OmniLedger, you can have a look at the
    <a href="https://factory.c4dt.org/showcase/labs/DEDIS/omniledger">showcase entry</a>.</p>
