Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD7E51F403
	for <e@80x24.org>; Fri,  8 Jun 2018 12:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbeFHMDo (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 08:03:44 -0400
Received: from titan.plasma.xg8.de ([85.10.203.189]:41372 "EHLO
        titan.PLASMA.Xg8.DE" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbeFHMDn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 08:03:43 -0400
Received: from titan.PLASMA.Xg8.DE (localhost [127.0.0.1])
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTPS id w58C3Xtk023330
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Jun 2018 14:03:33 +0200
Received: (from uucp@localhost)
        by titan.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) with UUCP id w58C3XEs023329;
        Fri, 8 Jun 2018 14:03:33 +0200
Received: from helen.PLASMA.Xg8.DE (localhost.localdomain [127.0.0.1])
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2) with ESMTP id w58BwgZR012530;
        Fri, 8 Jun 2018 13:58:42 +0200
Received: (from rtc@localhost)
        by helen.PLASMA.Xg8.DE (8.15.2/8.15.2/Submit) id w58BwgAn012529;
        Fri, 8 Jun 2018 13:58:42 +0200
Date:   Fri, 8 Jun 2018 13:58:42 +0200
From:   Peter Backes <rtc@helen.PLASMA.Xg8.DE>
To:     David Lang <david@lang.hm>
Cc:     Philip Oakley <philipoakley@iee.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: GDPR compliance best practices?
Message-ID: <20180608115842.GA12013@helen.PLASMA.Xg8.DE>
References: <20180603174617.GA10900@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806061831340.7659@nftneq.ynat.uz>
 <20180607063225.GA28343@helen.PLASMA.Xg8.DE>
 <3EF5AC29192A4D179B6D8689ECB991CC@PhilipOakley>
 <20180607223442.GA5322@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071535510.27871@nftneq.ynat.uz>
 <20180607232128.GA5879@helen.PLASMA.Xg8.DE>
 <alpine.DEB.2.02.1806071651310.27871@nftneq.ynat.uz>
 <20180608061656.GA9383@helen.PLASMA.Xg8.DE>
 <nycvar.QRO.7.76.6.1806080040060.4962@qynat-yncgbc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1806080040060.4962@qynat-yncgbc>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 08, 2018 at 12:42:54AM -0700, David Lang wrote:
> Wrong, if you have to delete info, you are not allowed to keep a private
> copy.

Yes you are allowed. See Art. 17 (3) lit e GDPR.

> There is _nothing_ in the GDPR about publishing information,
> everything in it is about what you are allowed to store privately, how you
> are required to protect it (or more precisely, what you are required to do
> if private data gets hacked), and how you are required to keep it available.

Nope, the GDPR is not at all restricted to private copies.

The GDPR has special jargon for publishing; the GDPR calls it 
"disclosure (Art. 4 (2) GDPR) to an unspecified number of unspecified 
recipients (Art. 4 (9) GDPR), including ones in third countries 
(Chapter 5) in a repetitive (Art 49 (1) GDPR) fashion".

Best wishes
Peter

-- 
Peter Backes, rtc@helen.PLASMA.Xg8.DE
