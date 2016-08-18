Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE1391F859
	for <e@80x24.org>; Thu, 18 Aug 2016 10:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945982AbcHRKLT (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 06:11:19 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:38586 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945898AbcHRKLR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 06:11:17 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 086511F859;
	Thu, 18 Aug 2016 10:03:02 +0000 (UTC)
Date:	Thu, 18 Aug 2016 10:03:02 +0000
From:	Eric Wong <e@80x24.org>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	Nicola Paolucci <durden@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Eric Wong <normalperson@yhbt.net>,
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
Message-ID: <20160818100301.GA30896@dcvr>
References: <CAP8UFD1iveotLsMOBnpa=hU4ohcQjZ-X7tjnzY4k+xz5KJvqBw@mail.gmail.com>
 <D5A2E231FFE74D1C891A1653E1C2D797@PhilipOakley>
 <20160814231000.GB12202@dcvr>
 <979EDD785BDC4C16A51CEBBD991B3A5D@PhilipOakley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <979EDD785BDC4C16A51CEBBD991B3A5D@PhilipOakley>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> wrote:
> Would including a 'help' link on the main pages be possible? Maybe to the
> www-design page or whatever, just to make the users aware of the wider
> resourses, and a few key ways of entering search queries (such as the
> "gmane:123456" which gets that msg, while "gmane/123456" will get all
> messages that refered to that message (pure text search)..

Finally added https://public-inbox.org/git/_/text/help/

I actually totally overdid some things and trimmed it down before
publishing because I felt like it was becoming it's own wiki :x

  https://public-inbox.org/meta/20160818095150.17118-1-e@80x24.org/T/

Anyways, I'm still thinking there might be too much or too little
detail.  I don't know how well-known Atom feeds are, even.
