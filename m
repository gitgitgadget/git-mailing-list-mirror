Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23B31F744
	for <e@80x24.org>; Wed, 13 Jul 2016 11:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbcGMLf4 (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 07:35:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:54691 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbcGMLfy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 07:35:54 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M0Kp7-1b7HXF27mX-00ubcB; Wed, 13 Jul 2016 13:35:32
 +0200
Date:	Wed, 13 Jul 2016 13:35:31 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Jeff King <peff@peff.net>
cc:	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.9.1
In-Reply-To: <20160712140427.GB613@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1607131329510.6426@virtualbox>
References: <xmqqbn247x1f.fsf@gitster.mtv.corp.google.com> <87lh17kgdy.fsf@linux-m68k.org> <20160711235417.GA26163@sigill.intra.peff.net> <xmqqy4577h0o.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607120927410.6426@virtualbox> <20160712073912.GA26431@sigill.intra.peff.net>
 <alpine.DEB.2.20.1607121257450.6426@virtualbox> <20160712140427.GB613@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:rass37x/NpmrTEVZZ+7p+P96+htof2MAj/BHFNNRtK9p6IKBX84
 ZiaxF8Y+3+MhAt8o6w5PuTDNcM0WZ1NsPwR/XRW3iGaD1dI5waCBGcRyhhTyUHaIeYrZ96o
 japVVldOdEbkTUJdqg7+tnJ6Pb5JCS5492dezBbHnFx23ZD0aWPeVVaSDMxl93QbraW1FLI
 woYn2hQeds4rn/kKnzl7g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:iBm9ymo4S10=:7JnnpyASfclizTYM48zWv5
 KrUPErt67hnMmo/YLfFkKYwwFT8liAow8CHrukFFy7J/wjKttludco5hzBvfeF+0nP7PPWNYg
 TvrQpg6Tu91aQ+YOxVCY6DHyuI1RfyHrC6pdiPkYwvrx5XMfxokuQreQl05ljacDmMykINGRv
 tDlf5c9F1X7JJzBr9TPl1Db/1moNVdkeTsU+hLI/AS8gpnJkDWyO3nYM+eRkXPhYVQ7CK+rSS
 DWsmD6zwDmu5h0/s2VtYcET2GyUCnAXA7d3Xj8Aq5RRfKnEE9BFoiTxuF/Ckgf96YIV7Vb/3D
 BMv/fsebfpYMTj+BLzTWqRcrLKG+qnNo2M0vlF5Ak8izPUdf/dbS6/aj7ka7J8Zba0UJd/0Kt
 q5rL1v7rRHF3oCUIcIFIMWeyWMWDi6a3uaY1nH9J/5RS0Ich7vxpteUzeZ2b5f6dbOYVcdwuZ
 j5kWcv429sTBb7Obp9cl90Cp/EwADB9Y2gCtvzuyI6Ei2TAjs1FTBB+Um5dPeHENQ1PqRfQR/
 9bLmCFnFHWzM60I4teeDJjy/Fj8NyXJPYwtG0Lzrvb/UBVSV5ji+BMnB6c0uxRM68in77pT5U
 CTDVByu7YFmnZCh3nCECoPa1ABaZp+JAjlmK1StfJKuBnKgj6aLl4qmov3s1TMowRChyUVFBd
 pHnrMuNkLA8Z6R7PeYi0iUInpxEsno1TyzFRGB6vRMLk9K1n/8g5xZ6Dfhi/FHVWyum/qbBpz
 9XeY3uTxFo1hEg0Tqi248S62nB2thE7rvrApUIsDe9jsZBCumUa/ossHjOPBV/3J31suEC8tX
 C6wzuk3
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Peff,

On Tue, 12 Jul 2016, Jeff King wrote:

> On Tue, Jul 12, 2016 at 01:25:20PM +0200, Johannes Schindelin wrote:
> 
> > [PATCH] Work around test failures due to timestamps being unsigned long
> > 
> > Git's source code refers to timestamps as unsigned longs. On 32-bit
> > platforms, as well as on Windows, unsigned long is not large enough to
> > capture dates that are "absurdly far in the future".
> > 
> > While we will fix this issue properly by replacing unsigned long ->
> > time_t, on the maint track we want to be a bit more conservative and
> > just skip those tests.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> 
> This looks like a reasonable interim fix for both Windows and for the
> general maint track. If we reliably produce "2038" for the 999... value
> then that's simpler than adding in magic to ask about sizeof(ulong). I
> also wondered if we should test forthe _correct_ value, but that would
> defeat the point of the test (999... is also far in the future).

This was just a quick fix, intended to allow me to release Git for Windows
v2.9.1 in a timely manner (which is now delayed for other reasons).

I think I can do even better than to inspect the source code whether it
reliably clamps the dates to PI hours on January 19th, 2038: We already
have a t/helper/test-date and we can easily teach it one new trick.

> One minor comment:
> 
> > diff --git a/t/t0006-date.sh b/t/t0006-date.sh
> > index 04ce535..d185640 100755
> > --- a/t/t0006-date.sh
> > +++ b/t/t0006-date.sh
> > @@ -48,10 +48,17 @@ check_show default "$TIME" 'Wed Jun 15 16:13:20 2016 +0200'
> >  check_show raw "$TIME" '1466000000 +0200'
> >  check_show iso-local "$TIME" '2016-06-15 14:13:20 +0000'
> >  
> > -# arbitrary time absurdly far in the future
> > -FUTURE="5758122296 -0400"
> > -check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
> > -check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
> > +case "$(test-date show:iso 9999999999)" in
> > +*2038*)
> > +	# on this platform, unsigned long is 32-bit, i.e. not large enough
> > +	;;
> > +*)
> > +	# arbitrary time absurdly far in the future
> > +	FUTURE="5758122296 -0400"
> > +	check_show iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
> > +	check_show iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
> > +	;;
> > +esac
> 
> It would be nice to wrap this in a prereq, like:
> 
>   test_lazy_prereq 64BIT_TIME '
> 	case "$(test-date show:short 9999999999)" in
> 	*2038*)
> 		false
> 		;;
> 	*)
> 		true
> 		;;
> 	esac
>   '
> 
>   ...
>   check_show 64BIT_TIME iso       "$FUTURE" "2152-06-19 18:24:56 -0400"
>   check_show 64BIT_TIME iso-local "$FUTURE" "2152-06-19 22:24:56 +0000"
> 
> The main advantage is that it will number the tests consistently, and
> give us a "skipped" message (which can remind us to drop the prereq
> later when everything goes 64-bit).
> 
> But it also will do the right thing with test-date's output with respect
> to "-v" (not that we expect it to produce any output).
> 
> You'll need to adjust check_show as I did in my earlier patch.

Makes sense!

Thanks,
Dscho
