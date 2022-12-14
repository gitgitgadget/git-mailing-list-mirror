Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A96C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 19:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbiLNTS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Dec 2022 14:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiLNTSh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2022 14:18:37 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E128B2B26F
        for <git@vger.kernel.org>; Wed, 14 Dec 2022 11:18:09 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E8333CA127E;
        Wed, 14 Dec 2022 14:18:07 -0500 (EST)
Received: from [192.168.4.22] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BA854CC82F6;
        Wed, 14 Dec 2022 14:18:07 -0500 (EST)
Message-ID: <aedc0911-5538-603e-b0e0-71435039545e@jeffhostetler.com>
Date:   Wed, 14 Dec 2022 14:18:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: What's cooking in git.git (Dec 2022, #05; Wed, 14)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqiliewbje.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqiliewbje.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 12/14/22 4:59 AM, Junio C Hamano wrote:
> * jh/t7527-unflake-by-forcing-cookie (2022-12-02) 1 commit
>   - fsmonitor: fix race seen in t7527
> 
>   Make fsmonitor more robust to avoid the flakiness seen in t7527.
> 
>   Will merge back to 'next'.
>   source:<pull.1437.git.1669937534944.gitgitgadget@gmail.com>
> 

There was no discussion on this item and nothing needs to be
revisited, so it could go as is.

Thanks,
Jeff
