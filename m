Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E201FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 09:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbcHPJbX (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 05:31:23 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53970 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251AbcHPJa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 05:30:28 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A0901FD99;
	Tue, 16 Aug 2016 09:30:27 +0000 (UTC)
Date:	Tue, 16 Aug 2016 09:30:27 +0000
From:	Eric Wong <e@80x24.org>
To:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:	Philip Oakley <philipoakley@iee.org>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	meta@public-inbox.org
Subject: Re: Draft of Git Rev News edition 18
Message-ID: <20160816093027.GA27347@dcvr>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
 <9f3b254f-451e-4f6d-233c-7e995d8e369e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f3b254f-451e-4f6d-233c-7e995d8e369e@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> wrote:
> It's a great pity that https://public-inbox.org/ is just
> directory index, not a true home page.

+Cc meta@public-inbox.org

I'm not sure one could do better while staying true to the
minimalist nature of plain-text email.

In the spirit of decentralization, there may not be /a/
homepage, but many.   Everything is meant to clonable with each
public-inbox, so maybe every public-inbox will have a code
branch attached to it with the source+docs bundled.


At least for now, other pages are more easily discoverable[1]
but one day I hope to have repobrowse[2] running there (and
maybe everywhere).


For now, I am prioritizing user/admin/hacker documentation so
more instances can exist.  I'll probably get some online help
stuff up tomorrow.


[1] at least the top-level of public-inbox.org already has more
    content than both YHBT.net and bogomips.org combined :)

[2] git clone -b repobrowse https://public-inbox.org/ ...
    (idle the moment: think cgit|gitweb with the same (lack of)
     style as public-inbox, +search, +mail thread integration)
