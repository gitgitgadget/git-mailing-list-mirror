Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5281F42D
	for <e@80x24.org>; Thu, 31 May 2018 12:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754859AbeEaMK1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 08:10:27 -0400
Received: from mout.gmx.net ([212.227.15.15]:55709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753986AbeEaMKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 08:10:25 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LZhsq-1g2tHO07ZM-00lSCr; Thu, 31
 May 2018 14:10:22 +0200
Date:   Thu, 31 May 2018 14:10:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     John Meyer <jmeyer@zerochaos.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git installer bugs
In-Reply-To: <CAGZ79kZFyD=ZxYxGhLvDZrEk-zaLiKnJDUt6G2teSFD4=hC+bQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805311410010.82@tvgsbejvaqbjf.bet>
References: <DM5PR0102MB343149C5313DFE76852857DCCD6C0@DM5PR0102MB3431.prod.exchangelabs.com> <CAGZ79kZFyD=ZxYxGhLvDZrEk-zaLiKnJDUt6G2teSFD4=hC+bQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SPO6sN799RQvONVMkgYY89wg7NbTYdsgE/BENmyS6pmyOR/d6OP
 JlMoBFbJ9J0notr1nzFUWnxD+bd8xbH80fq+8SGjeFBm/jwQuWJmvlxWJkHeg7t9PMtmf1Q
 ReTf+V7T+sTAaJWF8Ruj0NF7oGMoiaYXnlGznI6ICL9nSSrTAvFjV30qxuZutU9S37w8mMb
 C+ltb1yR65pF4nxpw0l6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TfF0M85tKSk=:0KDVKwvyKpmEUC7LKiQ7DH
 HJrKAtAkRz7i0m4V3ZF316HBpE+3lGpwQ0IuMiC/csVKl3dUYLHyfPIpi6Fss1F5kxC6utysJ
 FWT2EW5I61fvvFSBHmjOASvHsinRCs5u/B8zhJz16BusZRapi7MH7FxEPKMoOTk2p2U4vIdOL
 h12Y5lYYYH50U9b0Rx3y3BTlbBHiedkKhSWPrGeTYQc3i8K2UVaS/o6qgWF06h4BXT4wbyucF
 lIFPLBLxtZLfras0cpNUcrff7ez+DjkogiOFXC04WZgCxy7TlovI/zBcz2Ap8qyC91gjChGyY
 cjjaz382NCwT1T04DNNiIVS0k0fwiP1AifD7ghql89t0IJWDcEvxsCojMEnjWpR77H0olR/2O
 3PgjfxN97ehpdeFfbGPw1keZacDnGB3HgXKWaJFfG6CC79hchEw9uFxOIMQ5iescbzuxOvE6x
 GJ2ZZUvLHGc0+lOqv7JZ7Da2Qe+A5FdC5VbCY6RSoD6G949LwWiXpsp9EANhC3E7Qum5rWvnO
 HaFaggMVpzFWdEPlbiDVJjmw54n17A9BpQp7iHJRypMhNsGcIU+ES9TeK5ksIzBoa3Znh3RZi
 vhC0S0tU7h1FfzC/a0VfRii49F8KXxNd8I9+byUs/QjD7/JL/za03Ztddd9GFGpxlCmUi++YK
 cq3M1YG758QtBvM2mRu84/ITRyGVtP2nX7Qzn5tiCy1vA9vaSRAHnQwNS2oV8Svkstb4kggqG
 ZPrTQRTf2zkZitJ7jnjS4DgfgjdMax5zFgbDVtDkJlAjBlP4Sl4a14JTT6+qn6aP/OhGAVDRx
 ecx9dOD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

just to close the loop:

On Wed, 30 May 2018, Stefan Beller wrote:

> On Wed, May 30, 2018 at 12:48 PM, John Meyer <jmeyer@zerochaos.com> wrote:
> > Ran the installer, selected the option to not modify the path & the path was modified anyway... it removed git from the path (it was there from a prior install).  I should NOT have to manually fix my path after an update, even the option to add git to the path should be smart enough to recognize it's there already & leave the path unmodified (sorry, I know that's 2 different bugs in 1 email, but they are related).
> 
> Are you talking about Git for Windows?
> Please file a bug at https://github.com/git-for-windows/git/issues/new

I filed it: https://github.com/git-for-windows/git/issues/1696

Ciao,
Johannes
