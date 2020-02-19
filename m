Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55845C34031
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 01:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295DF24655
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 01:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgBSBV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 20:21:27 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.36]:24045 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgBSBV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 20:21:27 -0500
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 20:21:27 EST
Received: from [87.78.24.119] (helo=montjoie3.internal.jansen-preisler.de)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <mja@jansen-preisler.de>)
        id 1j4Dxa-0003r5-Am; Wed, 19 Feb 2020 02:15:30 +0100
Message-ID: <59c983e8b706838df77516e55c1f5f33bdb1a80d.camel@jansen-preisler.de>
Subject: Re: Draft of Git Rev News edition 60
From:   Markus Jansen <mja@jansen-preisler.de>
Reply-To: mja@jansen-preisler.de
To:     esr@thyrsus.com, Christian Couder <christian.couder@gmail.com>
Cc:     mja@jansen-preisler.de, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Torsten Krah <krah.tm@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Date:   Wed, 19 Feb 2020 02:15:20 +0100
In-Reply-To: <20200217160311.GA79320@thyrsus.com>
References: <CAP8UFD3fE-JHFweU+VM5xwEph7d6eUEFS23TLVsOrW6F+68QDg@mail.gmail.com>
         <20200217160311.GA79320@thyrsus.com>
Organization: Dipl.-Ing. Markus Jansen
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWphQGphbnNlbi1wcmVpc2xlci5kZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

I have observed that you have used the expression *<word>* four times
(see grep excerpt below) in your article - do you intend to have it
printed like *different* 
or just have it transformed to italic by Markdown?

Best regards,
Markus


~/git/git.github.io> egrep '\*[a-z]+\*' rev_news/drafts/edition-60.md 
it as a DSL (domain-specific language) designed to be *scripted* --
to actually *need* the full power of a domain-specific language
*different* version-control systems, you have to deal with the
problem so deep that the *very* complete

