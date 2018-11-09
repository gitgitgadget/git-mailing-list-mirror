Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8A431F453
	for <e@80x24.org>; Fri,  9 Nov 2018 10:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeKIU2Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 15:28:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:45992 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727532AbeKIU2Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 15:28:24 -0500
Received: (qmail 32005 invoked by uid 109); 9 Nov 2018 10:48:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Nov 2018 10:48:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16759 invoked by uid 111); 9 Nov 2018 10:47:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Nov 2018 05:47:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2018 05:48:20 -0500
Date:   Fri, 9 Nov 2018 05:48:20 -0500
From:   Jeff King <peff@peff.net>
To:     Luca Milanesio <luca.milanesio@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git Merge Contributor's Summit Jan 31, 2019, Brussels
Message-ID: <20181109104820.GA9900@sigill.intra.peff.net>
References: <20181109104202.GA8717@sigill.intra.peff.net>
 <EF813655-82C4-4A0C-9D88-689C606F7A34@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EF813655-82C4-4A0C-9D88-689C606F7A34@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 09, 2018 at 10:44:10AM +0000, Luca Milanesio wrote:

> > On 9 Nov 2018, at 10:42, Jeff King <peff@peff.net> wrote:
> > 
> > Git Merge 2019 is happening on February 1st. There will be a
> > Contributor's Summit the day before. Here are the details:
> > 
> >  When: Thursday, January 31, 2019. 10am-5pm.
> >  Where: The Egg[1], Brussels, Belgium
> >  What: Round-table discussion about Git
> >  Who: All contributors to Git or related projects in the Git ecosystem
> >       are invited; if you're not sure if you qualify, please ask!
> 
> Hi Jeff,
> is Gerrit included in the "Git ecosystem"?

Yeah, I think so. At least the Git parts of it. :)

-Peff
