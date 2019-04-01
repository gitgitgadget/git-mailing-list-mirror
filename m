Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8204D20248
	for <e@80x24.org>; Mon,  1 Apr 2019 09:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfDAJFr (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 05:05:47 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:14779 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfDAJFr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 05:05:47 -0400
Received: from [192.168.1.12] ([2.101.245.142])
        by smtp.talktalk.net with SMTP
        id AsszhAY9egI7iAsszhOeHG; Mon, 01 Apr 2019 10:05:46 +0100
X-Originating-IP: [2.101.245.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=KYisTjQD c=1 sm=1 tr=0 a=mQgiQ6BlbOv19lEfDgieCg==:117
 a=mQgiQ6BlbOv19lEfDgieCg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=PkZ7-pj8AAAA:8 a=xYuf2xi84hAe85yvcpoA:9 a=QEXdDO2ut3YA:10
 a=WG-eDtppl0LQhzQcuusS:22
Subject: Re: Google "Season of Docs"
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <8bb78ce0-9b32-7c49-e4aa-ce9f31662627@thingbag.net>
 <572677cc-eef3-345b-e970-cd6cc80e8e96@iee.org>
 <20190331214900.GX32487@hank.intra.tgummerer.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <4eefb159-c219-0936-12de-e0c5844c3815@iee.org>
Date:   Mon, 1 Apr 2019 10:05:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190331214900.GX32487@hank.intra.tgummerer.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfFHdCOYcGntIFf/aZz6L61Psg3cEg2YG4PuWAtt7fsX3mNvFM/7zoQvREmpVr0f77ChTkYo4jQwBWsBl19tx5+iMsaIu1SduG6dElEdx6Y2AjuCH8vuv
 cs5/eI/ABxnJ7SUfwsAMkObLkHrteFsdGy3Lafk5Ss4tQNwdUMTDIrppwaaifoWf2ruAp9SQEi4XH//cpKTFAm1bM5sJie55ros=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas

On 31/03/2019 22:49, Thomas Gummerer wrote:
> On 03/30, Philip Oakley wrote:
>> We mentor Summer of Code projects.
>> Perhaps we should be doing something similar for docs.  Now Google are:
> One thing that I think is worth highlighting, that I don't think is
> clear from the blog post or this email, is that in contrast to Google
> Summer of Code, Season of Docs targets experienced technical writers,
> rather than students.  Just leaving this here for anyone that's just
> reading this email and/or the blog post.
I had noticed that they were including experienced technical writers, 
hence my hope that maybe we could learn something from them. It's all to 
easy for devs to say that users never read the documentation without 
appreciating that it may not be readable nor understandable from the 
user perspective, an inverse impostor syndrome effect. Perhaps [1] says 
it all ;-)

Philip

[1] https://git-man-page-generator.lokaltog.net/


