Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7182F1F404
	for <e@80x24.org>; Wed, 10 Jan 2018 22:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752338AbeAJWDl (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 17:03:41 -0500
Received: from siwi.pair.com ([209.68.5.199]:29019 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752273AbeAJWDj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 17:03:39 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 791A9844D4;
        Wed, 10 Jan 2018 17:03:38 -0500 (EST)
Received: from [10.160.98.77] (unknown [167.220.148.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4E05C844D1;
        Wed, 10 Jan 2018 17:03:38 -0500 (EST)
Subject: Re: What's cooking in git.git (Jan 2018, #02; Tue, 9)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqqa7xm38wc.fsf@gitster.mtv.corp.google.com>
 <718e2723-9547-8cd6-ac46-07e8631da09a@jeffhostetler.com>
 <xmqqshbd1o8a.fsf@gitster.mtv.corp.google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <bda13f22-b6ca-f46d-9730-ff00ec536b0b@jeffhostetler.com>
Date:   Wed, 10 Jan 2018 17:03:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqshbd1o8a.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/10/2018 2:57 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> On 1/9/2018 6:33 PM, Junio C Hamano wrote:
>>> --------------------------------------------------
>>> [Cooking]
>>>
>>>
>>> * jh/fsck-promisors (2017-12-08) 10 commits
>> [...]
>>
>>> * jh/partial-clone (2017-12-08) 13 commits
>> [...]
>>
>> Parts 2 and 3 of partial clone have been simmering
>> for a while now.  I was wondering if there were any
>> more comments or questions on them.  I don't recall
>> any existing issues.
> 
> Me neither.
> 
> I do not mind merging them to 'next' during the feature freeze, but
> we won't be merging them to 'master' soon anyway, and I'd like to
> see us concentrate more on finding and fixing regressions on the
> 'master' front for now.

I didn't want to rush this -- just check to see if there was
any thing that I should focus on while waiting for 2.16 to ship
and settle down.

Leave this where it is now if you want and we can merge it in later.

Thanks
Jeff

  
