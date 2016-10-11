Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 488F91F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 16:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754013AbcJKQrv (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 12:47:51 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.44]:51423 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753439AbcJKQrt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 12:47:49 -0400
Received: from [84.131.249.130] (helo=book.hvoigt.net)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bu0DR-00076v-5v; Tue, 11 Oct 2016 18:47:45 +0200
Date:   Tue, 11 Oct 2016 18:47:43 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] clean up confusing suggestion for commit references
Message-ID: <20161011164743.GA78613@book.hvoigt.net>
References: <20161007095638.GA55445@book.hvoigt.net>
 <20161007143200.qw77pdsymbdmjhbw@sigill.intra.peff.net>
 <xmqqh98kf4fy.fsf@gitster.mtv.corp.google.com>
 <20161010182623.hsczlsfc6oaa2byj@sigill.intra.peff.net>
 <xmqqoa2sdnjt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqoa2sdnjt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 10, 2016 at 12:14:14PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Oct 10, 2016 at 11:24:01AM -0700, Junio C Hamano wrote:
> >
> >> I no longer have preference either way myself, even though I was in
> >> favor of no-quotes simply because I had an alias to produce that
> >> format and was used to it.
> >
> > I'll admit that I don't care _that_ much and am happy to leave it up to
> > individual authors, as long as nobody quotes SubmittingPatches at me as
> > some kind of gospel when I use the no-quotes form.
> 
> ;-).  
> 
> I just do not want to hear "gitk (or was it git-gui) produces quoted
> form, why are you recommending no-quoted form in SubmittingPatches?"
> 
> I'd say "use common sense; sometimes it is less confusing to read
> without quotes and it is perfectly OK to do so if that is the case".

I do not care about which format it should be either. I just wanted to
be clear about whatever should be used. Since it seems we will allow
both, I am also fine with leaving the description as it is ;-)

Cheers Heiko
