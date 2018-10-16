Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 727B51F453
	for <e@80x24.org>; Tue, 16 Oct 2018 15:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeJPXX4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 19:23:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:42330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726986AbeJPXX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 19:23:56 -0400
Received: (qmail 7436 invoked by uid 109); 16 Oct 2018 15:32:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 16 Oct 2018 15:32:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11055 invoked by uid 111); 16 Oct 2018 15:32:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 16 Oct 2018 11:32:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Oct 2018 11:32:55 -0400
Date:   Tue, 16 Oct 2018 11:32:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     taoqy@ls-a.me, Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: trivial style fix
Message-ID: <20181016153255.GB29432@sigill.intra.peff.net>
References: <20181015193525.GA8349@sigill.intra.peff.net>
 <20181016141405.2022-1-taoqy@ls-a.me>
 <CACBZZX5yfjturpWnMoLu_yso+NLS3eOWjSDaRnXunvN3bbS0_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX5yfjturpWnMoLu_yso+NLS3eOWjSDaRnXunvN3bbS0_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 16, 2018 at 04:27:44PM +0200, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Oct 16, 2018 at 4:16 PM Tao Qingyun <taoqy@ls-a.me> wrote:
> >
> > >Sorry for the slow reply. For some reason I do not think your message
> > >here made it to the list (but I don't see anything obviously wrong with
> > >it).
> > Yes, I cann't send message to the list using my email clinet, I don't
> > know why. The only way I can make it is using `git send-email`(including
> > this message).
> 
> It's almost certainly because your message contains a HTML part. See
> if you can find how to disable that in your mailer and send plain-text
> only. The vger.kernel.org mailer just refuses all HTML E-Mail as a
> spam heuristic.

That was my guess, too, but the message that I got did not have such a
part. Weird.

-Peff
