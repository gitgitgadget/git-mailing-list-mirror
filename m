Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01DA81F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfBLAcD (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:32:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:40922 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727344AbfBLAcD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:32:03 -0500
Received: (qmail 19785 invoked by uid 109); 12 Feb 2019 00:32:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Feb 2019 00:32:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19590 invoked by uid 111); 12 Feb 2019 00:32:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Feb 2019 19:32:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2019 19:32:01 -0500
Date:   Mon, 11 Feb 2019 19:32:01 -0500
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC] Microproject on git-credential-cache
Message-ID: <20190212003201.GE13301@sigill.intra.peff.net>
References: <CAHd-oW4p6XUjF_j+XXwYWGt__L_5bTJGwxmgWhxJfpuAFac=dQ@mail.gmail.com>
 <20190212000033.GB13301@sigill.intra.peff.net>
 <CAHd-oW5me9KXEgngb3GD9uhQR5FQn9GS5pBoQAfV8awkuo4iVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd-oW5me9KXEgngb3GD9uhQR5FQn9GS5pBoQAfV8awkuo4iVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 10:23:25PM -0200, Matheus Tavares Bernardino wrote:

> > > For the microproject "Add configuration options for some commonly used
> > > command-line options", are there some options already known to be good
> > > for adding to configuration file?
> >
> > Hmm. I don't offhand have any suggestions. That one has been floating
> > around since at least 2015. I wonder if it may also be time to retire it
> > (or give some more concrete examples).
> >
> 
> So it may be better if I choose another microproject, right?

Yeah, I think so (though you are welcome to still do it if you have a
particular option you care about; it just makes the micro-project a bit
trickier).

I peeked at the list (which I hadn't actually looked at yet this year!)
and it looks like there are several other options that should work.

-Peff
