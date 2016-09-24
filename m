Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3166207EC
	for <e@80x24.org>; Sat, 24 Sep 2016 01:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759495AbcIXBEy (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Sep 2016 21:04:54 -0400
Received: from avasout03.plus.net ([84.93.230.244]:39700 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757363AbcIXBEw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2016 21:04:52 -0400
Received: from [10.0.2.15] ([194.75.29.46])
        by avasout03 with smtp
        id nD4m1t0030zhorE01D4nxe; Sat, 24 Sep 2016 02:04:48 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=YLLd8lOx c=1 sm=1 tr=0
 a=g54qAj+LxVGqXy9pVcJ+0w==:117 a=g54qAj+LxVGqXy9pVcJ+0w==:17
 a=N659UExz7-8A:10 a=pGLkceISAAAA:8 a=PQoDFM0dOL4fuh_YDxsA:9 a=pILNOxqGKmIA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] run-command: async_exit no longer needs to be public
To:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
References: <78f2bdd0-f6ad-db5c-f9f2-f90528bc4f77@ramsayjones.plus.com>
 <58164A5E-AC93-48A9-9139-B69CFB854CA8@gmail.com>
 <xmqqmviy1qux.fsf@gitster.mtv.corp.google.com>
 <6DE6D03D-F496-4FAB-866A-BC6802312B43@gmail.com>
 <xmqq60pm1kp3.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <866eac55-92cb-d034-3ba8-faa84d8c8a03@ramsayjones.plus.com>
Date:   Sat, 24 Sep 2016 02:04:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <xmqq60pm1kp3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/09/16 20:26, Junio C Hamano wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>>> I do not offhand know if the topic is otherwise ready as-is, or
>>> needs further work.  When you need to reroll, you'd also need to
>>> fetch from the result of the above from me first and then start your
>>> work from it, though, if we go that route.
>>
>> Sounds good to me!
> 
> OK, here is what I queued, then.

This looks good to me. Thanks!

ATB,
Ramsay Jones


