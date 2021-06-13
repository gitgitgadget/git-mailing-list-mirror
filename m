Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255C8C48BDF
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 23:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D66611CA
	for <git@archiver.kernel.org>; Sun, 13 Jun 2021 23:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhFMXaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Jun 2021 19:30:52 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:47013 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhFMXaw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Jun 2021 19:30:52 -0400
Received: by mail-ej1-f54.google.com with SMTP id he7so13311651ejc.13
        for <git@vger.kernel.org>; Sun, 13 Jun 2021 16:28:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzOALak2bN6kv2C9lEhtES77TQXvQlOLfGZJzTj1dJo=;
        b=dCBkuZ06lyBW0m9oCUjiwilAvW7mcbFMNl7/OngnF1mQn/DA9T+muC5ZdfAY0YZw50
         WC1o4pMKnx3qfptdh7q3QZxtbuGlWCLB4XyjicyWsFtsuYlxse04Gt0L02MmcsrdQT2w
         5iTmh4sz/dKepJeF2z5ocsknuPFRPOVwjl4y/HBMYUG4AF0WI1BQZXJb4a8PBzM+dzIa
         qaXJbKc73+OYtNUHAInMbLNH4QsYh3lqt1LEBKdHhoLOErAMyjq6G0PhRw96x1BdsZXf
         R5MS5/V616c3IVB6BkhZEs8b/Mh1ORLqt93c9fMsMqml/OwiO3OwhKNqcDW4Y7MrX0gS
         gAOQ==
X-Gm-Message-State: AOAM530B7jseOSuILzg/6MQB3WdK5gtJ6QkWGzrQxWvF+qrnBWb7YoTN
        RGPZJ7JXXSRnwQQLLvX94S/wfXw5I9Zb/4ugWHk=
X-Google-Smtp-Source: ABdhPJwklGPBlYVr8fg0Dr9Jx7ut/TRCzwInR1s/dgpd/QZ2HKINQi6HA4sczPKd3rvS07iRbyi+ggUJAM+CGZ1fvq8=
X-Received: by 2002:a17:906:a293:: with SMTP id i19mr12228523ejz.311.1623626914501;
 Sun, 13 Jun 2021 16:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
In-Reply-To: <CAOLTT8QHL-6-DxoRKtx5cVp_DePxtWYU4CuBweYfCG1hGZZhaA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 Jun 2021 19:28:23 -0400
Message-ID: <CAPig+cT09Y9GSTnbtY8d9e0=2C8398Ey=+p2e3L6tArOrsnaAw@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 4
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 13, 2021 at 10:18 AM ZheNing Hu <adlternative@gmail.com> wrote:
> My fourth week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Blog-3/

I suppose you meant: https://adlternative.github.io/GSOC-Git-Blog-4/
