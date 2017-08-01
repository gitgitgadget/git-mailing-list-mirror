Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBD42047F
	for <e@80x24.org>; Tue,  1 Aug 2017 21:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbdHAVFD (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Aug 2017 17:05:03 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:30089 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752434AbdHAVE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2017 17:04:59 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id ceLZd7qaYiSHaceLZdwRhE; Tue, 01 Aug 2017 22:04:58 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=UoATD64B c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8
 a=8pif782wAAAA:8 a=c7ilj0-msUgvWlr3NIgA:9 a=QEXdDO2ut3YA:10
Message-ID: <C89BA7B590AA460BB298258BA85E8619@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Stefan Beller" <sbeller@google.com>,
        "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>
Cc:     "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
References: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley> <20170730161816.2412-1-kaarticsivaraam91196@gmail.com> <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] doc: fix small issues in SubmittingPatches
Date:   Tue, 1 Aug 2017 22:04:57 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170801-4, 01/08/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfLnk4FfVw0W/kUURH6UtYULd60p7wk12XmZg3QoTqcSIgJtfsTkTHnmh+0n7bAznkPdsc8bFIlcdqAL4VV/ijVQl84lWMr8tvj0qelP6FB9W2PUloqbi
 RSmZXWRU/zyeguHF4zG2Uo/PLiWaAqKLN+mCZtSon6dV9tFCm9nEWsGbxzPvtRg7yenfbA1w76TwwKuRmLpwqF0DiMt1/BU2+w+G1NcgkBnoOuG9R6jCHeks
 yLfarFbggr/UNiNKpJodlOfLcQXJ9SnBVFTWIKKPNAI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Stefan Beller" <sbeller@google.com>
>> Further, remove duplicated space character.
>
> https://en.wikipedia.org/wiki/Sentence_spacing
> seems like a globally controversial thing. (I assumed
> it was some sort of local dialect before researching
> it properly)
>
> I personally do not mind one way or another regarding
> (double) spaces after a period, but I would think we'd
> strive for consistency throughout the project.
>

The use of double spaces was a taught typing technique as recently as the 
early-mid 1980s when my wife did a UK university postgraduate secretarial 
course. This was just before PC word processing took off. It takes a long 
while for the old ways to die off!
--
Philip 

