Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518341F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 19:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389424AbfAOTqo (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 14:46:44 -0500
Received: from mail-it1-f175.google.com ([209.85.166.175]:56233 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389349AbfAOTqo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 14:46:44 -0500
Received: by mail-it1-f175.google.com with SMTP id m62so6999830ith.5
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 11:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:cc;
        bh=hFKAHT6QyA4I6/OWo46mmvYacynQtbp11eRoAOvXze0=;
        b=U2g0bZbaLf6q7PHObLHGlF0ygAxZdmwgE5CgFGfJksYwijHyCoK5JMwY683qzqUOQO
         CMM9jNyFVH9A8q+Pcy3P6DGwjVYCaLhOpiOslu3a9f+IVAQCQZC8lNpsusP+3uHK6v/L
         vh075xz6Rc580s4eXmug4EkuPZiYu9pFGBAiis2ktorGeFkh60Ilnwk73gn7joH4yoAr
         TVPmzs4HkctfCML9QFPOZOvOaOu/ztA9azQTuXeUZZG81qsVohSWwBbAdEyGSk1hnMNm
         A3Hs2v2HPEBggoQrYgNPrG60/AM5jk6CT3LUpmfmwqagc+JXfqm/9dzlF18AdqfzScrS
         +Fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:cc;
        bh=hFKAHT6QyA4I6/OWo46mmvYacynQtbp11eRoAOvXze0=;
        b=q8WIi8Kex9Ajo5Sk7X46nP6kSqUc5hdsPCRD4kW9AVAFrFkjfgN2w51xtQ2jQRpmTL
         RO/t9KP8OxcxQ5Q9/YmZoBwzeDyjKwC6e+UjDmU5oelGxxp4dtxKiMTfP5qmSqSd9s6r
         svjAIQ1xVXnZHVsTmyTOPOZli9fuf/L8nv6jrTbAihsyeqClIdZfkOUaQu1c6362PxDE
         iHQVDthBbTtlt6XzXy6lvzfK+MlGJRAisFsE4OoycVaQkOKnhcitm8EG4F8PQ6izKa6+
         AJ965tCgtIcg3bydDzQeZrJqfrfE3M05wWp1PF7tBbp/ZEPrBQmane22EBRpd0Pwsb2Z
         dFiQ==
X-Gm-Message-State: AJcUukfDUgQD73ytds9bfj9Ab+y3NFvq4MDIXhrg5k9GmKwQrFWD3gyH
        YdJfzPA5IuIOFauDGkAF2/6BgLGnu4JZdcW2qZrumQ==
X-Google-Smtp-Source: ALg8bN6qtEBspqEL1EmOHMmlYha5MM0tEl5FfV3EY6A75ehEqpkdWB53ZFqmNfxaoYV4Pt8/W3cH2blpd9c9F31HZ4A=
X-Received: by 2002:a24:3512:: with SMTP id k18mr3380131ita.83.1547581603118;
 Tue, 15 Jan 2019 11:46:43 -0800 (PST)
MIME-Version: 1.0
From:   Kaustubh Shankar <kaustubhshan@gmail.com>
Date:   Wed, 16 Jan 2019 01:16:31 +0530
Message-ID: <CALM8fiaUqxscb0GWHTidXmaDv_2QqkzN4sybA377cr59G6+yCQ@mail.gmail.com>
Subject: New to git. Need help!
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,

I'm new to this mailing list and have also joined the IRC channel recently.
I want to start contributing by possibly fixing small bugs or errors.
I have gone through the suggested guidelines and documentation but it
is too large and I don't know where to start.
If anybody could help me out it would be much appreciated.

Regards,
Kaustubh Shankar
