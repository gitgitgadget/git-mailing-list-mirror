Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D991C433ED
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2067761246
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhDGVSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 17:18:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:43784 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232151AbhDGVSm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 17:18:42 -0400
Received: (qmail 18016 invoked by uid 109); 7 Apr 2021 21:18:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Apr 2021 21:18:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23205 invoked by uid 111); 7 Apr 2021 21:18:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Apr 2021 17:18:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Apr 2021 17:18:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
Subject: Re: Reviewed-by given by celebrities (no subject matter expertise on
 Git development)
Message-ID: <YG4hpT5EL6jZp4Pq@coredump.intra.peff.net>
References: <345a7b27-8ee4-4b64-0340-40b002a25d1f@gmail.com>
 <xmqqeefqzsvz.fsf@gitster.g>
 <YG4U5phu1uXZe6Tn@coredump.intra.peff.net>
 <xmqqv98xyfrt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv98xyfrt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 07, 2021 at 01:57:10PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't usually post "me too" responses, since they are usually just
> > noise. But I could not resist it here, for two reasons:
> >
> >   - this is such a nicely written summary of what "Reviewed-by" means in
> >     our project that I think it deserves some praise. :)
> >
> >   - because it is ultimately about "what does Reviewed-by mean within
> >     the Git project", there is some small value in having another
> >     project member say "yes, that is exactly what I expect from it,
> >     too"
> 
> Heh, thanks.
> 
> Are you hinting that some of what I wrote (with typofixes like
> s/arond/around/) should be inserted to SubmittingPatches or
> somewhere near it?

I would not be opposed to that, but I also do not want to create more
work for you. :)

-Peff
