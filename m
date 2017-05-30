Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD8F20D12
	for <e@80x24.org>; Tue, 30 May 2017 07:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750896AbdE3HVR (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 03:21:17 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34675 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdE3HVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 03:21:16 -0400
Received: by mail-oi0-f41.google.com with SMTP id b204so100877091oii.1
        for <git@vger.kernel.org>; Tue, 30 May 2017 00:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lPQ+MgQu03vPbrGZQua23gyJ/TOE8qsuypM6/qFjyRI=;
        b=HKgMbDwvGYvg8ym8+DR+14Df3SSoSxcEHMiNdrPItXliVmq8x9idaljfJUqDdF54m+
         WoYQSYae1c64Ik+38lFaLUZWy0FEF1RifE7Ej//wmKpMd52cIDXoqindX7SkJETbNb9K
         JMO9yfU2BbzKV6fKTVNXlJ4tz4IFh+4O1oDhSj8ICg5IQdL9Xl60wliGFkjFYNNi/MGl
         NQuNMhLDW+s+QgwjRWX0aMRGa1P6AHNdtyYa+XK6nims6NK7q+mSYvFg0c4IwhOlj8F7
         ArGNRg3SvKAOYtSpxsVLknnEAWoX/7OXk3s20anzuPZwv3Qv78gODOeBKse4GE/8unQH
         xkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lPQ+MgQu03vPbrGZQua23gyJ/TOE8qsuypM6/qFjyRI=;
        b=tYwsz6xxKxOZObDHGJnDGfnJcC3NDA011M9rfxwO1xaSFtUClSlquBC2EJDVQJvu5+
         eFvazCcnuRqvqs0UFIMIIvFsvaxEZa8ikUgfVXrhkRY1Z/QXfo+OHR+0nZSz3zbYPeXc
         LVHn0GS6yoJ2MGEPtsmT2KyaYcC+YhZ7x2W9jLbHIwRhevVYgqHRzCLDkowfoo4IxBJX
         5cy/rByc1ffYTrFIERW52YSc25BzBRDom9wYgDxEx380pSLvCd882AoGF+0yCmt7M2Gz
         ydQ9NKLtn7DBeq8ZWj8sAM7OEPWN3j1CGXIhfiCqfqGJ592HkGTbu3KyFrDpfyMK6mtM
         0EdQ==
X-Gm-Message-State: AODbwcC9xHoDKJKdBI0Hrmzh9QsxamTOsihCoeRM8iFE/W72PEQs6jiY
        wra7voFXt7a4lVbiKKLBKg7ckyav0D2i
X-Received: by 10.202.240.66 with SMTP id o63mr8285861oih.169.1496128875225;
 Tue, 30 May 2017 00:21:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.47.98 with HTTP; Tue, 30 May 2017 00:21:14 -0700 (PDT)
From:   The Intertainer <eminem.raunaq@gmail.com>
Date:   Tue, 30 May 2017 12:51:14 +0530
Message-ID: <CAMxySOmZxFPtwW-PZyhzqJMR-xMOUrWQzxq9jX5hXh=BrgzJYg@mail.gmail.com>
Subject: Unable to download Git
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,





I have been trying to download the '32-bit Git for Windows setup from
=E2=80=98 https://git-scm.com/downloads=E2=80=99  latest versiion i.e. 2.13=
.0 but just
cannot.

It downloadsl about 4-5mb but then says network error followed by
Failed -Forbidden. I downloaded the file on the chrome browser online
downloader.

I even ran the Windows Network Diagnostics but no error came up.



I hope you look into the issue and take the right steps to fix it.
Hope you reply soon.



Regards!
