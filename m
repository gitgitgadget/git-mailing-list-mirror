Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7291C432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD26E222DF
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfKTJWQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:22:16 -0500
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:36941 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKTJWP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 04:22:15 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay06.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1iXMBf-0007yy-Rx; Wed, 20 Nov 2019 10:22:11 +0100
Subject: Re: [PATCH v3 0/6] Add --pathspec-from-file option for reset, commit
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
 <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
 <xmqqa78rchxl.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <bbf2f57c-245d-e163-deee-724d524cb8c3@syntevo.com>
Date:   Wed, 20 Nov 2019 10:22:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqa78rchxl.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.11.2019 5:04, Junio C Hamano wrote:
> Nicely done.  I think this is now ready for 'next'.

Wonderful, thanks for your assistance!

I will continue with patches for other commands, then.
