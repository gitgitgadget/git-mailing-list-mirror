Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FAFC433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 21:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbiCMVhg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 17:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbiCMVhe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 17:37:34 -0400
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC9D75C1A
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 14:36:25 -0700 (PDT)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4KGtK052B6z5tl9;
        Sun, 13 Mar 2022 22:36:20 +0100 (CET)
Message-ID: <4b8d0d1b-79b8-1a25-748f-ad7e202d93ea@kdbg.org>
Date:   Sun, 13 Mar 2022 22:36:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v7] userdiff: add builtin diff driver for kotlin language.
Content-Language: en-US
To:     jaydeepjd.8914@gmail.com
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220312044832.718356-1-jaydeepjd.8914@gmail.com>
 <1f10cfa1-83b8-49b1-f4df-829cada788bd@kdbg.org>
 <634b6049-7b06-876d-499f-7aa5880a47f4@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <634b6049-7b06-876d-499f-7aa5880a47f4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.03.22 um 18:02 schrieb jaydeepjd.8914@gmail.com:
> Thanks. Should I CC Junio or will it be here for some more reviews?

In my previous reply I Cc'ed Junio to notify him that we have reached a
conclusion. Usually, he'll pick up the patch after that. If you do not
see the topic mentioned in the next "What's cooking" report or it refers
to an outdated version, that would be an appropriate time for a reminder.

-- Hannes
