Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D13EB1FBB0
	for <e@80x24.org>; Fri,  2 Dec 2016 00:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755473AbcLBAHy (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 19:07:54 -0500
Received: from avasout06.plus.net ([212.159.14.18]:59588 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbcLBAHy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 19:07:54 -0500
Received: from [10.0.2.15] ([143.159.212.40])
        by avasout06 with smtp
        id Eo7r1u0020srQBz01o7ssM; Fri, 02 Dec 2016 00:07:52 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Xom4AhN9 c=1 sm=1 tr=0
 a=8Z0saNXTz8GoXi/9Q5ysMA==:117 a=8Z0saNXTz8GoXi/9Q5ysMA==:17
 a=IkcTkHD0fZMA:10 a=xtxXYLxNAAAA:8 a=HXZO7xlDjpAiKuk4X8YA:9 a=QEXdDO2ut3YA:10
 a=xts0dhWdiJbonKbuqhAr:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/6] http: always update the base URL for redirects
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
 <20161201090414.zgz7pimgpctghbwu@sigill.intra.peff.net>
 <331124b5-aa2b-773c-23ac-975ad3f50dbf@ramsayjones.plus.com>
 <20161201225331.GH54082@google.com>
 <2297C36B9A1441748D7E68363A05F8C5@PhilipOakley>
 <xmqq8trz6wrq.fsf@gitster.mtv.corp.google.com>
Cc:     Brandon Williams <bmwill@google.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Jann Horn <jannh@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <7cd35131-2e0c-0dff-8864-c099e313251d@ramsayjones.plus.com>
Date:   Fri, 2 Dec 2016 00:07:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqq8trz6wrq.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/12/16 23:43, Junio C Hamano wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:
> 
>>> Depends, I only know Mallorys who are women so her seems appropriate.
>>>
>> In a British context "Mallory and Irvine" were two (male) climbers who
>> died on Everest in 1924 (tales of daring...), so it's easy to expect
>> (from this side of the pond) that 'Mallory' would be male. However he
>> was really George Mallory.
>>
>> Meanwhile that search engine's images shows far more female Mallorys,
>> so I've learnt something.
> 
> "baby name Mallory" in search engine gave me several sites, most of
> them telling me that is a girl's name except for one.
> 
> Didn't think of doing image search, but that's a good way ;-)

Heh, I didn't think about any of this. I was remembering the
description of 'Man-in-the-middle Attack' from Applied Cryptography
(Bruce Schneier) which implies that Mallory is male.

ATB,
Ramsay Jones

