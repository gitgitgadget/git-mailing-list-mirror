Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D521F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966216AbeCSR2L (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:28:11 -0400
Received: from mout.gmx.net ([212.227.17.21]:53663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965803AbeCSR2J (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:28:09 -0400
Received: from [192.168.0.129] ([37.201.195.115]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ma2Lr-1fBOKP1yl5-00Lr4h; Mon, 19
 Mar 2018 18:28:06 +0100
Date:   Mon, 19 Mar 2018 18:27:48 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Yash Yadav <yashdimpu@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [GSoC] Scripts to be conversted into builtins
In-Reply-To: <67e865ac-3303-eda6-e14b-f56607d64908@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1803191814110.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <67e865ac-3303-eda6-e14b-f56607d64908@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9HYBe7c0d6RYPIRJ8QwmChYTRV3JGXtrd/62nLoVRQRhWIMNVdl
 U33B1ADNuCL5ZMEFLmi/I3qsDfBpeTzXV6ZVUm9ZA/fS3ID5AJwM8vB3ERxR3RIY6NlDLQk
 ajxnuBTX5CqI+8KFvuKMv6iw25jvVc6tydAODH0MzPrXQMad0leCHDEFIn2DzEbNAs92BV2
 Jd7ckvgCpXqrq4OG55SOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fv+vXeUpiiE=:D/0QzSD3cky307WRS/D/Z7
 Hwj6UzNpm3ACqAxlRBhQ2K6t4tL4J9Fyu2uXWC6QvoKl+BN+vS2WFghOnl/6l4+Sn8kjZ2hiU
 TpM0bbjIUNZ/lnr5jMk312KcDecrtYCxhN4ZtaSov6Oi/iz4ocX9yYNSMp5XjlVXWFALkNmvv
 rB5NOtE64ji4dqfKgI9abf2lACTVqixmjN1xAB/eek9Mzwez/u9gtaq71SxWIhjWoHWFA7z32
 CMalGibsfwXBG2dTVA1nP5oy7Iigi9UKr1hCwFI9RGsUe2odPN8ewVCVlrbFiAm9eIDf9u86n
 NH49KihpguXuyRCfe8uoRgXayr9aEzXWprVFKBjuORIeu7p8RSLLUV+IZM8SZP2wPFXrzuhSd
 CP3EiRbT9Ln89ob41M9SPuoxU3Azugzv5MeZeuFmTF5ggdzN7KuRVWrZxpY7Do4cYByad7VE6
 tPhtcvgYXJwMOkvSA0+MuFd4CtDKUcoxR+tegbIVijpAvtocAs/6+JcdEppdM0SqYQ8cvDwNe
 G1Q3RLN3Bb2Pk7PwlZOJVeqiQ8vnyLTroEu+mG3SmsAmS5LS0GhKu/3l4uKa5VOoxZqVNGSJ/
 ZRk1UPVXveH4TBcDgGj0qMIKxS0I0RMp0YaUrQfev0PTzhuH5v1qWEWGNuEJVmI1NNwcwYbLQ
 Co6RnJragfVf15h+bpAJ2Ir1yVOtNh/YA/2ruIhtjJaQkUR6Tq0aaU7Su9Z1S0+rh2ZWExD8j
 zpktIxCkU4KJXAftpqoC0Dgm/LtgfbXxWuPiBPx5jJTBfB8ijzSmQMO9ogpVX4VsvJwhrGSV4
 ziY+nzKXZQsjNoKgByAA8HoKL7g27o36xYPlTU7NK378ZK30no=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sat, 17 Mar 2018, Yash Yadav wrote:

> In the project ideas listed there is one idea talking of conversion of
> scripts to builtins. This interests me but no pointer forward is given
> and I'd like to dive more into that idea and go through the script(s).
> 
> So, where should I look further from here?

One concrete example how a script was converted can be seen here:

https://github.com/git/git/compare/b7786bb4b09%5E...b7786bb4b09%5E2

(This is the patch series that replaced the scripted version of the
`difftool` by the one written in portable C.)

But maybe you want to look at the micro-projects first, to see how you
like to work on Git's source code, and with the Git mailing list?

Ciao,
Johannes
