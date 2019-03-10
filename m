Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8007C20248
	for <e@80x24.org>; Sun, 10 Mar 2019 03:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfCJD3L convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 9 Mar 2019 22:29:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36367 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfCJD3L (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 22:29:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so1190034wmj.1
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 19:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zYJ7+HuLfZLIVAbVczhEPgYfp6fO2pgTEkCjegicsag=;
        b=E0Ly6QjV11FhyUVryR8YUqpeEJHz8OBAyF0TPosg1RC5tZDB1w3UkF/ECPI5+D1b7R
         TKPQvtmh6s08oyS7oUbrhWF5+K6F3tHKpSCKemZZZZpSm/LaC2/ai/aR0286mPvz7rN2
         L20kebSkhYNeu2U6Y12mg9vSIoM3GsCV7mOXgBVn8sPLSD6qFZNehTa51BWT4xm3aoLV
         JLseg+BxUVjgwNV7YLP1n536NHbPTQS58HkmWfyN8Tq/HmMPejlh+GDxPuJznYuNgnu9
         rRuHT4BQs28Uw6byL1t99rD23AwwSbxTh5k7GvJt2tWNGfjicCQIsKyJsCMSPGyhPbiU
         DzOA==
X-Gm-Message-State: APjAAAUYA6NDZZ0CYBMjBnQVyqzkFi/Poe3V/GtOfh6Tio8puC/69osi
        gjTMdfjkbRIj4TWopphW63DwHOm81Z4RvUhDA1s=
X-Google-Smtp-Source: APXvYqy/zerwtOuxX/8d/Sy0M3Hyjihbr0fDptjOi6iYQnsW+gX86etqPS2hpM2ZlSEFSO7/8gI97R2AdaQC5RSbPOU=
X-Received: by 2002:a1c:c010:: with SMTP id q16mr13816684wmf.134.1552188549890;
 Sat, 09 Mar 2019 19:29:09 -0800 (PST)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-2-pclouds@gmail.com>
In-Reply-To: <20190308095752.8574-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 9 Mar 2019 22:28:59 -0500
Message-ID: <CAPig+cRwU_csMj_UYTZUFXgwCz8-R4QSs=08K_oT-1-zEpA2NQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/21] git-checkout.txt: spell out --no-option
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 8, 2019 at 4:58 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
> It's easier to search for and also less cryptic.
> ---

Your sign-off is missing from the entire series.
