Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B1AE1F404
	for <e@80x24.org>; Thu,  6 Sep 2018 19:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbeIGAI2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 20:08:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:41676 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727529AbeIGAI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 20:08:28 -0400
Received: (qmail 27061 invoked by uid 109); 6 Sep 2018 19:31:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 06 Sep 2018 19:31:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7157 invoked by uid 111); 6 Sep 2018 19:31:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 06 Sep 2018 15:31:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Sep 2018 15:31:30 -0400
Date:   Thu, 6 Sep 2018 15:31:30 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: Git in Outreachy Dec-Mar?
Message-ID: <20180906193130.GA28588@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net>
 <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net>
 <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
 <20180906012143.GA7477@sigill.intra.peff.net>
 <CAP8UFD1nbv6=6JLnOCkmCcZjNOcDfOm4oH7pxHsYcddUYUxBPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD1nbv6=6JLnOCkmCcZjNOcDfOm4oH7pxHsYcddUYUxBPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 06, 2018 at 11:51:49AM +0200, Christian Couder wrote:

> > Thanks. I signed us up as a community (making me the "coordinator" in
> > their terminology). I think the procedure is a little different this
> > year, and we actually propose projects to mentor through their system.
> 
> Yeah, I think the https://git.github.io/Outreachy-17/ is not actually necessary.

I think it still may be helpful for explaining in further detail things
like #leftoverbits (though I see you put some of that in your project
description).

> > So anybody interested in mentoring should go here:
> >
> >   https://www.outreachy.org/communities/cfp/git/
> >
> > (and you'll need to create a login if you don't have one from last
> > year). You should be able to click through "Submit a Project Proposal",
> > after which the fields are pretty self-explanatory.
> 
> I did that for the "Improve `git bisect`" project. As the
> "coordinator", you will need to approve that project.

Thanks. I approved it, though a few of the descriptions are a little
funny. For instance, the text says "we use an issue tracker", which then
links to public-inbox. I assume this is because you filled in a field
for "issue tracker" and then the system generated the text. I don't know
if there's a way go into more detail there.

> I think the person who submits a project becomes some kind of primary
> mentor for the project. So Dscho, if you want to be such a mentor for
> one or both of the other projects on the Outreachy-17 page, please
> submit the project(s) otherwise please tell me and I will submit them.
> You are free of course to change things in these projects when you
> submit them or to submit other completely different projects.

Yes, I think the point is make sure the mentors are invested in the
individual projects. I imagine a kind of "oh, one of us will probably
mentor it" attitude has led to problems in other projects in the past.

-Peff
