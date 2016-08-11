Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29BC20193
	for <e@80x24.org>; Thu, 11 Aug 2016 21:09:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbcHKVJB (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 17:09:01 -0400
Received: from smtp-d-1.talktalk.net ([78.144.6.129]:7537 "EHLO
	smtp-d-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932485AbcHKVJA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 17:09:00 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Aug 2016 17:08:59 EDT
Received: from PhilipOakley ([92.22.69.35])
	by smtp.talktalk.net with SMTP
	id Xx5sbUcGV0KuvXx5sbI1Od; Thu, 11 Aug 2016 22:00:48 +0100
X-Originating-IP: [92.22.69.35]
X-Spam:	1
X-OAuthority: v=2.2 cv=RZjSMBlv c=1 sm=1 tr=0 p=5rxgeBVgAAAA:8
 a=118V6UEFpCLMRzptT8w30g==:117 a=118V6UEFpCLMRzptT8w30g==:17
 a=IkcTkHD0fZMA:10 a=gdoHADL5AAAA:8 a=xtxXYLxNAAAA:8 a=ahOBBE4wpJo4Hu5N1UQA:9
 a=PwKx63F5tFurRwaNxrlG:22 a=DclRd9yUzMzvIfv12z_R:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <95848D06D55D4633A686DD892D12F501@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Eric Wong" <e@80x24.org>
Cc:	<git@vger.kernel.org>
References: <73FC8DE87D24466EBEE0A5B96CBDFFBF@PhilipOakley> <20160811075628.GA24690@starla>
Subject: Re: Mapping old gmane numbers to existing amil servers?
Date:	Thu, 11 Aug 2016 22:00:48 +0100
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
X-CMAE-Envelope: MS4wfJfRqyLDOirGkZJKm9vhs0eB23eqpp2Rr89D8/4WO0FU8Jp07mwAg7yywW4t0vbdhwVVfsstG5kbXBWo6R8T/j7uwtEF9e5NTGo2kSczAvK/zN/CMFkc
 MdiR067TvCJjo7AX2ihrfBSLYplHjsjxd9gUTck2nyz3XekumUNHe4kk5npVf7lHjZOgMX3PTEs65Q==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Eric Wong" <e@80x24.org>
Sent: Thursday, August 11, 2016 8:56 AM
> Philip Oakley <philipoakley@iee.org> wrote:
>> Is there an accessible mapping from the old gmane message numbers to one 
>> of
>> the remaining email list servers for the git list?
>
> Yes, I just posted about this after posting an initial mapping
> a few weeks ago:
> https://public-inbox.org/git/20160811002819.GA8311@starla/T/#u
>
> Using "gmane:$NUM" in the search bar should work, now.
> (there's a few missing messages which might've been due to
> off-by-one errors, will fill them in soon)
>
>> I've seen discussions about the public-inbox, but no mention of any 
>> mapping
>> for old message references.
>
> I had a gzipped text file published originally if you look
> upthread there.
>

Thanks.

The raw download works. My home ISP is currently blocking your email for 
some reason, though I do see it at my work - my iee.org alias is via my 
professional body which duplicates the email when it relays it.

On thing I did note on the web display of the threads is that it would be 
good to have a leader of " . . . . . `" so that one can count the level of 
indent, and see the alignments via the columns of dots.

When looking at 
https://public-inbox.org/git/0648000B273C412AB7140AE959EBC99A%40PhilipOakley/ I 
had difficulty working out which email the last 4 were replying to.

