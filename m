Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE5CC43381
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 18:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C486864F6A
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 18:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238580AbhBBSZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 13:25:20 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:44773 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238504AbhBBSXQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 13:23:16 -0500
Received: from localhost (unknown [103.82.80.164])
        (Authenticated sender: me@yadavpratyush.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 010C8200004;
        Tue,  2 Feb 2021 18:22:27 +0000 (UTC)
Date:   Tue, 2 Feb 2021 23:52:22 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Mikhail Klyushin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Mikhail Klyushin <klyushinmisha@gmail.com>
Subject: Re: [PATCH] git-gui: fix typo in russian locale
Message-ID: <20210202182222.tm564pw4hf4vuukn@yadavpratyush.com>
References: <pull.837.git.1610620750894.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.837.git.1610620750894.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/01/21 10:39AM, Mikhail Klyushin via GitGitGadget wrote:
> From: Mikhail Klyushin <klyushinmisha@gmail.com>
> 
> Fixed typo in russian locale: издекса -> индекса
> 
> Signed-off-by: Mikhail Klyushin <klyushinmisha@gmail.com>
> ---
>     git-gui: fix typo in russian locale
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-837%2Fklyushinmisha%2Ffix%2Ftypo-in-russian-locale-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-837/klyushinmisha/fix/typo-in-russian-locale-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/837
> 
>  git-gui/po/ru.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to git-gui/master. Thanks.

-- 
Regards,
Pratyush Yadav
