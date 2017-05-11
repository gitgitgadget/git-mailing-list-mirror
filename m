Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B0CA201A0
	for <e@80x24.org>; Thu, 11 May 2017 23:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932299AbdEKXiI (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 19:38:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:49982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932267AbdEKXiH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 19:38:07 -0400
Received: (qmail 28716 invoked by uid 109); 11 May 2017 23:38:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 23:38:07 +0000
Received: (qmail 19955 invoked by uid 111); 11 May 2017 23:38:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 19:38:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 19:38:05 -0400
Date:   Thu, 11 May 2017 19:38:05 -0400
From:   Jeff King <peff@peff.net>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #03; Wed, 10)
Message-ID: <20170511233805.mkus2g3nu4ffbh2w@sigill.intra.peff.net>
References: <xmqqinl9xpb8.fsf@gitster.mtv.corp.google.com>
 <ac2f1563-735e-9a07-e762-5dda0630304e@xiplink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac2f1563-735e-9a07-e762-5dda0630304e@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 05:31:45PM -0400, Marc Branchaud wrote:

> > * mb/diff-default-to-indent-heuristics (2017-05-09) 4 commits
> [...]
> >  Kicked out of next; it seems it is still getting review suggestions?
> 
> I believe v4 of this one is ready to cook.

Yeah, I think it's ready, too (and I agree with you on the text for the
release notes).

-Peff
