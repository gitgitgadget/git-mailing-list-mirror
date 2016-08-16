Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240851FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 09:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753080AbcHPJkE (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 05:40:04 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38606 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbcHPJe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 05:34:26 -0400
Received: from mfilter24-d.gandi.net (mfilter24-d.gandi.net [217.70.178.152])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 2734741C080;
	Tue, 16 Aug 2016 11:34:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter24-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter24-d.gandi.net (mfilter24-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id qjwFL2AbjDWy; Tue, 16 Aug 2016 11:34:22 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id D770741C08A;
	Tue, 16 Aug 2016 11:34:14 +0200 (CEST)
Date:	Tue, 16 Aug 2016 02:34:12 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	Eric Wong <e@80x24.org>
Cc:	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
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
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	meta@public-inbox.org
Subject: Re: Draft of Git Rev News edition 18
Message-ID: <20160816093412.v3tenw4vyxipunah@x>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
 <9f3b254f-451e-4f6d-233c-7e995d8e369e@gmail.com>
 <20160816093027.GA27347@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160816093027.GA27347@dcvr>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 09:30:27AM +0000, Eric Wong wrote:
> Jakub Narębski <jnareb@gmail.com> wrote:
> > It's a great pity that https://public-inbox.org/ is just
> > directory index, not a true home page.
> 
> +Cc meta@public-inbox.org
> 
> I'm not sure one could do better while staying true to the
> minimalist nature of plain-text email.
> 
> In the spirit of decentralization, there may not be /a/
> homepage, but many.   Everything is meant to clonable with each
> public-inbox, so maybe every public-inbox will have a code
> branch attached to it with the source+docs bundled.

It'd be nice if it had a prominent list of all lists available; as far
as I can tell, the main page has no link to /git/.
