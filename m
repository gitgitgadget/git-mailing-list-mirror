Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8F2201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 15:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751550AbdKLPha (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 10:37:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:54036 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751530AbdKLPh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 10:37:29 -0500
Received: (qmail 4298 invoked by uid 109); 12 Nov 2017 15:37:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 12 Nov 2017 15:37:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15480 invoked by uid 111); 12 Nov 2017 15:37:40 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (62.189.9.201)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Sun, 12 Nov 2017 10:37:40 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Nov 2017 15:37:26 +0000
Date:   Sun, 12 Nov 2017 15:37:26 +0000
From:   Jeff King <peff@peff.net>
To:     Soukaina NAIT HMID <nhsoukaina@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [add-default-config 3/5] add same test for new command format
 with --default and --color
Message-ID: <20171112153725.xnactqmdpir5fgql@sigill.intra.peff.net>
References: <0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com>
 <0102015fb0bf30cb-b3c720d6-c508-4771-a0f1-8c4b2e84f20f-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0102015fb0bf30cb-b3c720d6-c508-4771-a0f1-8c4b2e84f20f-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 12, 2017 at 03:00:40PM +0000, Soukaina NAIT HMID wrote:

> ---
>  t/t4026-color2.sh | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 129 insertions(+)
>  create mode 100755 t/t4026-color2.sh

I'll skip reviewing this one, since the file goes away later in the
series.

-Peff
