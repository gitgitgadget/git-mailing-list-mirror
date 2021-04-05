Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAF8C433ED
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 10:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332186139E
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 10:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhDEKep (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 06:34:45 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:26232 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231991AbhDEKep (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 06:34:45 -0400
Received: from PORTABLETITI (unknown [IPv6:2a01:e0a:3ce:1760:10d7:72de:5e4c:b386])
        (Authenticated sender: legoupil.jp@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 4F6FE19F5AB
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 12:34:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1617618848;
        bh=VSiY/CIIihl/uGG9B9cUPD0+SZGC1i3OcQxL1OC/lQE=;
        h=From:To:References:In-Reply-To:Subject:Date:From;
        b=VzGWD6R1uZirDXwy6w+m3I3B1Y3JKS1nY0M2Bv//E7g0/hGMZgW0t0elB5jyAjCgu
         /JqaKFJoBzupBhYakySNzTiD6czQQwhenfmQ/WAIXK2dWBJwbwqkNiBQOLzMNJ/WSJ
         qRnf7Y+3679toS4opAnlOdWTYT+xsoGLOGvE5ShR4WAcRf8HLycKBQqi+EJReemU4o
         jhIXjgApvJyrLkKVxx5snhPq1pI+cyn2/S3wfCOfnRod9hseGkYkv+CDHyKAJDvi4z
         4HjtPKRqaSakll/KZ0ie+Hz4rlp1kuXJYtj7PkmFEt82Jti6XecXnPeSGSvB8/6XiG
         IlZUUlKUxeCGA==
From:   "Jean-Philippe LEGOUPIL Free" <legoupil.jp@free.fr>
To:     <git@vger.kernel.org>
References: <606968f85bfd6_3ff71824384fc@lowworker-78946b45bb-cr8gn.mail>
In-Reply-To: <606968f85bfd6_3ff71824384fc@lowworker-78946b45bb-cr8gn.mail>
Subject: TR: [GitHub] Deprecation Notice
Date:   Mon, 5 Apr 2021 12:34:07 +0200
Message-ID: <027b01d72a07$3593b810$a0bb2830$@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 14.0
thread-index: AQItKykuhysnMlTSVk10JJ7WtogUean5tsKw
Content-Language: fr
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I have installed your version of git on my computer, and setup =
AndroidStudio with it.

But I regularly receive now message below from GitHub but I don't know =
what to do to solve it (the associated link didn't help me...) because =
AndroidStudio seems to have token (???)

Can you help me please ?

Thanks
JP Legoupil

-----Message d'origine-----
De : GitHub [mailto:noreply@github.com]=20
Envoy=C3=A9 : dimanche 4 avril 2021 09:21
=C3=80 : Philoul
Objet : [GitHub] Deprecation Notice

Hi @Philoul,

You recently used a password to access the repository at =
Philoul/AndroidAPS with git using git/2.30.0.windows.2.

Basic authentication using a password to Git is deprecated and will soon =
no longer work. Visit =
https://github.blog/2020-12-15-token-authentication-requirements-for-git-=
operations/ for more information around suggested workarounds and =
removal dates.

Thanks,
The GitHub Team

