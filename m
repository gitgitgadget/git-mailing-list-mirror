Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D02D1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfKDMPW (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:15:22 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:47474 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbfKDMPW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 07:15:22 -0500
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iRbGR-0005zS-7c; Mon, 04 Nov 2019 12:15:20 +0000
Subject: Re: [ANNOUNCE] Git v2.24.0
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com>
 <20191104054924.GA47418@syl.local>
 <xmqqo8xsxiyv.fsf@gitster-ct.c.googlers.com>
 <20191104062334.GA49488@syl.local>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <a0c175e3-1743-c5a1-8327-5736b7af71f5@iee.email>
Date:   Mon, 4 Nov 2019 12:15:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104062334.GA49488@syl.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/11/2019 06:23, Taylor Blau wrote:
> On Mon, Nov 04, 2019 at 03:18:32PM +0900, Junio C Hamano wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>
>>> Thanks for a great release. As always, your release notes were
>>> very helpful in putting together GitHub's release highlights [1].
> Ah, thanks. It must have been dropped in one of the rounds of review. I
> added it back.
>
> Please do let me know if you find any other such typos :-).

in the tidbits section there are two places where a double-dash 'option' 
is shown with only a single dash:

-super-dangerous-option
-end-of-options

Philip

[1]:https://github.blog/2019-11-03-highlights-from-git-2-24

