Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEFF01FF72
	for <e@80x24.org>; Mon, 23 Oct 2017 09:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbdJWJnF (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 05:43:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:63662 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750811AbdJWJnE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 05:43:04 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MQ6oB-1eBE5M1IJv-005HCv; Mon, 23
 Oct 2017 11:42:55 +0200
Date:   Mon, 23 Oct 2017 11:42:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Bryan Turner <bturner@atlassian.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Users <git@vger.kernel.org>,
        git-for-windows@googlegroups.com
Subject: Re: Git for Windows v2.15.0-rc prerelease, was Re: [ANNOUNCE] Git
 v2.15.0-rc2
In-Reply-To: <CAGyf7-HCsTaqa-CC1omtT+O9A4P_SspaNZUf4UbZHcUbh71+OQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1710231140350.6482@virtualbox>
References: <xmqqr2tygvp4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1710210020290.40514@virtualbox> <CAGyf7-HCsTaqa-CC1omtT+O9A4P_SspaNZUf4UbZHcUbh71+OQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0+0nTe/DDKeuNpm/LW/A9Akc0lbysLFJTf25Yj3oKyEBcXZi/Rn
 fi3h2avE7awxeIN9hzv8CoSPFp9amE4C0p8mIbrximKQTYRu9OW0M+PEVYxgmFgGcI4eiOn
 1cVWEQ/HlMuFQotokeROaMySI0hawlfw+nWf0U8ES8wOEuOKDIoeZ6zreOM4R3hjOnFvuuL
 vea0yVwq8x1lGJZwYxPeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:A5nJvl11nq8=:hj1MVVR1IEXRjUZq2iCp8j
 kIdw1dQeG8wjmj3YZDA1hd/Qpkeh1Aq3stGx2yr1GlHEEWjHz8uweLG02eSd9w3+0wmuXt74b
 0+PwbNKfxEauWfOc5B0pxHQcWBl4OKnTZRDaamLPioAONvDGy3qmrSvpRU2c7AsLK8jHsrZ18
 V53HbbTN5RL/bSzeXt62qtQOFkD0gOQBNxToDoP4X8aq02oTVJjVNeTae1SD5SzpsbAWIJaAa
 schLWAQ45EC9KFRfGyd0KRX4mWg8o7rOqfDs0ZMuqGr1uLSykqeZ0bxPzsj/Qey+ncS/K1aIn
 Gsgxi2Gow3gU26LblaeOV8nng5u2f9/oid2VEnBQjBKZFxFwBuwUZD1RGAnCYxVHbPjJ/NCJq
 jTtky/m0gXEb5C+VJSBfSOipTOIcqNGVjExzx1GoNtEYbbZqNy7CHBCjmc/K/K20YkH05yhKR
 /JbkvwSLrtnxbxGRkskMyJU5FqgI4f+4Mb3TygEVfGJVuHitwSTTadz12YEN2OpT7AUrqrmo2
 GZ3SvNLwtI6LgyKEaWwWbrknaOJCimYOw9jp5NwTtnXQb1wde7aizm6bElOM8R1bFpvkm9NFB
 eb76Up8kAHOWIjhAwonX8JKU4cd9s7Y+y1IxwJTLlbUWNAfcYxQTEX4LPM6zjhqf9NScTxpT/
 fhrQKzAbbDIMgDtqKK0Op0GfLMj6KWXWBk5VU5+BqW5aODyRS0LL6h566COm8SMxxaf8By7px
 27gt9ZEKvWq3i9XsqGrESkPVVqBc4wyZgMPQtYn1vHJHtqKimcGY1+kKncy4ATrdPNN5+v0Ci
 asvow8MREUw2MAJwXIjfiSKUOjRbMJk6mg+6mN/aQoyYxaC42oF+wF4AepmWX/FbAX3/Lvy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryan,

On Fri, 20 Oct 2017, Bryan Turner wrote:

> On Fri, Oct 20, 2017 at 3:22 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 20 Oct 2017, Junio C Hamano wrote:
> >
> >> A release candidate Git v2.15.0-rc2 is now available for testing at
> >> the usual places.
> >
> > The Git for Windows equivalent is now available from
> >
> >     https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_git-2Dfor-2Dwindows_git_releases_tag_v2.15.0-2Drc2.windows.1&d=DwIBAg&c=wBUwXtM9sKhff6UeHOQgvw&r=uBedA6EFFVX1HiLgmpdrBrv8bIDAScKjk1yk9LOASBM&m=3DdPEJGQe01zvIuHjX8rNURKuGEY_cPkUXvnur9xlNg&s=ZC45D6NoNiE4A8qs_F1ZDMJlGMdXcQ9DwDIpE1-whrU&e=
> >
> > Please test at your convenience,
> 
> Thanks for publishing this, Johannes. I've run it through our Windows
> test matrix for Bitbucket Server (~1450 tests) and all pass. I've also
> added it to our CI build as a canary (pending the final 2.15.0
> release). I've done the same for 2.15.0-rc2 on Linux as well.

Awesome, thank you so much!
Johannes
