Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DB9C001DC
	for <git@archiver.kernel.org>; Mon, 31 Jul 2023 16:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbjGaQpA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 31 Jul 2023 12:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjGaQo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2023 12:44:58 -0400
Received: from mail.zombino.com (c2.zombino.com [65.108.93.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD0B173E
        for <git@vger.kernel.org>; Mon, 31 Jul 2023 09:44:52 -0700 (PDT)
Received: from [IPv6:::1] (unknown [IPv6:2001:470:1f0b:4cd:21e0:1542:747f:c502])
        by mail.zombino.com (Postfix) with ESMTPS id 5630F3E98A;
        Mon, 31 Jul 2023 16:44:50 +0000 (UTC)
Date:   Mon, 31 Jul 2023 18:44:45 +0200
From:   Adam Majer <adamm@zombino.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     git@vger.kernel.org
Subject: Re: [PATCH] doc: sha256 is no longer experimental
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqr0ooyss9.fsf@gitster.g>
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com> <ZLlNtbAbVcYH7eFb@adams> <xmqqr0p230rj.fsf@gitster.g> <d8ba032f-51bc-0bab-fd24-25dea0d56966@zombino.com> <ZMe6KmzZGVubYpvO@adams> <xmqqr0ooyss9.fsf@gitster.g>
Message-ID: <27BFEA76-A6F5-418C-B18C-1206704849F7@zombino.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On July 31, 2023 6:01:10 p.m. GMT+02:00, Junio C Hamano <gitster@pobox.com> wrote:
>Adam Majer <adamm@zombino.com> writes:
>> +changes prove to be necessary, it can expected that SHA-256 repositories
>
>"can BE expected" (will tweak locally while queueing; no need to resend).

+1

>
>Will queue.  Thanks!

Thanks!

-Adam
