Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A04C19F2D
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 16:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239824AbiHMQz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Aug 2022 12:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239657AbiHMQz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Aug 2022 12:55:56 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7842A94F
        for <git@vger.kernel.org>; Sat, 13 Aug 2022 09:55:55 -0700 (PDT)
Received: from [90.198.244.89] (helo=[192.168.0.6])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oMuQS-0002mH-3l;
        Sat, 13 Aug 2022 17:55:53 +0100
Message-ID: <0dddb367-ebf9-930f-1b9c-000a532774d3@iee.email>
Date:   Sat, 13 Aug 2022 17:55:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: "master" term - no one cares
Content-Language: en-US
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Ryan <rmrmail@gmx.com>
Cc:     git@vger.kernel.org
References: <6896FBE4-9160-4969-8969-D92F9FE19F14@gmx.com>
 <CAMP44s2A7nJDVRPbixPPPtTedg_Q53CEdw+sBpGZwOfQG4EZSg@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CAMP44s2A7nJDVRPbixPPPtTedg_Q53CEdw+sBpGZwOfQG4EZSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/08/2022 04:15, Felipe Contreras wrote:
> On Fri, Aug 12, 2022 at 10:10 PM Ryan <rmrmail@gmx.com> wrote:
>> I installed the windows version of git today and was annoyed with the “woke” message stating that the “master” branch term will be changed to a different name to be more “inclusive".
>>
>> Don’t waste your time, just get rid of this annoying woke question in your installer.  Very annoying!!  No one thinks git has anything to do with slavery.  On the plus side, git is great, I just started learning it.  Thanks!
> This is not a Git issue, this is a Git for Windows[1] issue: they are
> the ones exposing that message to their users at installation time.
>
> You can raise the issue in their issue tracker [2], but I wouldn't
> hold my breath.
>
> [1] https://gitforwindows.org/
> [2] https://github.com/git-for-windows/git/issues
>
Thanks for the comment. The wider point is to ensure that everyone can 
choose their own name for their primary line of development (plod), no 
matter how fast or slow they plod along.

There is a confusion between the use of the term that refers to the 
*personal* mastery of a _craft_ or _artisan_ technique and, at least one 
of, the historical choices for the usage of the term 'master', which was 
a direct reference to slave servitude. That was for the use of 
electrical circuits which would detect the 'tick' of a primary timing 
pendulum and then have all the actual clock faces that indicated the 
time be _driven_ from that 'master'.

The previous discussion include that of [1], in which I reference the 
paper (it's [4]) regarding the chronometer (clock) .

--
Philip

[1] 
https://lore.kernel.org/git/4bbc8658-4dad-10ef-65a4-8f0f4f4fffd4@iee.email/
