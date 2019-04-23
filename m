Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1B422037F
	for <e@80x24.org>; Tue, 23 Apr 2019 03:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbfDWDpe (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 23:45:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:37678 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726260AbfDWDpe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 23:45:34 -0400
Received: (qmail 16930 invoked by uid 109); 23 Apr 2019 03:45:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Apr 2019 03:45:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5594 invoked by uid 111); 23 Apr 2019 03:46:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 23:46:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 23:45:32 -0400
Date:   Mon, 22 Apr 2019 23:45:32 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Contributor Summit Topics and Logistics
Message-ID: <20190423034532.GA7753@sigill.intra.peff.net>
References: <20190122075027.GA29441@sigill.intra.peff.net>
 <20190130230702.GA25423@sigill.intra.peff.net>
 <86va22qsj1.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86va22qsj1.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 02, 2019 at 01:33:22PM +0100, Jakub Narebski wrote:

> I have noticed a little 'recording' indicator; would recorded session
> (video or audio only) be made available at some point in time?  Did
> anyone take minutes, or take notes (for example of the Summit agenda
> created at the start of the meeting -- when the audio was muted)?  I
> would be very interested in your impressions.

I did record this. The resulting file is quite large, and full of
incoherent bits and blank spots (where we took a break and turned off
the mics but forgot to pause the recording).

I had planned to try to cut it down (at least roughly removing the
useless spots), but here it is April and I haven't managed to do so. If
anybody wants to volunteer to take a crack at it, let me know.

The video file is a few gigabytes. TBH, I've wondered if just
distributing the audio would be just as useful, since the camera is
mostly a static shot of people who aren't currently talking. ;)

-Peff
