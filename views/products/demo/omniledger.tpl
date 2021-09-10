<a href="https://wookiee.ch/columbus" class="tab-link">
    OmniLedger Demo
</a>

<p>OmniLedger has already been used for a number of years, and there are a lot of projects that
    interact with this blockchain.
    Together with the <a href="https://dedis.ch">DEDIS</a> lab, C4DT is running a test-network
    since March 2019, and it is used on a daily basis for different services.</p>
<p>This page of demonstrators shows a list of applications that show what you can do with
    OmniLedger and Calypso. In addition to this, there are two pilots which have been created with
    an actual use-case in mind.</p>

<h3 id="columbus">Blockchain Explorer</h3>
<p>In order to inspect what is happening on a blockchain you need a blockchain explorer. It can
    show you pas transactions that happened on the blockchain and allows to understand how a blockchain
    works. The blockchain explorer <strong>Columbus</strong> developed by the DEDIS lab also shows the
    structure of the blockchain with the different forward-links that allow to navigate more
    efficiently between the blocks.</p>
<p>If you visit the <a href="https://wookiee.ch/columbus">demo-page of the blockchain explorer</a>,
    here is a list of things you can do:</p>
<ol>
    <li>Clicking on a block (1) will display the contents of this block in the blockchain.
        In (2) you can find the time of creation of that block, together with the <i>height</i>
        indicating how good this block is connected. The list in (3) shows the transactions that
        are stored in this block.
    </li>
    <li>In the entry-field (4) you can enter a block-number that will be displayed. If you enter
        <strong>1</strong> and press enter, the explorer will display the first block of the chain,
        which has been created in March 2019.
    </li>
</ol>
<img src="../../../resources/products/images/omniledger/demo-columbus.png" class="center" style="width: 100%"/>

<h3 id="status">Node Status</h3>
<p>The simplest demonstrator is the <a href="https://status.dedis.ch">Node Status</a> page which
    simply shows the nodes that are part of the blockchain, and which of them are currently running.
    Our implementation of OmniLedger uses Proof-of-Authority for the node governance, which avoids
    wasting energy to decide which nodes can be part of the network.</p>
<p>
    <img src="../../../resources/products/images/omniledger/demo-status.png" class="center"
         style="width: 75%;"/>
</p>
