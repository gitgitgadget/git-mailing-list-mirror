Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 446241F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 15:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755302AbcHXPjz (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:39:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:58492 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754570AbcHXPjy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:39:54 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MWkep-1bf43818l1-00Xrsu; Wed, 24 Aug 2016 17:39:45
 +0200
Date:   Wed, 24 Aug 2016 17:39:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Michael J Gruber <git@drmicha.warpmail.net>,
        Duy Nguyen <pclouds@gmail.com>,
        git-for-windows <git-for-windows@googlegroups.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: [ANNOUNCE] Git for Windows 2.9.3
In-Reply-To: <xmqqzio3uw31.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608241735520.4924@virtualbox>
References: <alpine.DEB.2.20.1608131214070.4924@virtualbox> <xmqqshu8u0px.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608171507530.4924@virtualbox> <xmqqeg5nbehc.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608181022250.4924@virtualbox>
 <CACsJy8A3tkMY-iLPCDj9sqB4HpAK_cxsUu5Z7fsGcCQEORyxUg@mail.gmail.com> <alpine.DEB.2.20.1608231553030.4924@virtualbox> <2a6d2230-90ce-0f54-c7ae-a5aa595a2f73@drmicha.warpmail.net> <alpine.DEB.2.20.1608231736180.4924@virtualbox> <alpine.DEB.2.20.1608231758260.4924@virtualbox>
 <xmqqzio3uw31.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uui7WtGw1GKEH31wa4c2R15CF85E7dM4Ry3loC1eQoexzKAaxWJ
 looRWVLqFzZUahzyEU98TogIHKqn0csvCXsd2T5plTW/NZQ/WJTtdpjjeILUrc+AQC2cHq5
 JK/mAP5goJIKopbyZYou4mVMt8sOx5coqgP4+Y0W8zseAfj6vgoSSwxRRK1vWY6/0wXvjs+
 MHw8Rv7wCTnGDPgaqgjTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pvzaqTEfo3A=:ljID+FtosSDCvsaGU9z1ZU
 msL5iL1riYpxmAFyZ0NcblASk0jkmfz1cQwHorwIN4Hg1adI1+P/5KUvMji2txvqKBkrdeU7B
 72CWfDpT+g1SUsgziBWQi9g/YX7J5Iu3cedBhDxjpdlrHCabBdhNjNDA1qyd4WhapIjzKFK36
 xheNB+EfYB6Xs/r/VpcLZ7wOkQ81eVOtjIePk9T63+XzpTJvwnG88c8LbWfqVu/duV5kf4/5q
 PgDEt58g8trtoo7J3DK5v1qBKAg3hPH2SGtdoPMYeiFnnE8bVGJ7Q8YQpwtI0Yk63eGijWVXj
 YraWrAI5/rCQsN4MygosktFRp9/Sfp+RIRjW2jJKOnl8888F5KTscux5wWMHci7b5rcYRBFXI
 GmQXzpjoNZptK8p84QwP2+K6oPzVSIaYL4GTyi84mjheJZ6Zu1qX0QY24YW208y6ISwTIzNwx
 sNFW+7D74edvFOUl9zeuKuO0oduv1NMRHiFRus1zR7CBX4wh9x6omZTAqBR4hFxoqKfATX6rf
 nLoN0dBqXJFWVqNsm6tKomDpiOabenw7Gn+VFPhe+qJLuvOubRTJQyEbH7Z8CkOcqe7z5Osr3
 exAucWH6yU4KRXbLOtkHqddH+3wKRBBvU9+4T87Xe5+HD3u3qVpNuc7QOUrk6PDsVDCd6HWpD
 tl6DlaPBKYFclQ0l4qkCVLVUPkREhPLoc0ZzhsrtExL8ZvxrE9EQlLg1JA+dJHk00q0uVhABX
 NO0P2WFimaZqU/e8Z3kXJgybQDtyLRSaJnKIu2Ji47uCrTghNwYrYfyDUtGKSSh6WAiCoyNw0
 i+JohEI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > In case it is not crystal-clear, let me clarify one very important point.
> > It seems that some people mistake the work I do for something I do on a
> > whim. This is not so.
> >
> > The patch series that triggered this entire unfortunate discussion
> > introduced the --smudge option, which I have subsequently renamed to
> > --filters and submitted as a patch series to the Git project.
> 
> As the "--filters" is meant as a new feature, it will not land on
> the maintenance track.  It is very likely that it won't be in 2.10,
> so it won't appear in 2.10.x maintenance track, either.

Right. Which is even more a reason for me to decouple this feature from
non-Windows Git.

> [...] whatever new feature you unleash ahead of upstream to your Windows
> port has cost to your end-users.  Its implementation or its external
> interface may have to change when you upstream the new feature that has
> already been in the field, and your end-users would have to adjust their
> scripts and/or muscle memory.

This is nothing new. As I said earlier, I have plenty of experience with
this. Including the experience of worsimproving a feature that has been
battle-tested for years, only to be broken in the process to appease
reviewers on the Git mailing list.

I talk about the core.hideDotFiles feature, of course, which in the
process of being integrated into core Git lost its ability to respect the
setting to be "false".

Git for Windows has a work-around already, of course, it's just ugly, so I
am hesitating to "upstream it" yet.

As I said. All of this is old hat. Git for Windows has been, and probably
will be for a long time to come, diverging from upstream Git. This is not
something I wanted, or worked toward. It's just reality that happened and
I have to deal with it and there is nothing to see here, please move on.

Ciao,
Dscho
