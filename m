Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85EB11F406
	for <e@80x24.org>; Sat,  6 Jan 2018 12:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbeAFMUM (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 07:20:12 -0500
Received: from mout.gmx.net ([212.227.15.18]:59258 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbeAFMUL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Jan 2018 07:20:11 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M7Xi3-1empQs2e5H-00xK5X; Sat, 06
 Jan 2018 13:20:09 +0100
Date:   Sat, 6 Jan 2018 13:20:09 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@johannes-schindelin.gitforwindows.org
To:     Matthew Orres <matthew.orres@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Git 2.15.0 on OSX 10.12.6: gui multi-select stage
In-Reply-To: <nycvar.QRO.7.76.6.1801061311250.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1801061319170.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
References: <CAKbB5OwxQ4XtLXuu2w3QmuKryA=3iHupz=y0m2E1NH+Dwzd8Xw@mail.gmail.com> <alpine.DEB.2.21.1.1711012254380.6482@virtualbox> <CAKbB5OxZ1Mua0zNMpe8nt8cQbasUyfz0uNzOXL9FJXWrsqPN-g@mail.gmail.com> <CAKbB5OxFTycBVhzyow9Op2M=HcBWKhLEii-putehS0ONNw=W=A@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801052240440.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet> <CAKbB5OwoO22vA3r9J9WAgzxGGScyDE7xM+msGCU_qn2XHU+nbQ@mail.gmail.com> <nycvar.QRO.7.76.6.1801061311250.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kImuv5TRBvDAYn5aYIQNikXEJnDxNvQKjcvYgtViYTskaQXVs9q
 sF1NjSNR+48WF1ksT+FFPSBOvh6YTmi8RM9/H8hYfB9tJr3xY5SvoxTL9XxSC/ZWubonsE7
 MDt5qZPhwhNY56TfyH3nVDoih2/6sXT+EFkAMXJFpDsy3vZALJbm/vpfYAUYm5txOksF7Ml
 gxOGrMLaivRS6fmW3kb9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f6cOKxg/1jQ=:IBXYtRoGER7gNLjIGmCV92
 TpchpDMhEPRnCgOLtph6wa3OWuUep5hu26iFYxV7A5h6XksQvcT8qVpkoeA2m7cFBGu+zYsac
 uu8Xp0eReiZQZWpRqG7a4UwvQmYsmX8irK690Jf49x/t7xm1zGrfaHGVKdQdJOz5cCNvY3S9X
 /CjidspMjAK4CgECCkijOrgEisjGja2fKKVBuMcqLcHG9oPJfcJWx/SB3wfljsfrSxORUXDoU
 JMaeyKZ950mSEnmEVmzvkaAqKbWNHdIMVVOx54xAGhSkwHPzjzYiXsWvpQr9lb+HzJsls9BTv
 9X9w8ffwzdhllKV6bbClgPfh22t9rp8bsFyArUFDLAewhzLVo0cO8MSfYNfdOYT7kHL+1U09U
 DGftojX29zGmVyt9RVg3agTQsrRquG45IiQPzHA6BuyvQIsJa7A0MrPQujbiO8OG5v2tUFZs8
 YlzGmM3A+9R1Jtycmke2ghDKkWuy+Mk9ZBXc+FBpNkOVMShZddU2EtW97UVXgA5Ai+PH39RVh
 AQznyxNvPYOt8sz/BS0vATx//cDIC6mhxby7C2MuZvwqAuubg+jS3aAHfrmIcAhSA8GoGlJHT
 6b4pMrUmG/wJeOCoVVOSXJbWyYe4Vo458HIZp4cqWhwSAUm+S6wSBTPnEUclJ8y1xQPzwjur6
 TCBTQywF2PIGZ8hLDO8DnqHqRjAXGJG1fUwCwLLDvZJMz7OPq0vScdYq7d4Jsgx/AFHhoux+w
 viaSZHkct81SltCIdus4gwwLn/DlJq1FjkszdcuXvmazhH9c9qlyim23PKbAVFQICtvv/Tbwq
 6/D0/lvmtnAV5xH4GJUgMuqWks1Xif+JgVPYa5sfBMNF3wo/xHQNu6qZcOSIntcS3r7gYRh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 6 Jan 2018, Johannes Schindelin wrote:

> On Fri, 5 Jan 2018, Matthew Orres wrote:
> 
> > Beautiful!
> > 
> > Pulled down that commit, was able to build and can confirm the issue
> > is fixed in git gui!
> > 
> > This has been a thorn in my side, so I appreciate your help! I look
> > forward to it being included in the next release for git in Homebrew!
> > :)
> 
> Well, a little bit more help from your side would be nice. For example,
> you could report back *to the Git mailing list* that it helped you.
> Otherwise, how is the Git maintainer to know that these commits help
> anything?

Sorry, I probably need to take out my eyes and screw them in right, I
totally did not see that you Cc:ed the Git mailing list. Sorry.

> Also: it is *quite* late in the release cycle right now. We are at
> v2.16.0-rc1, there will be one more release candidate in the coming week,
> and then the final v2.16.0 in the next week.
> 
> I highly doubt that the patches (which I still have to identify) will make
> it into that release.

This is still true, though.

Ciao,
Johannes
