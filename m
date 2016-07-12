Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E533520195
	for <e@80x24.org>; Tue, 12 Jul 2016 22:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbcGLW3V (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:29:21 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:32945 "EHLO
	smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbcGLW3U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:29:20 -0400
Received: from PhilipOakley ([92.22.11.179])
	by smtp.talktalk.net with SMTP
	id N6AobrB6OcpskN6Apbkr6x; Tue, 12 Jul 2016 23:29:03 +0100
X-Originating-IP: [92.22.11.179]
X-Spam:	0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=811fezkhcwEiY9Bhi8bArg==:117
 a=811fezkhcwEiY9Bhi8bArg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=UVfPanEiVE8deopgzw8A:9 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <7486C42170C44043AB17BA9A47A6C8C2@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:	"Philip Oakley" <philipoakley@iee.org>
To:	"Junio C Hamano" <gitster@pobox.com>
Cc:	"GitList" <git@vger.kernel.org>, "Jeff King" <peff@peff.net>,
	"Marc Branchaud" <marcnarc@xiplink.com>
References: <20160630202509.4472-1-philipoakley@iee.org><20160711202518.532-1-philipoakley@iee.org> <xmqqinwa4puf.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH v3 0/8] Name for A..B ranges?
Date:	Tue, 12 Jul 2016 23:29:05 +0100
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
X-CMAE-Envelope: MS4wfMzuLgFjk29bfHJUpLQQN8e6DGLW7BtfrhX2MbD6BrlwMciVCX+zynLGTvBYY1WdAImvrh4hun4WbtKKg3NKhiDYhms2lUFooSAMGiLo+9tGH4+8rW5p
 eRGpXqa5lniEa3jAG9ZjiPu24LJq5Aw+uxDOw+bkU0Wgni3knJyutlGzL8bJpNPPjLYe6bkH/Ko6iBAisb+b4Wu/MSSJRrEPKHdD7J8kHb3s6/T0dl7JPhCZ
 h/qofP4Y2RsgH2e8/qK0Aw==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
> 
>> This is the re-roll of the po/range-doc (2016-07-01) 3 commits and its
>> follow on patch.
>>
>> The series has gained additional patches following the discussions
>> ($gmane/298790).
..
>>
>> The patches can be squashed together if required.
> 
> Looked mostly sensible, except for a few things mentioned in the
> reviews by Marc (to which I mostly agree with).
> 

Thanks. I'll update in the next few days.

Philip
