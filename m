Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446F2C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F7324672
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfLSRiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:38:14 -0500
Received: from smtprelay06.ispgateway.de ([80.67.18.29]:16862 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSRiN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 12:38:13 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ihzkX-00079s-TI; Thu, 19 Dec 2019 18:38:09 +0100
Subject: Re: [PATCH v2 04/18] commit: forbid --pathspec-from-file --all
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Alexandr Miloslavskiy via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
References: <pull.490.git.1576161385.gitgitgadget@gmail.com>
 <pull.490.v2.git.1576511287.gitgitgadget@gmail.com>
 <deeb860a85d25e0645a5d2e1c82654653ab1e2d5.1576511287.git.gitgitgadget@gmail.com>
 <195a5b2a-994a-5984-8cc7-280a698df2a0@gmail.com>
 <xmqqmubpcmtx.fsf@gitster-ct.c.googlers.com>
 <xmqqimmdcmq4.fsf@gitster-ct.c.googlers.com>
 <xmqqeex1cmam.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <4eb804d5-863e-540d-0017-72d9402e911a@syntevo.com>
Date:   Thu, 19 Dec 2019 18:38:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqeex1cmam.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18.12.2019 23:16, Junio C Hamano wrote:

> Here is what I'll queue directly on top of am/pathspec-from-file
> e440fc58 ("commit: support the --pathspec-from-file option",
> 2019-11-19), to be fast-tracked.

Roger.

I will keep my branch as is currently and will rebase it on top of your 
patch once it's in master.

