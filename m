Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BC920954
	for <e@80x24.org>; Sat, 25 Nov 2017 22:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751501AbdKYWRU (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 17:17:20 -0500
Received: from mout.gmx.net ([212.227.15.19]:65230 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751395AbdKYWRT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 17:17:19 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiTJE-1eqfzy1quq-00cfdt; Sat, 25
 Nov 2017 23:17:14 +0100
Date:   Sat, 25 Nov 2017 23:16:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
cc:     Phil Martel <pomartel@comcast.net>, git@vger.kernel.org,
        git-for-windows@googlegroups.com
Subject: Re: Problem installing Git
In-Reply-To: <f30c4350-500a-44e8-27ee-7d5ae49903c4@gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711252312270.6482@virtualbox>
References: <077942bb-5952-6f4a-8054-b17d3883b901@comcast.net> <f30c4350-500a-44e8-27ee-7d5ae49903c4@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kqsmMAk2gt4zTJpsvldjK4W6MqMTNVUob9efSw4jiDK9mQsFL1/
 fga4g9nQUy+3slMnUG1p2joZSq19eTFE6jX39GFjAwe8DY6dr46bVnp4EqXIbMrFD10RpAi
 Gj1IjbfHq0ckkxH5JDRqzsyqxYfSN6DbovBnX045oPPtypCRsxR0R8ZYpetixcCUqMwgGN0
 s7ohj8qIUrj3JhstIm1+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wydyLNcN8Cc=:4AcWrSfWMg+0objtlN697M
 e+ZlS799AC0YYqvWxd7ML2HwsJ7UGUM5pUOhmjk0lcTAbkshvQngp3jT3yBlwCv1ovroSBLZl
 3i9a27SL2bIBwFeCJalNi+O4piM3k7ixtx34eq9uafXJIyTBi2VmB98WzGPiIhbuDOLvTTYJm
 rt4mXgTmwq+e7hG0b6OqtyTp4Q/bbLtYoDR/H5Xlu1dXgf20ZpA1IVYXJmNJP3jXdxk2o8QWs
 XpjWJvZCmlXAqLLr1AV9JKXH6HHrfwD9PcWbpMORAMJ2xk46HWgIPw3GMD0zDw5MSH3m1zJ87
 edUS1DRP2smQjCj88EBI+oFFltkiC/rLNV+f3LYuCadYQsgNGpFh89fZV6EAz8aWCBgg1XEmY
 h0vOCgxghGgc1DVhxrLR6vAqd7IsHprEhhxgq98N/0FM9ORZYwgvqAZ9dUlMzctdqRcIzoJcG
 pqx0biuy8OySeFJzgn1EpN9yvXPTnpyT0xm6j2N3IqbJdaKK9ESx7OxvQIzLvEzo65ffPpYFI
 r2Q1tlG76TTgPC406DNR0J806aCz8GdnXROE7HW3t4/AEjevzu8MVN7OKCW9ipLH8xjkQboU/
 40b4l4Ews0dnM6uOAXwTUkoabI/oiZULiLeI7WXXvFFZ8LPhYmGIE4mTekv+SOuHDOUq8ClXB
 e6kUQfGQLTNp4ppuHlIeDF9+CSZtqR0/b60zXkVcA9U4aColktNVcTJ5YIcTlyrDMupHMp86k
 fE+xI5u/AYXw0Zre36s+5aQTtFWyzERbP4JcE8AhZl+mkF7ItnilV+NtUsgVabozSKHgFLRyA
 h7Hx07loVloubJ7Cva2xkotO2St9f+h5Ywi1LMaqrHS2bgnTD9yyOax8fSio+K9DGGr5xE/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Igor,

On Thu, 23 Nov 2017, Igor Djordjevic wrote:

> [ +Cc:  Git for Windows mailing list ]

I have no idea why it claimed that that group does not exist, the email
address looks correct to me.

> On 23/11/2017 19:51, Phil Martel wrote:
> > I'm trying to install Git-2.15.0-64-bit.exe onto my Windows 10 
> > machine.  When I run this installer program no matter what options I 
> > try or whether I run as administrator it ends up with an error box 
> > saying "The drive or UNC share you selected does not exist or is not 
> > accessible. Please select another".  I do not see any way of 
> > selecting a drive.  Any suggestions?
> 
> From what I could Google around, this seems to be (Inno Setup?) 
> installation related issue...?

Indeed.

> Do you already have "Git for Windows" installed? If so, does it work 
> if you try uninstalling it first?

That is a workaround, correct.

> p.s. Note the existence of "Git for Windows"[1] specific mailing list 
> as well, where this issue might belong better.
> 
> [1] git-for-windows@googlegroups.com

I think a much better place is the Git for Windows bug tracker (if you
ever wonder where the bug tracker is, or the home page, or the repository
or the FAQ, there are links in the upper left of the release notes --
which probably nobody reads, even if I really try to make them worth the
while -- and which you can find in C:\Program Files\Git\ReleaseNotes.html
if you closed the tab after installing Git for Windows).

And indeed, there is already a ticket for this issue:
https://github.com/git-for-windows/git/issues/1074

The original reporter did not respond to any questions, maybe you can do
better, Phil?

Ciao,
Johannes
