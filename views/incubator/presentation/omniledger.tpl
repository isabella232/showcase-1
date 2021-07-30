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

<h4>Links to demos</h4>

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
