Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 192061F404
	for <e@80x24.org>; Fri, 16 Mar 2018 14:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752837AbeCPOIM (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 10:08:12 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35623 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752832AbeCPOIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 10:08:09 -0400
Received: by mail-io0-f169.google.com with SMTP id e7so2311544iof.2
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 07:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=h6YDpTPdRjQiDgdtjStU1ZL/uApcUGVfVf93DhrGgoY=;
        b=TTSYjq2uiEUQLtNdsN3lIdrfbyVcfzNyquZZCvgf6YYqRJZ2cJkOrTQaJ3Ot05vysm
         cmvCdvyzNeDyQ6hoaBEEHslDjM+S/7byFCbAcgrQUNeitMGS9S0zDBJ4Fjkdip6JZcfo
         2kjxOnJVI0J+c5T3pHsc+d4a9EVuSlv50qZWoibuXywfdYZ5ctFzU9ms1wcmBxp/z3zM
         0zxxw+IpLtk/P8ZyyKcmCBbI7lVSyOecY4uXrLhePcTS4emihE6n8RLPlAeuj13trjKC
         8ThaqJmmDoQSHiqfAgxJvvcptEQ0X5DZLUVaRAa+VMN86H7RDAcMOKe7WuWeLnD4+UHg
         fZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=h6YDpTPdRjQiDgdtjStU1ZL/uApcUGVfVf93DhrGgoY=;
        b=jItYSDVkkNnlKvrX6VeCOL/ZayzZzlU7/MgwcVvHrp9Ij9xyE8vKH0UcZ1TCQJ+K7n
         11gIhCPhwdb5goVCIip/W/yiDaQL93qiJxD5JUq1LabzOcY9AZAAzaF2T6OOIofwhtKf
         NfsfK39+Q7GPOqInyaRYk3rUgC+b7UbE5IPfwVnuQPQuVdRnrR+UAaRggAnE3Oi5rQJo
         I6RTs9Uy4yQriU2McjM0TXSfn8lKIXXz7fuuLsTIPOCCbXBwdCAWqZmDw57/KDfMM1Qg
         i48a9W9ekoJcfuSDLyhHIPmo+8nyTjkMdhzI/ChuarPqBmH+Hm7yO1A/zZ8T1257SSU6
         TOkQ==
X-Gm-Message-State: AElRT7GsiCxAM1Bfd9OvSBMWD4pDmvjXUHomjY5HZVpzxU3nIyVyo/7Y
        XbJ7WPink/IUrqB8Rs0226D9wKNPFx4W430D5+oZzA==
X-Google-Smtp-Source: AG47ELswB/mU9VO2/3e1MU1CuiclVFUl4uioRdpd3FsCUrpodrUCCSbktiRoMiVgGED0CtSBqsGxxeHM724mBPI5CzQ=
X-Received: by 10.107.160.141 with SMTP id j135mr2023969ioe.124.1521209287523;
 Fri, 16 Mar 2018 07:08:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.192.228.74 with HTTP; Fri, 16 Mar 2018 07:08:07 -0700 (PDT)
From:   JYOTIK MAYUR <jyotikmayur7@gmail.com>
Date:   Fri, 16 Mar 2018 19:38:07 +0530
Message-ID: <CAHotnZWvtfKxmJii9g3K2OHBEBkh-AiRSXbc7tfZiyNGuXk6jA@mail.gmail.com>
Subject: Help...!
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

i am working on a project that is git hosting website like GitHub. I
am a student so i don't know much on how to make a website like GitHub
so could please tell me what can be the appropriate steps to make a
website like that(mostly the server part).
