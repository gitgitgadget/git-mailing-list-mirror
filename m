Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B31A91F462
	for <e@80x24.org>; Thu, 25 Jul 2019 15:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbfGYPQy (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 11:16:54 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54393 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbfGYPQy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 11:16:54 -0400
X-Originating-IP: 1.186.12.7
Received: from [10.86.0.100] (unknown [1.186.12.7])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 39947C0012;
        Thu, 25 Jul 2019 15:16:50 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
Subject: Re: Where do I send patches for git-gui?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Pat Thoyts <patthoyts@gmail.com>
References: <35506bd2-aae9-6608-ed4d-a408e0c831b8@yadavpratyush.com>
 <CAP8UFD1C_FD5TLz0oyn6QzGU2rdvvTe6PNhpK29vkMfuHim-qg@mail.gmail.com>
Message-ID: <31812838-0dc6-2a22-6f7d-bd39b1f0dc50@yadavpratyush.com>
Date:   Thu, 25 Jul 2019 20:46:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1C_FD5TLz0oyn6QzGU2rdvvTe6PNhpK29vkMfuHim-qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/07/19 5:04 PM, Christian Couder wrote:
> Hi Pratyush,
> 
> On Wed, Jul 24, 2019 at 11:43 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>>
>> I have a quick little feature to add to git-gui, and I'm wondering where
>> should I discuss it and send patches. The git-gui repo [0] has no readme
>> I can see that would point me in the right direction. Googling around
>> didn't get me anything either.
>>
>> Should I send it here on this list or is it somewhere else?
> 
> It seems to me that people have been sending patches to git-gui to
> this mailing list indeed.

All right, I'll send it here.

> According to the following discussions:
> 
>    - https://public-inbox.org/git/xmqqbm36w7hl.fsf@gitster-ct.c.googlers.com/
>    - https://public-inbox.org/git/nycvar.QRO.7.76.6.1905272135280.28524@tvgsbejvaqbjf.bet/
> 
> Pat Thoyts (in CC) used to be the git-gui maintainer but we haven't
> been hearing from him for a long time, so we are looking for a new
> maintainer.

Ah, that's too bad that there is no active maintainer. I recently 
switched my text editor from Atom to Vim, and the only thing I am 
missing is Atom's gui for looking at diffs and resolving merge 
conflicts. I've only used git-gui for a couple days, but it looks like 
just the tool I need.

I can maintain it (as long as I'm using the tool at least). I'm not 
particularly fluent with Tcl or Tk, but I'm learning them as I implement 
the features I need.

Will I get commit access to the main git repo, or should I use a fork 
and send the changes over here, and one of you folks will merge them?

> 
> 
> 
>> Also, is the project even actively maintained any more? The last commit
>> was in 2017.


-- 
Regards,
Pratyush Yadav
