Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 443CD1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 16:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfJBQKp (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 12:10:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:38108 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725852AbfJBQKp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 12:10:45 -0400
Received: (qmail 25231 invoked by uid 109); 2 Oct 2019 16:10:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 02 Oct 2019 16:10:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23096 invoked by uid 111); 2 Oct 2019 16:13:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2019 12:13:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Oct 2019 12:10:44 -0400
From:   Jeff King <peff@peff.net>
To:     Alicenab <alibutlow@gmail.com>
Cc:     =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org
Subject: Re: ProGit2 translation in Azerbaijani
Message-ID: <20191002161043.GA572@sigill.intra.peff.net>
References: <a819214f-c7bc-bb99-cbf6-3f70b9f2e2e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a819214f-c7bc-bb99-cbf6-3f70b9f2e2e0@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 22, 2019 at 02:36:37AM +0400, Alicenab wrote:

> Hi there!
> I have a translated ProGit2 book to Azerbaijan language.
> As code of country name name for our country(az) have already taken, I have
> created "aze" version of it.
> I hope it will be no problem for you.
> Partial translations available in https://github.com/progit2-aze/
> I'll be waiting for your response.

I think most of the progit stuff happens in GitHub issues in the
progit/progit2 repo. I'm cc-ing @jnavila, who is active in working with
translators there.

-Peff
