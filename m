Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABFFC43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7644B206C3
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 14:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbfLLO4r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:56:47 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:52625 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbfLLO4r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 09:56:47 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1ifPtT-0003Tn-FK; Thu, 12 Dec 2019 15:56:43 +0100
Subject: Re: [PATCH 5/5] commit: support the --pathspec-from-file option
To:     phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <f4847046896848d3f16bc5f3cb7a26271cefd97c.1572895605.git.gitgitgadget@gmail.com>
 <9ca7fa57-c438-7243-6ab1-956d8f132d37@gmail.com>
 <25aaaca1-1c88-d2c6-b502-cd35752ce745@syntevo.com>
 <4401823b-8039-99b4-2436-ed2f1a571d78@gmail.com>
 <2b573436-0ed2-9d24-f375-dfea0825a39e@syntevo.com>
 <b9454df6-7d31-e255-84bd-8a1c548cffd7@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <92537826-cb89-4e97-8282-94d1d2ac3e9d@syntevo.com>
Date:   Thu, 12 Dec 2019 15:56:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b9454df6-7d31-e255-84bd-8a1c548cffd7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new topic is now submitted:
https://lore.kernel.org/git/pull.490.git.1576161385.gitgitgadget@gmail.com/
					
Phillip, I tried to CC you, but GitGitGadget did something weird.
I'm currently trying to fix CC issues there:
https://github.com/gitgitgadget/gitgitgadget/pull/163
