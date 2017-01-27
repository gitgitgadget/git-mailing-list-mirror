Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100681FAAD
	for <e@80x24.org>; Fri, 27 Jan 2017 04:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753621AbdA0EBr (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 23:01:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:45728 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753487AbdA0EBq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 23:01:46 -0500
Received: (qmail 23255 invoked by uid 109); 27 Jan 2017 04:01:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 04:01:41 +0000
Received: (qmail 31380 invoked by uid 111); 27 Jan 2017 04:01:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 23:01:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 23:01:39 -0500
Date:   Thu, 26 Jan 2017 23:01:39 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: vger not relaying some of Junio's messages today?
Message-ID: <20170127040139.wz7xmizccjigz5ui@sigill.intra.peff.net>
References: <20170127035753.GA2604@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170127035753.GA2604@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 03:57:53AM +0000, Eric Wong wrote:

> I noticed both of these are are missing from my archives
> (which rejects messages unless they come from vger):
> 
> <xmqq1svp7lcs.fsf@gitster.mtv.corp.google.com>
> <xmqqefzp1d1x.fsf@gitster.mtv.corp.google.com>

I don't have them either, so presumably vger ate them (I usually delete
my cc copies after reading and keep the list ones, and I now have
neither).

> Not sure if there's something up with vger or Junio's setup because
> other messages (even from Junio) are getting through fine.

Sporadic failures, especially on a single topic, imply that something in
the content may triggered the taboo filter (though often that takes out
replies, too, which this doesn't seem to have done).

-Peff
