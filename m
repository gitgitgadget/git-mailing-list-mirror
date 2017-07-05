Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46AC3202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 07:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752190AbdGEHai (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 03:30:38 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:48879 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751651AbdGEHai (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 03:30:38 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id Selfd1d4KjUsYSelfd459I; Wed, 05 Jul 2017 08:30:36 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=R5RBIpZX c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=VjiaLYd78G_vTfj2y88A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <DEBF0737E2B74FC89FF1C4E4DB8AC45B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>
References: <xmqqk23tp2jk.fsf@gitster.mtv.corp.google.com><4374FA169AD7465AA39BDB477A348B02@PhilipOakley><xmqqo9t1l6vi.fsf@gitster.mtv.corp.google.com><C31723137B784D54A3CDB1B7D9432D7E@PhilipOakley> <xmqqfuedl1ct.fsf@gitster.mtv.corp.google.com>
Subject: Re: What's cooking in git.git (Jun 2017, #09; Fri, 30)
Date:   Wed, 5 Jul 2017 08:30:35 +0100
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
X-Antivirus: AVG (VPS 170704-4, 04/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfLyBIIGdK6kjT2NHhKMiA1t/YTgkuvKUpjX0wuYWh7S6kHRUeg3jt4ylY+dOS6VX+BVGLXRKQbvhMY5YY8HjcINShAVGonGKhWUMdtkpJwayvT7WeYXv
 cX7RgMMreQCdWJuSkT9dNQ8ueUo2cuJiKufhYATSFWmpbfmxUv8vMvhHP7XZu1dn88qPV2WIFYagVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, July 03, 2017 9:19 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> Am I right that the What's cooking  is prepared by a script?
>
> Because I have to keep track of so many topics, its maintenance is
> heavily helped by a script. I do not think it is sensible to expect
> me to (or it would be good use of my time) correctly update the list
> of commits manually every time a topic is replaced with its new
> version.
>
Definately. I was hoping that a 'contents list' element (at the point of 
sending the emails) could also be part of the automated scripting.

> But I consider the use of the script just like my use of Emacs to
> edit the final end result.  Yes, I use tools to prepare it, and the
> tools know certain rules that I prefer to apply to the document,
> such as "a topic that has not been touched since the previous issue
> by default does not need its description updated."
>
> Does that answer your question?
>
I see the script's location is given in a follow up response. I'll see what 
opportunities for a TOC there may be within the flow, though my local todo 
list is getting a bit long with other personal matters.
--
Philip 

