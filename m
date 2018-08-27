Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 299441F404
	for <e@80x24.org>; Mon, 27 Aug 2018 15:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeH0TmV (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 15:42:21 -0400
Received: from mout.gmx.net ([212.227.17.21]:59901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbeH0TmV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 15:42:21 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MV6PJ-1gQZA10mVx-00YQdf; Mon, 27
 Aug 2018 17:55:00 +0200
Date:   Mon, 27 Aug 2018 17:54:58 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Measuring Community Involvement (was Re: Contributor Summit
 planning)
In-Reply-To: <xmqqin4cznmt.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808271754140.73@tvgsbejvaqbjf.bet>
References: <20180813163108.GA6731@sigill.intra.peff.net>        <87h8jyrtj6.fsf@evledraar.gmail.com>        <xmqqh8jy3sx1.fsf@gitster-ct.c.googlers.com>        <CAGZ79kbLVoGFEEPHgEJxBFqAMCzjgXK6gxRix__P5PWL8M2MyA@mail.gmail.com>       
 <20180813210617.GA19738@sigill.intra.peff.net>        <CAGZ79kaNa2bo31rQexs4rAH6bAz1rMzpxS3-fSFE6Cj87E8saw@mail.gmail.com>        <20180813215431.GB16006@sigill.intra.peff.net>        <3f0da3cd-0929-4aad-2c50-92c9d6c660e5@gmail.com>       
 <20180814193646.GC28452@sigill.intra.peff.net> <xmqqin4cznmt.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:z+LpGNJZwp3TO19VAEW77dRFAo49mdEdPsBiD4dai59/rigAho8
 ldRy/UBN/QnReCCPm4SdEkhP9D9Mjv3xL5E+nTVO4E/00fJCUosgj954qSaQb35a6FeaEgv
 LImfycJithRaNuXwvmxKYGaGLZFKdVs2rHzO1kkUIkhSQHPMMyKxM7etym36c6LQHh0CbY/
 FWc2oHJw+IyeAZEdRqkhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iPqGEHtgWKk=:pJFLWYyrGxJPNUfuh2uFNx
 kNOvoqhlRWX2n52++Z0mcNH03OMwu6wIlEVc3CaRrYnW+wXwkPGGaCFSGf+0WVRMUFx2Ts8jd
 dWfNrTHvltaQqHaabZStf5iMxcbyTC4YV7WdWG1YFq01X3frv8PstElvTUJOrgZJejjDpxSve
 7iW3qpY7bIm4JXSM1Bglj01T4CLFNWK6H2U3d0TI8hi0VcthsTAHyvub3sYllXBa2yGklgGM1
 9r2FZCY1TcH1F05NqYOYN7XifpIFunHrOIf8ISJ4Fb27ymIVedOleerQL/aUwZsvEHIZlcuyH
 NwBH/mxb2XxiR1peASp/keHp6aT+ZQ3XfIYTc8ckWlKZiJ2R2YXtbFisvQZKIXZut3Id0qZS9
 /BMVBuEvC/0Wv0qQUnJ1HQFmavbp875BMn5oCOvrZgptRP1w34FHjcNcFULPv7b+4FfFdhZcC
 n7uvZ11FOdp2H9XSPWNnGJVACeFeGZHNyntqw4/fJd/sVzr51Tl0USFA3rSCWZDq6UaESOaD8
 pAIfztDnTUXuwqfsDF1smuAzrmXB0PSbvatVSz2Jj/a5FRZUbcmb4nvbEPF7s8gWIEPCQBX1Z
 2q0kbxNq2Bv+cGYHs+jWgssVjROsR8LXm91usJ2SEM/7T3qcHCC9UtMrV8hpLaBMpfbi6j/PX
 yTXe+4oSTD7VT6ZDZpgL77e39e5buHuMNzGSgADMUDa7ANgDLRUsqAu7J3PrtmCRlE3a5EoLO
 nEMuQaUlUFNFOKDb1S+coLB4m8cLSGpoZJlUqDSKGL8RgBMrg4XGlXZBdrfcHM2swDdKpeWLT
 v2J7iK8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 14 Aug 2018, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Aug 14, 2018 at 01:43:38PM -0400, Derrick Stolee wrote:
> >
> >> On 8/13/2018 5:54 PM, Jeff King wrote:
> >> > So I try not to think too hard on metrics, and just use them to get a
> >> > rough view on who is active.
> >> 
> >> I've been very interested in measuring community involvement, with the
> >> knowledge that any metric is flawed and we should not ever say "this metric
> >> is how we measure the quality of a contributor". It can be helpful, though,
> >> to track some metrics and their change over time.
> >> 
> >> Here are a few measurements we can make:
> >
> > Thanks, it was nice to see a more comprehensive list in one spot.
> >
> > It would be neat to have a tool that presents all of these
> > automatically, but I think the email ones are pretty tricky (most people
> > don't have the whole list archive sitting around).
> 
> I do not think it covered e-mail at all, but there was git stats
> project several years ago (perhaps part of GSoC IIRC).
> 
> > I think I mentioned "surviving lines" elsewhere, which I do like this
> > (and almost certainly stole from Junio a long time ago):
> 
> Yeah, I recall that one as part of counting how many of 1244 lines
> Linus originally wrote still were in our codebase at around v1.6.0
> timeframe (the answer was ~220 IIRC) ;-)

And if you do not remember precisely, you can easily re-run `Linus` from
here: https://github.com/git/git/blob/todo/Linus

Ciao,
Dscho
