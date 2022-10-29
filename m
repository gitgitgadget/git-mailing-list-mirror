Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FCEC38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 17:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJ2Reu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 13:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiJ2Req (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 13:34:46 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACC2E0AF
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 10:34:42 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oopjF-000AYg-EE;
        Sat, 29 Oct 2022 18:34:41 +0100
Message-ID: <24633ed6-bff9-7ece-13b5-2548b39ce6df@iee.email>
Date:   Sat, 29 Oct 2022 18:34:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 0/4] Add some Glossary of terms information
Content-Language: en-GB
To:     Taylor Blau <me@ttaylorr.com>
Cc:     GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <20221022222539.2333-1-philipoakley@iee.email>
 <20221029164112.2097-1-philipoakley@iee.email> <Y11hvL8Pubscz3Be@nand.local>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <Y11hvL8Pubscz3Be@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/10/2022 18:24, Taylor Blau wrote:
> On Sat, Oct 29, 2022 at 05:41:08PM +0100, Philip Oakley wrote:
>> (in reply to <20221022222539.2333-1-philipoakley@iee.email>
>>
>> This short series looks to add the basics of the reachability bitmap
>> and commit graph phrases to the glossary of terms. While these
>> techniques are well known to their developers, for some, they are
>> just magic phrases.
> Thanks, the updated round looks good to me. I applied these on top of
> the tip of master instead of the existing merge base (which was
> dc8c8deaa6b (Prepare for 2.36.2, 2022-06-07)).
>
> Will queue.
>
> Thanks,
> Taylor
Thanks!
Philip
