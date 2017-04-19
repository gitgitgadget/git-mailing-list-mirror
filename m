Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 016271FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 07:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760645AbdDSHuS (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 03:50:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57688 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760381AbdDSHuR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 03:50:17 -0400
Received: from skimbleshanks.math.uni-hannover.de ([130.75.46.4]) by
 mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MBO57-1cqbTU0UuT-00AD8d; Wed, 19 Apr 2017 09:49:17 +0200
Subject: Re: Draft of Git Rev News edition 26
To:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ted Ts'o <tytso@mit.edu>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        "Bernhard E. Reiter" <bernhard.reiter@intevation.de>,
        Werner Koch <wk@gnupg.org>,
        Peter Lebbing <peter@digitalbrains.com>,
        Christian Neukirchen <chneukirchen@gmail.com>,
        demerphq <demerphq@gmail.com>
References: <CAP8UFD3G_m1q6tORDRpfqWXQwrtpx-xQTqxfj0K=xU5WdEC+uw@mail.gmail.com>
From:   Michael J Gruber <git@grubix.eu>
Message-ID: <40c969f2-636e-f977-e385-d490f37f0ffa@grubix.eu>
Date:   Wed, 19 Apr 2017 09:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD3G_m1q6tORDRpfqWXQwrtpx-xQTqxfj0K=xU5WdEC+uw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:OBXzitEGnfc5FqU7tAg1/TTpyalW7/L9HLdikg5wYeEnbu8F3Ht
 ZtsEih84HgKMcbAZ3jMhNv8UoEpqHcf+e3+FktQK3ZkinhR9fbugMQDDJbrX5tiULXQs2vY
 blJfxP5SzYOZunGUsJ9qN+1QzxMdEdBj0q+0rDHGA0RfsBtRZptaecFKkrZ1HcNP13+PoDr
 gMPP51xGe1lluklH6qwUw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8MWaa+wNbts=:QuSWb8LoXzVOfVGnQjdrHg
 ton/QcwL4KagCcL6WvBjOPPI+5Lr3/8p59cTMMEIo0Fnk2HiLs7ed71dL27CXRaNoXvNFSyd+
 ICUmG3CTfyfa1PRdx2KHD8C9FVVXQZnM4Q9LAvB5iVdr3nsKyoa8vphciGr9VUK5VmSD4S+R4
 aXbpFd9dhA9yZpCOdK+TfutZujAmGSqoYPLMGXMQnJ4EDXr0rh5i5i11aEDyOeLOTT7ZsK09O
 RlDuU6y5VYuWY1E4nWAK66cv6PuaybQzvD6VSbqW16x98ryAeMRMNX/ubAqBJ5CHrYp59/fQ5
 79bdzdSjokmkg4zWT+0K/rkIt91E6wciJnKLe99kMCLiqe4YyYqnTWMVIAdiYU1ZB0bi9xyVf
 8ZSgBKu2NCv5wxtofhoOWyBJNoE8m37HhZgkQojFbheLBvvMdyTw11wF8wvD2WsC+D5nemFgx
 KqQbfe3tKFQznYrSlaj3aughWyjA8kn/K8AlLUG6UuSp5/ZQv9RjgNl+BkSJ3+k/SX3pU+YJM
 0DS/nSdsjpHIelOlq3nwdA4wi+o/ixQqCJnrRRbpftIz8b0pbn8ChWGKLd7zfkTLRd/3rQWg/
 Xnvsu+cZdUr68mZzhj/zv8nfRzgcSXux7mNvIQGQI88uXDkmGdfs1pF6c2gvb/YVHvaZWXnm+
 TOgXK3TVg6tJrLpzZjbh0O9E57UYZGaK6NCsEhx7ckT7J8ZqF2udY62PWOcRcwYT45g5GWSA0
 41XFhPThipQWKnVM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder venit, vidit, dixit 17.04.2017 16:33:
> Hi,
> 
> A draft of a new Git Rev News edition is available here:
> 
>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-26.md
> 
> Everyone is welcome to contribute in any section either by editing the
> above page on GitHub and sending a pull request, or by commenting on
> this GitHub issue:
> 
>   https://github.com/git/git.github.io/issues/238
> 
> You can also reply to this email.
> 
> In general all kinds of contribution, for example proofreading,
> suggestions for articles or links, help on the issues in GitHub, and
> so on, are very much appreciated.
> 
> I tried to cc everyone who appears in this edition, but maybe I missed
> some people, sorry about that.
> 
> Thomas, Jakub, Markus and myself plan to publish this edition on
> Wednesday April 19th.
> 
> Thanks,
> Christian.

Hi Christian,

Thanks for the ping on the draft.

Re gpg: Maybe some valuable point of information is what Werner Koch
himself said in that thread:
"That [the command line is not a stable API to GnuPG] is not true.  The
command line interface has been stable for the
last 19 years.  We only removed a left over PGP-2 backward compatibility
in 2.1 (-kvv).  I doubt that this has even been noticed."

I think our conclusion was that on Git's side, there is no problem to
solve (except, maybe, to use gpg2 by default when gpg is not installed)
because the main problem is mixed installations of gpg1 and gpg2.1+, and
we don't want to use a library instead of the command line API for the
reasons mentioned by Linus and others.

Michael
