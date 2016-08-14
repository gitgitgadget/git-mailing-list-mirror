Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3381FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 23:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752096AbcHNXac (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 19:30:32 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:62289 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566AbcHNXac (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 19:30:32 -0400
Received: from PhilipOakley ([92.22.48.2])
	by smtp.talktalk.net with SMTP
	id Z4rOb430zcpskZ4rObC8au; Mon, 15 Aug 2016 00:30:31 +0100
X-Originating-IP: [92.22.48.2]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=dUEO/agNDYQW2w9YSFWSZw==:117
 a=dUEO/agNDYQW2w9YSFWSZw==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=uIiHkpJI-zyMoJELU8oA:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <DDCA022C9C704F1DA20FC024B84FEB5E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"GitList" <git@vger.kernel.org>
References: <20160814214630.1312-1-philipoakley@iee.org><20160814214630.1312-3-philipoakley@iee.org><xmqqziofj90b.fsf@gitster.mtv.corp.google.com><BF74616BD9694719A6C0D6E75ACD9CE6@PhilipOakley> <xmqq1t1rj6n9.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v1 2/3] doc: rebase: fixup! can take an object name
Date:	Mon, 15 Aug 2016 00:30:31 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfH4iX07A7EJtfOjqTUQxiat1zoOuSzvVDvfsajA9R8jd5EjGflEJwoL/PQd00M824bSdNjkjItYkQvnvihhDquQ2WjsIvQuoqjfH32CUryWqur/36jE/
 RRPutW/HHWtr+Dw9k8bVRCQlp/+iCd1H3gC7NcLP8lKQsUHmKDu++gqyWSJ4ICDoqlwVv0AkQFHNHA==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
> 
>> the 'standalone' is that it must be a single (standalone) word on the
>> subject line immediately after the "fixup! "(s).
>>
>> communicationg that one cannot have any extra textual notes after that
>> word was the issue that 'standalone' tried to address.
> 
> Perhaps I am slow but did you mean the same thing as "it must be a
> single word and nothing else on the remainder of the line"?

Yes.

--
Philip
