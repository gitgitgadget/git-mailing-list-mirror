Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F0911F453
	for <e@80x24.org>; Fri,  9 Nov 2018 10:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeKIUBQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 15:01:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:45962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727560AbeKIUBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 15:01:16 -0500
Received: (qmail 30439 invoked by uid 109); 9 Nov 2018 10:21:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 09 Nov 2018 10:21:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16345 invoked by uid 111); 9 Nov 2018 10:20:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 09 Nov 2018 05:20:38 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2018 05:21:17 -0500
Date:   Fri, 9 Nov 2018 05:21:17 -0500
From:   Jeff King <peff@peff.net>
To:     Joseph Moisan <joseph.moisan@jci.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
Message-ID: <20181109102117.GD7410@sigill.intra.peff.net>
References: <pull.66.git.gitgitgadget@gmail.com>
 <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
 <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com>
 <xmqqo9b1d6na.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1811071217280.39@tvgsbejvaqbjf.bet>
 <d7a70226-3441-76c4-df6a-e8fb32249f27@ramsayjones.plus.com>
 <xmqqr2fwa0ew.fsf@gitster-ct.c.googlers.com>
 <DM5P132MB0143B9D5FAF40A3999131517E7C60@DM5P132MB0143.NAMP132.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM5P132MB0143B9D5FAF40A3999131517E7C60@DM5P132MB0143.NAMP132.PROD.OUTLOOK.COM>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 09, 2018 at 02:05:48AM +0000, Joseph Moisan wrote:

> Can someone please tell me how to unsubscribe from this email.  I am
> no longer interested in receiving these emails, and cannot find how to
> unsubscribe.

Details are at http://vger.kernel.org/vger-lists.html#git.

-Peff
