Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9937320A10
	for <e@80x24.org>; Thu, 28 Sep 2017 21:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751683AbdI1VTE (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 17:19:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:53834 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751580AbdI1VTC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 17:19:02 -0400
Received: (qmail 31495 invoked by uid 109); 28 Sep 2017 21:19:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 21:19:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30801 invoked by uid 111); 28 Sep 2017 21:19:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Sep 2017 17:19:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Sep 2017 17:19:00 -0400
Date:   Thu, 28 Sep 2017 17:19:00 -0400
From:   Jeff King <peff@peff.net>
To:     pedro rijo <pedrorijo91@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: hacktoberfest
Message-ID: <20170928211859.uw7dep6gypsifivy@sigill.intra.peff.net>
References: <CAPMsMoBK+EQZQx4FUs_EqN+BE+93-mtu9kzViqQ6B=LUOFESbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPMsMoBK+EQZQx4FUs_EqN+BE+93-mtu9kzViqQ6B=LUOFESbw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 11:05:49PM +0100, pedro rijo wrote:

> While the git repository itself is not hosted under GitHub, the Pro
> Git book, git for Windows, and git-scm website (at least) projects
> are, and could use this movement to get some more contributions, and
> eventually more maintainers (at least git-scm website had some
> maintainers problem some time ago).
> 
> I've been helping on the git-scm repository (mostly filtering issues
> and PRs), and I know there are still some issues which need to be
> addressed. If the remaining maintainers agree, we could filter and
> provide more instructions to some easy (or not so easy) issues, adding
> the 'hacktoberfest' label and try to use this movement to solve some
> problems

I'd love it if more people wanted to contribute to the git-scm
repository. I think one can probably find some low-hanging fruit by
looking at the open issues list (though I'd be happy, too, if people
with bug or feature suggestions opened new issues).

Here are a couple small-to-moderate bugs that have been languishing:

  https://github.com/git/git-scm.com/issues/701

  https://github.com/git/git-scm.com/issues/987

  https://github.com/git/git-scm.com/issues/994

-Peff
