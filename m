Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FE901F454
	for <e@80x24.org>; Mon, 11 Nov 2019 08:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfKKISf (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 03:18:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:44276 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726768AbfKKISf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 03:18:35 -0500
Received: (qmail 17737 invoked by uid 109); 11 Nov 2019 08:18:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 08:18:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3831 invoked by uid 111); 11 Nov 2019 08:22:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 03:22:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 03:18:33 -0500
From:   Jeff King <peff@peff.net>
To:     Luca Milanesio <luca.milanesio@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: Git Merge 2020
Message-ID: <20191111081833.GA17984@sigill.intra.peff.net>
References: <CAP8UFD0WXrG=XbZj9fyo1v0zy8p7yNnGZGVH8bHDqPOLThGD-w@mail.gmail.com>
 <7C3540BE-1F56-46F2-86BF-40AF5E31E544@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7C3540BE-1F56-46F2-86BF-40AF5E31E544@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 10:02:06PM +0000, Luca Milanesio wrote:

> > It looks like from https://git-merge.com/ that the next Git Merge
> > conference will be in Los Angeles on March 4 2020.
> 
> Thanks for the info, there is only a landing page at the moment.

Yes, the speaker lineup is still forming. There's also a link there to
the Call for Proposals:

  https://github.submittable.com/submit

If there happen to be any Git experts on the list who would like to give
a talk. :)

Plans for the Contributor Summit are still forming, but it will likely
be the day after the main conference, March 5th.

> > It seems that the conference will only last one day instead of 2, as
> > it looks like workshops are going to happen in the morning instead of
> > on their own day.
> 
> That would make the attendance from Europe quite low I believe: it is
> quite hard to justify a 12h flight for only a one-day, of which
> half-day is for workshops :-(

Yes, it is unfortunate. On the flip side, it will hopefully give an
opportunity for people from North America to make it, who might have had
a hard time justifying a flight to Europe in past years.

> Do you know if there is any reason for having such a short conference?

We're trying to mix things up and make it a little more interactive.
There will probably be some discussion sessions in the morning,
concurrent with the workshops, to try to get users talking to each other
and to Git experts (with the idea that you could switch between the two
to make your own agenda). Plans there are still shaping up.

-Peff
