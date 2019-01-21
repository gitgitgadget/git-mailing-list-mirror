Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E129D1F453
	for <e@80x24.org>; Mon, 21 Jan 2019 20:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfAUUDG (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 15:03:06 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:44111 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfAUUDG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 15:03:06 -0500
Received: by mail-lj1-f182.google.com with SMTP id k19-v6so18521463lji.11
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 12:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bNu/wLe7VvUA9JNqFWbGl/qzfUZrxtyIf1auFMsb2pg=;
        b=kW1Hp5rARxmSihP+yCW1d8ELCsu/CUS4JTWGnif88cMAnmOY/oP05vkMYUYvmSuZkJ
         0fN+SjXeYRPk3Zlwt0zIys+O456dtw5a8Ckd8Hrou4MJ/6/Rk3mjYqRhk4NqVuyUYlu1
         vTwx0BioYbp7PV1PuCO3Jj2jg1N6g+wSyLvCXfVmmE7FcKiJdQEQ4lsU1a2EKSWPaqeW
         qu4za5yqgDApeRYQCC5m1n1x1qd2eMKukTg90SdFid2ZLYMo0pJ9OSeaw3dkWum3feUy
         5cGVT3a4ssk8qwVxVP0ryzSQZoL4RUgGwoTd56BPu3h2TN3nKa1jgSM8fnhEQrZAngsT
         tuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bNu/wLe7VvUA9JNqFWbGl/qzfUZrxtyIf1auFMsb2pg=;
        b=UVk/tHoVJEMWAd1VGQD1yfYys3s9SH/ff6y5oGkLDQebF2Et/GFncx15H0jtXcRgls
         g0xAwaWVCoGr1Q8oiGcdHUaxZ1ZgayKr6+Yv6bvKDoL3B60lt2U2/wDbVoLYZMVpCql/
         zXil1CFGmN2PQMEl3vuyt9o3jbjjVX/cYppQFhNXnokPSTP1ZXXP2xypZr3zpFARw5xD
         0wrCIhpaid75lOWLsfL5ee40lU8Bby7n0r2VFPoGETXCQTlnn1PHIoaCJYvLGRG2GY1s
         raEX9uHNW6pVcBSKIbffYpYm0pqZzBUUiwkDIWSylsxNaI47zNBhNP9GL1lVsBtdpKXk
         4QJQ==
X-Gm-Message-State: AJcUukfSZWx122k3HnPvccro8DE4xL80WdBa8IAAcdOsKk6ARaFNrLCx
        Kn1zFVIYlLc0T+Qm23/+97KRc6FwZ3aA4ZnQmXbv6csGFwQ=
X-Google-Smtp-Source: ALg8bN6Z7peBOA+bPf/V5vzQNnlfgStzCil5iKjFHbkioNijkSzQ7I38c/aj/fIQCjpqiFo17B1sK9CRwgvCOSbDI4o=
X-Received: by 2002:a2e:568d:: with SMTP id k13-v6mr19067727lje.105.1548100984630;
 Mon, 21 Jan 2019 12:03:04 -0800 (PST)
MIME-Version: 1.0
From:   Stefan Xenos <sxenos@google.com>
Date:   Mon, 21 Jan 2019 12:02:53 -0800
Message-ID: <CAPL8Ziv9LKBBXnCdWcG6r19zBs6SW-f_OvBbBncMqFjLSyPyqA@mail.gmail.com>
Subject: Missing patch?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've tried to upload a patch twice but it doesn't seem to be showing
up in my mailbox or in the mailing list archives. The patch title was
"[RFC PATCH] evolve: Implement the git change command".

Has anyone seen it? Is there a reason the mailing list would reject a patch?

  - Stefan
