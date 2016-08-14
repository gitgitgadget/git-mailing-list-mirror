Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F399E2018E
	for <e@80x24.org>; Sun, 14 Aug 2016 23:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbcHNX5Y (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 19:57:24 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55282 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbcHNX5X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 19:57:23 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89D711FD99;
	Sun, 14 Aug 2016 23:57:22 +0000 (UTC)
Date:	Sun, 14 Aug 2016 23:57:22 +0000
From:	Eric Wong <e@80x24.org>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>
Subject: Re: Draft of Git Rev News edition 18
Message-ID: <20160814235722.GA9605@starla>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
 <20160814231000.GB12202@dcvr>
 <979EDD785BDC4C16A51CEBBD991B3A5D@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <979EDD785BDC4C16A51CEBBD991B3A5D@PhilipOakley>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> wrote:
> From: "Eric Wong" <e@80x24.org>
> >Philip Oakley <philipoakley@iee.org> wrote:
> >>From: "Christian Couder" <christian.couder@gmail.com>
> >>>You can also reply to this email.
> >>
> >>I see you mention in passing (weel in the small headings near the bottom)
> >>that gmane web interface has gone away. It may be worth noting a few of
> >>the
> >>alternatives, and in particular Eric's newly updated public-inbox
> >>https://public-inbox.org/git/.
> >
> >Thanks,
> 
> Would including a 'help' link on the main pages be possible?

Yes, there'll definitely be online help with generic
instructions and also instructions specific to each instance
so things like "gmane:N" can be documented.

There's also bunch of search prefixes I need to document, like
"s:" for subject and whatever the built-in timestamp/date range
parser for Xapian is.  I keep forgetting the Xapian query syntax
myself!
