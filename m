Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAAEC19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 21:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiHKVyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 17:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233840AbiHKVyA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 17:54:00 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830B999B7E
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 14:53:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F59015678F;
        Thu, 11 Aug 2022 17:53:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0AIDI8Fbf3OdijYAhDHKLsmZz1biZsyo9jQyBN
        BBdfw=; b=SdoBNqJVaaEbVY2Igm+GYeoZF9t/DjRhlYGBIa+oCmzJQfPQW5JLuF
        EVIMa1V+D4yPhZXOWqVmyJdkZqNaDk/HoCrf7D/3V1BgF7AfBmsi5oncHFEA+U+4
        ugDqQkxFp2jjf/GI3/0crSAhyLjTzsMya4trjQhD6cvUyslrtfRWc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 770DA15678E;
        Thu, 11 Aug 2022 17:53:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D5E7D15678D;
        Thu, 11 Aug 2022 17:53:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git-for-windows@googlegroups.com, git@vger.kernel.org,
        git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git for Windows 2.37.2
References: <20220811214252.4351-1-johannes.schindelin@gmx.de>
Date:   Thu, 11 Aug 2022 14:53:56 -0700
In-Reply-To: <20220811214252.4351-1-johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Thu, 11 Aug 2022 21:42:52 +0000")
Message-ID: <xmqq4jyie9aj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19FFADF2-19C0-11ED-92CA-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Dear Git users,
>
> I hereby announce that Git for Windows 2.37.2 is available from:
>
>     https://gitforwindows.org/
>
> Changes since Git for Windows v2.37.1 (July 12th 2022)

Thanks.
