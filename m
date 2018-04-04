Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9491F404
	for <e@80x24.org>; Wed,  4 Apr 2018 20:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeDDU7S (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 16:59:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:51985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751971AbeDDU7R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 16:59:17 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MIu7d-1f5kN50OqH-002X5D; Wed, 04 Apr 2018 22:59:10 +0200
Date:   Wed, 4 Apr 2018 22:59:08 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org
Subject: Re: commit -> public-inbox link helper
In-Reply-To: <20180404183620.GC9055@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1804042257040.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <nycvar.QRO.7.76.6.1804041821420.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <20180404183620.GC9055@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RhiKgmgAMQHN69bBWY5c6PUmYrHLmCGPbUgQXkxTEfouVY0OhTm
 os6sjHEFUywEAuVNYq8P/lZnQZN/6++N4PKgbBsOdhMC6omqLfyUla1YMXkjJTq/gh7JBOx
 uvYZHBIj33dCOCifqt39kQBGvKUKcRTtcLx831UbPexzIsEVouMUd/iO//JunQahGvKNfg2
 3l6kGMw8UQRpRWx2rLbGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:82pBYYUiF8E=:gvc7EKt6nAUUPEQM7um8h+
 7fvcVIHz5ZJZxmrGARN/ZMRxYhLvBosEX2vPg73hKDlz1BTO0RVfEte8uuyyH1nfUCev1+ul9
 Y63lpyDKu31/VDGai30MnktlmRc6tpCoo1fy92KUGnGIpr5ugm1VVwH2tDw7kRnL4TYHdIHcU
 0K4ZUx4junSp75X8IyF+v2BNvois4X2oxOG/CkRPJIm2YcrUpbWIsUamROVtf6rYhunleNr7R
 56p/9KgWR3mf4N3rr3Gloq2TCigXg9AhqzXtMrf1/dpJ5SEyCp+ULfuc4O9+x6bxq88to1Gjw
 t/dPhtORgC+xUlWJ4ryqqIjPqvmJcdANvcwGH3Xgdwu9D0MEZRpfpmmV7MIqhdO0JMUQ5zUmd
 goKdKC3PbIs7MblIxlAnOPyGbA/xrE4k+7KOC+3Cm/eVJRsctOUMFd42Co1ryY3tNShrL6eIJ
 TvHZ+xhzKQ74HkHpyMsidwwZDjyWt7w7Z7Qs6lnLKaQcLzTdSBL+sS2ITiKP2e/LcygrHMUjN
 17tLEYaZU0Z2J0Ycyc8+WVDzWStAGA9415MAeBnHbwKRRSG9XjvdNmEoVBvG0qpAkaA4jHjSU
 j720lZ6GN6fvOCAH2Rt3zTaezaEd8w+yTnXgDMAbGHlqMYxYacZUwwpBBEtKaExAK7hEVdeVg
 mrd5W753stM2D7A1Pv5QB0aNr9y0hcJq/IXBVuuzRPn8zJfn1UAte+W1BHjmJkY4e0qiLLpaB
 aRxhoZU41eF2jpnDpPmVUKqbQVQdzPDL1A81wyCekKV8DlCUbfIANNwzN4v0h8fCgIZIovCTn
 awD+nEhd6XaZFisATWzN14h0qzsBB1X8UrQrpkazVLy5lFCi+CmFLqHx0LxnPTUUIM6/IN4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 4 Apr 2018, Jeff King wrote:

> On Wed, Apr 04, 2018 at 06:35:59PM +0200, Johannes Schindelin wrote:
> 
> > I found myself in dear need to quickly look up mails in the public-inbox
> > mail archive corresponding to any given commit in git.git. Some time ago,
> > I wrote a shell script to help me with that, and I found myself using it a
> > couple of times, so I think it might be useful for others, too.
> > 
> > This script (I call it lookup-commit.sh) needs to be dropped into a *bare*
> > clone of http://public-inbox.org/git, and called with its absolute or
> > relative path from a git.git worktree, e.g.
> > 
> > 	~/public-inbox-git.git/lookup-commit.sh \
> > 		fea16b47b603e7e4fa7fca198bd49229c0e5da3d
> > 
> > This will take a while initially, or when the `master` branch of the
> > public-inbox mirror was updated, as it will generate two files with
> > plain-text mappings.
> 
> Junio publishes a git-notes ref with the mapping you want. So you can
> do:
> 
>   git fetch git://github.com/gitster/git.git refs/notes/amlog:refs/notes/amlog
>   mid=$(git notes --ref amlog show $commit | perl -lne '/<(.*)>/ and print $1')
>   echo "https://public-inbox.org/git/$mid"
> 
> without having to download the gigantic list archive repo at all (though
> I do keep my own copy of the archive and index it with mairix, so I can
> use "mairix -t m:$mid" and then view the whole thing locally in mutt).

Good to know! Thanks for the script.

And thanks also for the `--ref` trick: I had a look at the man page of
git-notes, and it was not immediately obvious that it supports options
before the sub-subcommand. The `--ref` description is buried pretty deep
in there.

Thanks,
Dscho
