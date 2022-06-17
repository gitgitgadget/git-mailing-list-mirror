Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBB1CCA482
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 07:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380569AbiFQHJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 03:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380445AbiFQHJV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 03:09:21 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1522C64D34
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 00:09:15 -0700 (PDT)
Received: from host-78-147-178-211.as13285.net ([78.147.178.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1o266S-000521-Fq;
        Fri, 17 Jun 2022 08:09:13 +0100
Message-ID: <f51cf5ce-9ae3-c47f-68d3-aba3bb8aee73@iee.email>
Date:   Fri, 17 Jun 2022 08:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] builtin/rebase: remove a redundant space in l10n string
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Fangyi Zhou via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Fangyi Zhou <me@fangyi.io>
References: <pull.1277.git.git.1655399939066.gitgitgadget@gmail.com>
 <xmqq7d5gtqyy.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqq7d5gtqyy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/06/2022 19:15, Junio C Hamano wrote:
> "Fangyi Zhou via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Fangyi Zhou <me@fangyi.io>
>>
>> Found in l10n.
>>
>> Signed-off-by: Fangyi Zhou <me@fangyi.io>
> Thanks.
>
>> -			"Note: Your `pull.rebase` configuration may also be  set to 'preserve',\n"
>> +			"Note: Your `pull.rebase` configuration may also be set to 'preserve',\n"
That was my error. Sorry for not being able to respond at the time.
--
Philip
