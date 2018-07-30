Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6EB1F597
	for <e@80x24.org>; Mon, 30 Jul 2018 14:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbeG3QV0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 12:21:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:39141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbeG3QV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 12:21:26 -0400
Received: from [192.168.0.129] ([37.201.193.26]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrrRi-1g6sTN04n0-013dfx; Mon, 30
 Jul 2018 16:46:03 +0200
Date:   Mon, 30 Jul 2018 16:46:01 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/9] vscode: hard-code a couple defines
In-Reply-To: <20180723174108.GA9285@aiede.svl.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.1807301643200.10478@tvgsbejvaqbjf.bet>
References: <pull.2.git.gitgitgadget@gmail.com> <3770bd855c6f3e69acfe418ea7fe5b40454e4dfb.1532353966.git.gitgitgadget@gmail.com> <20180723174108.GA9285@aiede.svl.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ADU2bnPEEsK+hcTACMMEgEtrrYHBwEkyiOrBvbGSxAR17o6bA5j
 LqFHUUdAZedXrufNjPG53AheTEm28UZFNAU1UyTPVTUK1JudzJCm/pCx/lEHS0Kvlq5tcJC
 B+vrlfIiYnwTohqcd/23g6RTA07W406Q6E46lySTvxcttWmiLYMzrDd37eBgOck8NIGiWWo
 YlztVtEvoiNCkH5u36nFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MtHazdW6iVg=:U4yE30zKKs4vsLPnKEozH2
 add6O3D3Y0vhphKhPQOcMcgJR4fyR1Vzl88wtQAFDAJQRzKcqQvH+zDcvfW+yKVQ9CeUURZY/
 XjXDsRoV3O1j2qyAtl2CqVNDtolPwBY22r6zWO9N8ijFL4BOr/XbcvWdk9TVYKb3YhTC3HiXV
 YoseaWUH1n06NJvFKn1Voc52mXu32DuC4vmuiL1yQa8KT08Ifk+8SkTRRP9uZFu+X2+/2meYi
 6yGx6sHxLSIZNcz6zdKexH69GYxND0ntglDLoXleUWj01cG2NqPhzMPyk04GSFJLawd/hZVbu
 GDL7FK6oJzPm2XA+jVxRpN9X6i0TypXFrZLi6gYL4qB4JkwQugr7HKzSm1A0mcAH7lwei7JR9
 Oh2JPvc4P00PtZKPdhTTpvMLCrdzbDL8Bkk+ZyxmH9Y/skYZaKla5EuRtXzP+PfrhTo6fkHLf
 TRm18JWPKJuKUhb42JxFaWOtSp3cMhTw3foM8ynB9xV8/vBwPfjrne6dN0Zk5kn++Gou82UU3
 nS6nT5gND7JdXcvMCym+F6SfSn9+HKmAglRU/33qrqnBytwY4IcLfshkke9qoOrCD0Hl2P5AM
 /t6lRrFdSfzhve+UjVozzFRnQkF7kYDK1xbAlYyctho+GbaTNFetkr+HjID1mSVorYMq2l8fD
 TZtUZ72e5ZX5b3FtgdvtTHKPKvNQ/oFdKRolOjWzWz9ueY8gwdbnElTH7HkvfCoDlsdsijp0k
 9G4zh9dMfAnn9AIayJC7tbefSwfzRbnxY3P2zRMUXUpe44oYZOnCH2Hhg7faUjJzpE2+/h2PU
 PXW6r3v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Mon, 23 Jul 2018, Jonathan Nieder wrote:

> Johannes Schindelin via GitGitGadget wrote:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Sadly, we do not get all of the definitions via ALL_CFLAGS. Some defines
> > are passed to GCC *only* when compiling specific files, such as git.o.
> >
> > Let's just hard-code them into the script for the time being.
> 
> Could we move these to ALL_CFLAGS?  Is there any downside other than
> increased rebuilds when options change?

I assumed that it gives us a bit more liberty at using names for constants
that might otherwise be too general.

I did not even consider the rebuild time, but that's a good point.

The idea to move those definitions to ALL_CFLAGS sounds good to me, yet I
am loathe to introduce this into a patch series that is not about
far-reaching design decisions at all, but merely about making a decent
tool available to the finger tips of all Git contributors.

Read: I think this would make for a pretty good micro-project, maybe in next
year's GSoC (assuming that it happens and that we're accepted again).

Ciao,
Dscho
