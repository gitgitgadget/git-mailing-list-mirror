Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E27CC433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 13:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbiCJNve (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 08:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbiCJNvd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 08:51:33 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB67114F2B6
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 05:50:30 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1DFDF3F4139;
        Thu, 10 Mar 2022 08:50:30 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C21003F4096;
        Thu, 10 Mar 2022 08:50:29 -0500 (EST)
Subject: Re: [PATCH 0/4] A couple of fixes for the Trace2 documentation
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f1fb96f3-6fec-0552-0fe9-74bfd935cca1@jeffhostetler.com>
Date:   Thu, 10 Mar 2022 08:50:28 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/10/22 8:35 AM, Johannes Schindelin via GitGitGadget wrote:
> While verifying a suggestion for a contributor before sending it, I noticed
> that the Trace2 documentation contained an incorrect example. Looking
> around, I found a couple other things I wanted to fix, so here are the
> patches.
> 
> Johannes Schindelin (4):
>    trace2 docs: a couple of grammar fixes
>    trace2 docs: surround more terms in backticks
>    trace2 docs: fix a JSON formatted example
>    trace2 docs: clarify what `varargs` is all about
> 
>   Documentation/technical/api-trace2.txt | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> 
> base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1172%2Fdscho%2Ffix-trace2-docs-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1172/dscho/fix-trace2-docs-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1172
> 

LGTM

Thanks
Jeff
