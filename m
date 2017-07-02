Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BEB202A7
	for <e@80x24.org>; Sun,  2 Jul 2017 14:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbdGBO0C (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Jul 2017 10:26:02 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:23775 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbdGBO0C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jul 2017 10:26:02 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id Rfp2d3GzR23YCRfp2db1my; Sun, 02 Jul 2017 15:26:00 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=Cob9STwD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=LmBk-rk3AAAA:8 a=TlrTnCPvLR3R2mFbQ5oA:9 a=wPNLvfGTeEIA:10 a=IdEGqN_9JTMA:10
 a=gA6IeH5FQcgA:10 a=NWVoK91CQyQA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=G48SskWDnsL46lLLIXPa:22
Message-ID: <4374FA169AD7465AA39BDB477A348B02@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com>
Subject: Re: What's cooking in git.git (Jun 2017, #09; Fri, 30)
Date:   Sun, 2 Jul 2017 15:26:02 +0100
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
X-Antivirus: AVG (VPS 170701-0, 01/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfLmMSHkelXmqNY4NVd/3Q1MbPJGKRyRFudV4l3wX46Jsx1dyfL/WJTyt0oYBR2tQxgksfZJzvH2B2e3sHEQ7tRfANuAdH2kOWt0Qto4eHTxodruinXhp
 cuQZw8cgEl7k2A5GvKskXWfvhzqDIFtsYj1CCx7txDWqphJjIClAvcoH/pw9Tq5o1+w7eY7Gr2HJeQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
>

Junio,
Is it possible to include a table of contents that lists the integration 
branches, split by your categories, to help find areas of interest?

[Graduated to "master"]
* topic list
[New Topics]
[Stalled]
[Cooking]
[Discarded]

The TOC wouldn't need the [] or * markings if that's a problem.
--
Philip


> You can find the changes described here in the integration branches
> of the repositories listed at
>
>    http://git-blame.blogspot.com/p/git-public-repositories.html
>
> --------------------------------------------------
> [Graduated to "master"]
>
> * ab/die-errors-in-threaded (2017-06-21) 1 commit
<snip> 

