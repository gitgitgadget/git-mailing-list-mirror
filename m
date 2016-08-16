Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2042C2018E
	for <e@80x24.org>; Tue, 16 Aug 2016 21:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbcHPV1G (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 17:27:06 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55840 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753501AbcHPV1F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 17:27:05 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951921F859;
	Tue, 16 Aug 2016 21:27:04 +0000 (UTC)
Date:	Tue, 16 Aug 2016 21:27:04 +0000
From:	Eric Wong <e@80x24.org>
To:	Josh Triplett <josh@joshtriplett.org>
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
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Lars Schneider <larsxschneider@gmail.com>,
	meta@public-inbox.org
Subject: Re: Draft of Git Rev News edition 18
Message-ID: <20160816212704.GA25034@dcvr>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
 <9f3b254f-451e-4f6d-233c-7e995d8e369e@gmail.com>
 <20160816093027.GA27347@dcvr>
 <20160816093412.v3tenw4vyxipunah@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160816093412.v3tenw4vyxipunah@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> wrote:
> On Tue, Aug 16, 2016 at 09:30:27AM +0000, Eric Wong wrote:
> > Jakub Narębski <jnareb@gmail.com> wrote:
> > > It's a great pity that https://public-inbox.org/ is just
> > > directory index, not a true home page.
> > 
> > +Cc meta@public-inbox.org
> > 
> > I'm not sure one could do better while staying true to the
> > minimalist nature of plain-text email.
> > 
> > In the spirit of decentralization, there may not be /a/
> > homepage, but many.   Everything is meant to clonable with each
> > public-inbox, so maybe every public-inbox will have a code
> > branch attached to it with the source+docs bundled.
> 
> It'd be nice if it had a prominent list of all lists available; as far
> as I can tell, the main page has no link to /git/.

I'm not sure that's necessary; most of the traffic seems to come
from /git/MESSAGE_ID/ links posted by others.  So it's
probably more inside-out exposure than anything.

As for other projects, I'm not aware of anybody else using it,
yet.  I have some small projects using it, but most of those are
one-off throwaways and I'm not comfortable promoting those along
with public-inbox.  I admit: I'm not comfortable promoting
anything I do, really.

I do wish more people would start using the .onions, though...
