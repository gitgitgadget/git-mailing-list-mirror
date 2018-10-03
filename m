Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6A841F453
	for <e@80x24.org>; Wed,  3 Oct 2018 05:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeJCMUz (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 08:20:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:39478 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726405AbeJCMUz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 08:20:55 -0400
Received: (qmail 4080 invoked by uid 109); 3 Oct 2018 05:34:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 05:34:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10182 invoked by uid 111); 3 Oct 2018 05:33:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Oct 2018 01:33:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2018 01:34:04 -0400
Date:   Wed, 3 Oct 2018 01:34:04 -0400
From:   Jeff King <peff@peff.net>
To:     _g e r r y _ _l o w r y _ 
        <gerry.lowry@abilitybusinesscomputerservices.com>
Cc:     git@vger.kernel.org
Subject: Re: hunting for lost highly interactive browser based git tutorial
Message-ID: <20181003053404.GA1825@sigill.intra.peff.net>
References: <001101d45ad9$e6607070$b3215150$@abilitybusinesscomputerservices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <001101d45ad9$e6607070$b3215150$@abilitybusinesscomputerservices.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 01:28:20AM -0400, _g e r r y _ _l o w r y _ wrote:

> The tutorial "may" have be called something like "Try Git";
> however, I can not find it at try.github.io and other places where i have looked.

Unfortunately, Try Git seems to have been shut down. I don't know of any
official announcement, but there's some discussion here:

  https://github.com/Try-Git/try_git/issues/24#issuecomment-420784845

-Peff
