Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4FAC636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 20:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjAaUAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 15:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjAaUAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 15:00:16 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B30D367C0
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 12:00:15 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4P5wrX2ZLvz5tl9;
        Tue, 31 Jan 2023 21:00:12 +0100 (CET)
Message-ID: <d2b0717c-8352-5b1a-0ca9-d68935321f9d@kdbg.org>
Date:   Tue, 31 Jan 2023 21:00:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5] win32: fix thread usage for win32
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Seija Kijin <doremylover123@gmail.com>, git@vger.kernel.org
References: <pull.1440.v4.git.git.1674492499537.gitgitgadget@gmail.com>
 <pull.1440.v5.git.git.1675176442381.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1440.v5.git.git.1675176442381.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.01.23 um 15:47 schrieb Rose via GitGitGadget:
> Range-diff vs v4:
> 
>  1:  2e2d5ce7745 = 1:  6ab79d9275d win32: fix thread usage for win32

If you do not agree with review comments, it would be more polite to
express your thinking than to just resend a patch unchanged and silently.

-- Hannes

