Return-Path: <SRS0=f6GY=4Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD3C3F2CD
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 20:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDEA246A3
	for <git@archiver.kernel.org>; Fri, 28 Feb 2020 20:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgB1Ukm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 15:40:42 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:33663 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1Ukm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 15:40:42 -0500
Received: from Kepler (c-73-42-98-145.hsd1.nm.comcast.net [73.42.98.145])
        (Authenticated sender: greg@gpanders.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 3B9A1100017;
        Fri, 28 Feb 2020 20:40:15 +0000 (UTC)
Date:   Fri, 28 Feb 2020 13:40:13 -0700
From:   Greg Anders <greg@gpanders.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrei Rybak <rybak.a.v@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: git-shell default working directory
Message-ID: <20200228204013.xihhlduk7sl4egvx@Kepler>
References: <20200226004830.oxd5562v7qqspnkk@Kepler>
 <241ea912-44b2-96fa-6f9a-3f04d5386b05@gmail.com>
 <20200226201121.GA287048@coredump.intra.peff.net>
 <xmqqeeuhhz3a.fsf@gitster-ct.c.googlers.com>
 <20200226203931.GA288832@coredump.intra.peff.net>
 <20200227215715.qzxtbzvirxg3mnqv@Kepler>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20200227215715.qzxtbzvirxg3mnqv@Kepler>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just wanted to follow up one more time on this: I decided to give 
gitolite a look and am extremely impressed! It was quite easy to set up 
and does exactly what I want and quite a bit more!

Just wanted to provide a glowing recommendation for anyone else 
considering doing their own git hosting.

Greg
