Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23113C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38E7610EA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 17:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhJ1Rzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 13:55:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53145 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhJ1Rzo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 13:55:44 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65579F82A5;
        Thu, 28 Oct 2021 13:53:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=WLZZJ29/DKqX
        KL/yTjgd4gZR01jzkRWxKqNKyBZl+D0=; b=OfeZidFeB7UdiermZ8ZuguYp049t
        jlfFEf3t5dmxS+qbZ8ie4Ujyd10DM7FtzFmTafdWu0WAd3LeoHLn38OoVRj4VqAc
        7P5eAyejIXjIV1/2+Yof5xKzJQz9+7cgwcMg56XTRlpH6PbhdWiQWWHppdpPjs6R
        7FubrP+GBcCwMG0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CAC2F82A4;
        Thu, 28 Oct 2021 13:53:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B36CBF82A1;
        Thu, 28 Oct 2021 13:53:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 7/9] doc: uniformize <URL> placeholders' case
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
        <pull.1066.v2.git.1635438124.gitgitgadget@gmail.com>
        <8f85da3bb4ad1ca0c864d925b621426bb38ca5bb.1635438124.git.gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 10:53:14 -0700
In-Reply-To: <8f85da3bb4ad1ca0c864d925b621426bb38ca5bb.1635438124.git.gitgitgadget@gmail.com>
        (=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Thu,
 28 Oct 2021
        16:22:02 +0000")
Message-ID: <xmqq8rydrq7p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: ED418234-3817-11EC-9841-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> URL being an acronym, it deserves to be kept uppercase.

Yes!  Thanks.
