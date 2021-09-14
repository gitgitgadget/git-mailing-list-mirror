Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E5C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 20:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EA9660F9F
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 20:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhINU7M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:59:12 -0400
Received: from siwi.pair.com ([209.68.5.199]:11314 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234183AbhINU7L (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 16:59:11 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5BA5C3F40FB;
        Tue, 14 Sep 2021 16:57:53 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1004:b162:7231:70d1:afed:2d9d:2700])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 14C073F40FA;
        Tue, 14 Sep 2021 16:57:52 -0400 (EDT)
Subject: Re: What's cooking in git.git (Sep 2021, #04; Mon, 13)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqtuinc3tx.fsf@gitster.g>
 <6fce08a4-876f-62d0-ed4b-05327e452985@jeffhostetler.com>
 <xmqqczpazxrr.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c91622ed-984f-d125-875f-206dacc08e67@jeffhostetler.com>
Date:   Tue, 14 Sep 2021 16:57:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqczpazxrr.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/14/21 4:51 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> Junio, how would you prefer that I submit this?  Would you rather
>> drop the existing series and have me send 4 or 5 parts (in a fresh
>> series of gitgitgadget PRs) that could be reviewed in parallel and
>> just sent to "next" in series.  And then maybe they all wait in
>> "next" until the last one is ready and all graduate to "master"
>> together?
> 
> Sounds like that should work.
> 

Will do.  Thanks!!
Jeff
