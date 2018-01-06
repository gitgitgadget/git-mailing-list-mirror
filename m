Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4D01F406
	for <e@80x24.org>; Sat,  6 Jan 2018 12:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbeAFMNK (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 07:13:10 -0500
Received: from mout.gmx.net ([212.227.17.20]:58686 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751613AbeAFMNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 07:13:09 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGRhs-1ec8w70RiS-00DEAc; Sat, 06
 Jan 2018 13:13:07 +0100
Date:   Sat, 6 Jan 2018 13:13:06 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Matthew Orres <matthew.orres@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Git 2.15.0 on OSX 10.12.6: gui multi-select stage
In-Reply-To: <CAKbB5OwoO22vA3r9J9WAgzxGGScyDE7xM+msGCU_qn2XHU+nbQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801061311250.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <CAKbB5OwxQ4XtLXuu2w3QmuKryA=3iHupz=y0m2E1NH+Dwzd8Xw@mail.gmail.com> <alpine.DEB.2.21.1.1711012254380.6482@virtualbox> <CAKbB5OxZ1Mua0zNMpe8nt8cQbasUyfz0uNzOXL9FJXWrsqPN-g@mail.gmail.com> <CAKbB5OxFTycBVhzyow9Op2M=HcBWKhLEii-putehS0ONNw=W=A@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801052240440.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <CAKbB5OwoO22vA3r9J9WAgzxGGScyDE7xM+msGCU_qn2XHU+nbQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:chbXhTjVaKyAyv0bQd4HRWVpc6d5WrZhXrL3cREzYC8RdyEwHfZ
 +fjP2fZH9tPpK0MGngnUW3zLZkOBQSrMC2L+FWbJggPGDL8mY2GF+48JTmnrj7G9ysmOoe0
 tViqr4cRbZExT8aatpvIflOsVlM7Yh8RnmGRreZ8MxGKZqA+YLyC2dwoaSJzmD4+FyyVZih
 6QvGNqzi8nm8KMZNQEyvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MP5Vryt/aPk=:/P9YEwhk5ZTTbHyUj1PYkW
 nx++Uqz8h9pITS14Uk69KLSDEVAfmcPX6tnELm2zQfguW/e1nhkjIMVms++IBF6wuk+XFO9g6
 0OMUmWqNqGbuQxOBInvl2uEdNvnvQlkI74UkfUpRH10fXETOVlQJG3NSHqWxYttGNiP4Lmu3l
 hlgsHnCZSng9QahvG9kqd7cb6bl0/AzIoKthdaBPNlgGa/LDrGIx5ICtpaTIX+Oij/b5Kjzj3
 2kkRP7BuyGQLv+PJjL/J+Rbbb1CKiPM3NFe0jyxpa8+k7/hlSYUvRru0CXjSYC+R7L3ko6gBU
 2e0aE3StR7C9VXu/lRcBfZMz+an7eBkJcbt0wn+iSghBm/0lTiCZQeXhlt4kGiwKgC9vqHC74
 0gfDeBErO9WsDAzCTh1JWCOFDKAVPAvsQac2VENtaeXnwSbnmJM4/TOYSeOwBD4TkYhMf6KAo
 FTBXcr7QcFiki838O8Y+vSRvxqZ7L7QLfPKrWb2gUbbxes1VHwgdYx5wCPbPTq4d8nKnuEZ+5
 VGmqsbPsK0oi+/I06wOlcnfsUr5OAVsl4qNvCf6g2FxsJ0TZ6O3DPXpdlBHjcn5PeRZSlfVxD
 MGEvM80LDhxfmAvqEqwuw8ATZyVyrcBvp7A2F5fulk13iQbW0P+5XOaMQnVKmy7GRHiE/8nEv
 eYZ4VCdlBxphBXge+p0QQbm+Tztjj/kM4TnM6mtLGHoth3ZlyWjWePVwwVXjVacRx4NjL70YL
 d6LQf5or95pNDS36Q9vfsjqtDtO7srRwdF94vfX6MwCkwQ6mNrVJDAE+X6OqoioU/SEmgvaVr
 tsoHsyok39UNLatNC6AHyM4oUGBj0RN9RZV3qSR9FAwQ64bju4MtMTLqo1NflBtl0Ge4cB6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matthew,

On Fri, 5 Jan 2018, Matthew Orres wrote:

> Beautiful!
> 
> Pulled down that commit, was able to build and can confirm the issue
> is fixed in git gui!
> 
> This has been a thorn in my side, so I appreciate your help! I look
> forward to it being included in the next release for git in Homebrew!
> :)

Well, a little bit more help from your side would be nice. For example,
you could report back *to the Git mailing list* that it helped you.
Otherwise, how is the Git maintainer to know that these commits help
anything?

Also: it is *quite* late in the release cycle right now. We are at
v2.16.0-rc1, there will be one more release candidate in the coming week,
and then the final v2.16.0 in the next week.

I highly doubt that the patches (which I still have to identify) will make
it into that release.

Ciao,
Johannes
