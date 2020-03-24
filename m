Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084BFC4332B
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 00:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC80B20735
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 00:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCXAaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:30:14 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:42560 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726955AbgCXAaO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 20:30:14 -0400
Received: from [92.30.123.115] (helo=[192.168.1.36])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jGXSN-0000gu-5a; Tue, 24 Mar 2020 00:30:12 +0000
Subject: Re: Season of Docs?
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
References: <xmqqh7ye3b66.fsf@gitster.c.googlers.com>
 <20200324000859.GA5514@syl.local>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <f7ef14fb-6675-0f00-1cbd-6957952658c4@iee.email>
Date:   Tue, 24 Mar 2020 00:30:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324000859.GA5514@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 24/03/2020 00:08, Taylor Blau wrote:
> Hi Junio,
>
> On Mon, Mar 23, 2020 at 04:26:41PM -0700, Junio C Hamano wrote:
>> This is a companion program to GSoC we might want to participate.
>>
>>   https://opensource.googleblog.com/2020/03/announcing-season-of-docs-2020.html
>>   https://developers.google.com/season-of-docs/
>>
>> Many places in our docs clearly show that they were written by
>> developers, which we may want to rectify.
> This is a great idea, and I think it would be good for us to be
> involved. I know that Stolee wanted some help writing documentation
> about partial clones [1]. Maybe that would be a good project for this?
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/pull.586.git.1584638887.gitgitgadget@gmail.com/
Another would be extending the rerere documentation.

Philip
