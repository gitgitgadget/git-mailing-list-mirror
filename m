Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36661C4332F
	for <git@archiver.kernel.org>; Sat, 31 Dec 2022 18:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbiLaSLc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Dec 2022 13:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaSLa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2022 13:11:30 -0500
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F339FFD
        for <git@vger.kernel.org>; Sat, 31 Dec 2022 10:11:29 -0800 (PST)
Date:   Sat, 31 Dec 2022 18:11:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=164.ooo;
        s=protonmail; t=1672510287; x=1672769487;
        bh=T5Y24W6oSR9aL90fCG8orSyFwWuKNPvnBjo4QeajVqs=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=GDd2bUeKhuyMdoi5QGH9zeswsdfcOq2RkqwG9dtfZlLUJ22yZC1y/Uugw6qFdJLo/
         jVRHnPBK8DVMgP1U40AAQB3KY+/z69HWXx+ZitSdRJM5jCc1ufwDnsWmVcwhG7daEF
         pNtQ/ApdcnDjOUx8w4M5bTuadNtna50nc5Eb9Impxe2UYLLt/Z/JHeneTsPKdVmNNo
         C9T/GQxnENvRrcAQVFtc/pv0J2sNPvsXpeOPdoPFuZlEeAjJ2qxp/FKOhf3RrNEBfR
         5jCLuYzaHAZPTVgqZNnXflejb64esR6/vOsKJPgY/jo/eNW/VrjIByJsMiDDboe5/g
         yLqAuF27HZAUg==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Filip Lipien <aaa@164.ooo>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Subject: Request to remove Junio C Hamano as the Git Maintainer
Message-ID: <7hfRSnKTRnT4uJh5Pok8U8gfLm_NXzCS6w_7_Rc9OH3a9Lv8hpjySZqxDglBFC-fTOdZHi-ODCihiEHlQD9nIhUmld5jYvRx_JvB0z2IAL0=@164.ooo>
Feedback-ID: 62565958:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are more than one million questions on Stackoverflow related to the u=
sage of Git.
This is not normal.=C2=A0

Git is in its current state not a tool that's made for humans.

It's realistic to assume, that=C2=A0millions of working hours were wasted d=
ue to his ignorance of=C2=A0developer experience.
The financial damage goes into the billions.

I hereby request the removal of Junio C Hamano=C2=A0=E6=BF=B1=E9=87=8E=
=E7=B4=94 as the Git Maintainer.
