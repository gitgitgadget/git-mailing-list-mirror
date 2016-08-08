Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B34A1F859
	for <e@80x24.org>; Mon,  8 Aug 2016 06:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbcHHGvM (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 02:51:12 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:54674 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750801AbcHHGvM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 02:51:12 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bWeOn-0007Sq-7m; Mon, 08 Aug 2016 15:50:57 +0900
Date:	Mon, 8 Aug 2016 15:50:57 +0900
From:	Mike Hommey <mh@glandium.org>
To:	Torsten =?iso-8859-15?Q?B=F6gershausen?= <tboegi@web.de>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2016, #02; Thu, 4)
Message-ID: <20160808065057.uasjjw3l5lenyvgp@glandium.org>
References: <xmqqshukyxqw.fsf@gitster.mtv.corp.google.com>
 <20160804225649.q77p4u6cbdo6q336@glandium.org>
 <xmqqfuqkyutp.fsf@gitster.mtv.corp.google.com>
 <3e98179d-a13d-e0a1-038a-dd9cc5739cd8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3e98179d-a13d-e0a1-038a-dd9cc5739cd8@web.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.2-neo (2016-07-23)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 08, 2016 at 08:48:55AM +0200, Torsten Bögershausen wrote:
> On 2016-08-05 01.32, Junio C Hamano wrote:
> > Mike Hommey <mh@glandium.org> writes:
> []
> 
> >> What kind of support are you expecting?
> > 
> > The only rationale I recall you justifying this series was that this
> > makes the resulting code easier to read, but I do not recall other
> > people agreeing with you, and I do not particularly see the
> > resulting code easier to follow.
> > 
> If that helps:
> I can offer to make a code review,
> and come back at the end of the week or so.

You already did review that code.

Mike
