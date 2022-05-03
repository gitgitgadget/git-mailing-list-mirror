Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D877C433EF
	for <git@archiver.kernel.org>; Tue,  3 May 2022 15:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbiECPo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 May 2022 11:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiECPoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 May 2022 11:44:25 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B8C2CE02
        for <git@vger.kernel.org>; Tue,  3 May 2022 08:40:51 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 804E73F4813;
        Tue,  3 May 2022 11:40:50 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 53FD53F483F;
        Tue,  3 May 2022 11:40:50 -0400 (EDT)
Subject: Re: [PATCH v2 0/6] A couple of fixes for the Trace2 documentation
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1172.git.1646919331.gitgitgadget@gmail.com>
 <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7c805fc4-63a0-3329-1829-6b7212f3a6b7@jeffhostetler.com>
Date:   Tue, 3 May 2022 11:40:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.1172.v2.git.1651573607.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/3/22 6:26 AM, Johannes Schindelin via GitGitGadget wrote:
> While verifying a suggestion for a contributor before sending it, I noticed
> that the Trace2 documentation contained an incorrect example. Looking
> around, I found a couple other things I wanted to fix, so here are the
> patches.

Nice. Thanks for your attention to detail here.

Jeff

