Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBFDC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 07:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiCDH0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 02:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiCDH0q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 02:26:46 -0500
Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6DC190B6C
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 23:25:58 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 4K8zsw0TXlz5tlH;
        Fri,  4 Mar 2022 08:25:54 +0100 (CET)
Message-ID: <d8d239bc-f5c3-4cac-91a1-16620f0b1f17@kdbg.org>
Date:   Fri, 4 Mar 2022 08:25:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] userdiff: add builtin diff driver for Kotlin language.
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Jaydeep P Das <jaydeepjd.8914@gmail.com>
Cc:     git@vger.kernel.org
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220303181517.70682-1-jaydeepjd.8914@gmail.com>
 <xmqqee3i4eso.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqee3i4eso.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.03.22 um 03:44 schrieb Junio C Hamano:
> Jaydeep P Das <jaydeepjd.8914@gmail.com> writes:
> 
>> Subject: Re: [PATCH] userdiff: add builtin diff driver for Kotlin language.
> 
> "git format-patch --help" and look for "-v <n>", perhaps.  This is
> the fourth iteration, so [PATCH v4], I guess?

Note though, that this iteration is a step in the wrong direction. Let's
forget that it has been submitted. (I saw this submission only long
after I responded in the thread on the earlier round
https://lore.kernel.org/git/c1298c9d-0f4a-40b8-b337-896f4d4777f3@kdbg.org/)

-- Hannes
