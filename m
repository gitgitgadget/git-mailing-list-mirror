Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F561F404
	for <e@80x24.org>; Thu,  4 Jan 2018 21:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeADVCk (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 16:02:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:62175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752690AbeADVCi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 16:02:38 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MSIf1-1eM2UB1Gg7-00TR3u; Thu, 04
 Jan 2018 22:02:36 +0100
Date:   Thu, 4 Jan 2018 22:02:36 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Fwd: Unknown option for merge-recursive:
 -X'diff-algorithm=patience'
In-Reply-To: <CAJs94Eakp6kaD=+imH2cZdB-=2NCBJNu0Rt=MmRtWiM60QGBSA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1801042201390.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <9e4ffb63-59de-a020-fee8-6cefae3b3dda@gmail.com> <CAJs94Eakp6kaD=+imH2cZdB-=2NCBJNu0Rt=MmRtWiM60QGBSA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vBWws/UFKNZw/9jsF14CNBzcInbXJevR13F84kE9ecIiEI8ZkCp
 Ij3JanSbddC8JOR8HsUjLIXVwKJgnwxhxNTfG3VpxXNinwyRJ2H27LN2lw9SPZfG4EOt48w
 hg76l7uRqXk/nAZoAXu7mpJI3d9BXdUz77azVjhIDthOUk2kh225xBOz1CDQNM7Nq60BAEa
 GwUUsB/TmHozwW3XFpRBA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X4NAOPqftjE=:vTmQ6Yp9/cX4g8znFW3rNt
 JUCfPIdJO6zqVU7B3FdpvDveMaMz6jc40S2BNlSyPiRWZqE/bCYst6ttmKILnysBX0HwhMqGT
 2t3cOFkzlOxrMzgwne3xzFwW9c7cqBuUVvhboINeS1DHyNtS7iQ9RT5WIBYlbyF2+3BF5oyTx
 owMpArexC6tiH22umsiRXeoML4dvXgnIibzPyurMQeTs/fkvMWHSbzShAYqRl79gP7lcun5tj
 uW27qkES9Kn9zePJxOmCiwBe2DE/eA54GSaBupsc4ocHYg10LPqSwWneN5M/9mIHAsKNfvj/v
 f/1wOa5zOqajJOPjEVVqdvHxNz8Og9vu1gq/rAcn6ZsHOdl3Me8c6wntssrnGgiGxd6cGXKgC
 ayd+jQm46XDHGpnPN9tlkXwfLmnkgli3A7jtYTOEnNYbopqcfgSxSn1tzV269aH3qXvrsaoCl
 iSHF+jjoelAIkLXNF9Dh6BbxM4ugVczJoupwcrbgK+LmFTvgmupchgWW7/uhtqtLElRpsqwRf
 jN2ECkeSoZnJuqwlKzzp29I76IhTEOxMml6h+aqcs+JULHIB4uzTM+fX+d2CnChg9OLBcMsGA
 qzK4f1vSasO10I7DzEWs3Zq10Smp3Mh6/IaDvrkvo7h1llnTIMO8KgR3VlfgZ4ek+bzgsD874
 e/ZC5/hpF9uJ/Ioheg+jmBWZIJy7rrtU2Y+A4ePf0QFE3tKBXH+m0XlbbneJvES9tdmHSGXDt
 nvZ8PcT8IazhTfJsU9yRgNRNR1iBSKSqeHOuGwxj5VDLP92AviRoMNJQ22k6MYYJT8SE5QMz8
 YCiIRC122BHmt0rLMGvLgfBTC6Ish5nq8XSp5lX9F+0BpmRhN+TgOp+O1zEon3joXDn7Eyk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matwey,

On Mon, 1 Jan 2018, Matwey V. Kornilov wrote:

> Hello,
> 
> I am running git 2.15.1 and facing the following issue with linux kernel
> tree.
> 
> # git checkout v3.8
> # git branch abc-3.8
> # git checkout v3.9
> # git branch abc-3.9
> # git checkout abc-3.8
> 
> Introduce new commit on top of abc-3.8. Here, I edit README.
> 
> # vim README
> # git commit -a -v
> [abc-3.8 4bf088b5d341] Hello world
> 
> Then I try to rebase abc-3.9 on top of abc-3.8 as the following:
> 
> # git rebase --preserve-merges -s recursive -Xdiff-algorithm=patience
> --onto abc-3.8 v3.8 abc-3.9
> 
> And then I see:
> 
> fatal: Unknown option for merge-recursive: -X'diff-algorithm=patience'
> Error redoing merge e84cf5d0fd53badf3a93c790e280cc92a69ed999
> 
> Attached here is GIT_TRACE=1 output.

Funnily enough, this had been reported on the Git for Windows bugtracker,
and somebody even found the culprit:

https://github.com/git-for-windows/git/issues/1321#issuecomment-337279119

Sadly, I lost track of this. Will prepare a proper patch right now.

Ciao,
Johannes
