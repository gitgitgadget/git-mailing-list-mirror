Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09709C54EBD
	for <git@archiver.kernel.org>; Fri, 13 Jan 2023 16:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjAMQyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjAMQyC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2023 11:54:02 -0500
Received: from mail.turbocat.net (turbocat.net [88.99.82.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91A66087A
        for <git@vger.kernel.org>; Fri, 13 Jan 2023 08:51:16 -0800 (PST)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id C566A260114;
        Fri, 13 Jan 2023 17:51:14 +0100 (CET)
Message-ID: <144284f0-7b8d-0b1d-22c1-e3a9ea200507@selasky.org>
Date:   Fri, 13 Jan 2023 17:51:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Content-Language: en-US
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <446984f6-0d2e-04da-11a3-8b1481fac953@selasky.org>
 <009701d9275a$678416b0$368c4410$@nexbridge.com>
 <8a8fbe42-7809-f3e7-b233-6bef790254e1@selasky.org>
 <20230113154516.jxm2cer4sogatayp@meerkat.local>
 <d087568b-919e-61f8-c203-e59a2e0572c6@selasky.org>
 <20230113160218.d3nsoxpbrxrrszhz@meerkat.local>
 <a2e6fdc3-fbb0-821c-078f-1ad4e55dc8e3@selasky.org>
 <5971b434-6409-8fd6-130f-f5b871a10f6d@selasky.org>
 <20230113163619.4ab5oyqyjrthxrwv@meerkat.local>
 <7a51b925-cb0a-4b48-fc14-171006f73298@selasky.org>
 <20230113164953.o63hu5pgetci4sbb@meerkat.local>
From:   Hans Petter Selasky <hps@selasky.org>
In-Reply-To: <20230113164953.o63hu5pgetci4sbb@meerkat.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/13/23 17:49, Konstantin Ryabitsev wrote:
>> It's two different world views.
> Indeed, werenotalike.gif 😄

OK, I have no problem about that.

Thanks for the discussion.

--HPS
