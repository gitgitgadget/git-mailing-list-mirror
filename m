Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A582018E
	for <e@80x24.org>; Sun, 14 Aug 2016 15:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbcHNPA6 (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 11:00:58 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:38577 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbcHNPA5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 11:00:57 -0400
Received: from PhilipOakley ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id YwuEbKUVjxR4bYwuEbbkaF; Sun, 14 Aug 2016 16:00:55 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=JNN5iICb c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=IkcTkHD0fZMA:10 a=gdoHADL5AAAA:8
 a=5rxgeBVgAAAA:8 a=Emf7GD9-Kh2fzq0YCZoA:9 a=u09W0hvIdLUA:10
 a=DclRd9yUzMzvIfv12z_R:22 a=PwKx63F5tFurRwaNxrlG:22
Message-ID: <A8D4E6C8B72B472BB7B580804F9FAB85@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Eric Wong" <e@80x24.org>, "Jeff King" <peff@peff.net>
Cc:	<git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
References: <xmqq1t1twymf.fsf@gitster.mtv.corp.google.com> <20160812224255.GA16250@dcvr> <20160813081012.p46i4jcvkkfqch7m@sigill.intra.peff.net> <20160813090432.GA25565@starla> <20160813111449.vkoo3fmlfd65loh5@sigill.intra.peff.net> <20160814012706.GA18784@starla>
Subject: Re: A note from the maintainer
Date:	Sun, 14 Aug 2016 16:00:54 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfAXo9YyPAVarnrl6aQEqM61pfbQxWDTeZx3xpH88icVlT70SodnjyyZBuIT222zvmYRAQ6zWOTupN9Fe75weeXGlP9Vw/Y+Vaj9JG2x+ulKQ7AYNt9+W
 jfJLSZzQasMB8we55IN3U7F6uRJdR5Wu7dhDtcngCt1F2YUuvqvtp2p2LgeFqsOMtDjPHfMF32WSC89L1x3bkTkYBXeKzbnOhO45uyjWlKMkNBUAQsDMH7g0
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Eric Wong" <e@80x24.org>
>
> Yes, I was somewhat careful to check for proper mboxes from gmane;
> I just missed entire ranges :x
>

There were a number of messages that were listed by gmane as being in the 
various Git for Windows lists such as msysgit, especially when the messages 
went to both lists (as the issue had common cause) that failed to get onto 
the regualr gmane list.

Are these something that has been included?

Philip

A quick search on a possible message gave 
https://public-inbox.org/git/55BF6808.1000500@web.de/ which has no parent, 
but that parent actually only went to the msysgit list, so no real surprise 
there, but I do remember some other cases that were on list - I just can't 
find them at the moment :-(.




