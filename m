Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74D31F453
	for <e@80x24.org>; Thu, 14 Feb 2019 21:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437948AbfBNVXZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 16:23:25 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:44226 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbfBNVXZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 16:23:25 -0500
Received: by mail-ed1-f48.google.com with SMTP id b20so6229940edw.11
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 13:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U4ea8AaksJ8sGZ798S4C9pMFrkJFRdAkQ6LEOFFiy6c=;
        b=CH6e0yrz1AavktnAjQEUmGHfhByk7VNVlIj4quyiVFAK/RmuwbAQAVGuVvSCLuh7rB
         +pa1wPpyDYzA6VHx7NkQZiK+JKocikkpx9LXuFX9sI3gIl6lHHUxaeJtG3yyPfJt/pT1
         EqIU2gRAuTnIRfSR4mA2VhuRj/smNrb8gzIXqMH0hn7R2KYDLYMhQm4vlboiCy2BgKk+
         ZO9vO5A/8ZG3PC5kKFx1u2tl5yVkreYDYepq1BnlGHP2Jcsr+Nobp4C/ZSPiGKJMIpQm
         +K0RqEzU0LBZz1bkYBnoyIIYlvuboRC5BxFySL41VtbIVp3w0j6OXUfwsDOa9tnzfGg2
         BI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U4ea8AaksJ8sGZ798S4C9pMFrkJFRdAkQ6LEOFFiy6c=;
        b=e1X16wLtG2VezPidZTqBIu36FYOpJiIYGpLW5UO1wVkdWupxVdKpO6ODk+WqXnoMF0
         6DQaiwama2hD37ygE2ZX1y4c0XIDBaxOsWGEuBgNY45YIuu0aNS5t3WRWbhVo2RSDcoB
         B0Zx1L6egjE592ABDX5FL/DR7bUrspmsuJBxEbEUFrBbE6v0fICfPkqFIoonAdpdnQjj
         JnU6amV9ChVMy8VqbFUGqWp/hDEJJkXqcN7rtzCipNBHNnS5LiaSvM43o7XpCwh2qFnU
         6r+abPpRY9ATBwIhe6/3YqUM4hr2CTs/LbXkpAyV+8kmSlHhJMgIRemfzbyuCGke0ulu
         ckVg==
X-Gm-Message-State: AHQUAuavcJ0489tKkCFe2Yv04pExSGFwh7b/g6o8Hc8dDv3uGoHj5SEd
        QhVJqRE5zptpWBsNwmN60Cm2XEcvgJKuS/I/y23a9Ff54Ho=
X-Google-Smtp-Source: AHgI3IZBs62U8b5tjAdffBfOiRSnsOcAFhnoKe27myfhevDr2osPbOYQuVE/PK1R6c6as1j5EH2QBaQX6Xz/TFajcdQ=
X-Received: by 2002:a50:b0e5:: with SMTP id j92mr4510133edd.188.1550179403266;
 Thu, 14 Feb 2019 13:23:23 -0800 (PST)
MIME-Version: 1.0
References: <C9D9CE87-105E-4716-BF43-1D64239DD492@gmail.com>
In-Reply-To: <C9D9CE87-105E-4716-BF43-1D64239DD492@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Feb 2019 22:23:11 +0100
Message-ID: <CAP8UFD0hQcfTh57Ozhb9ydawAaXnC8PtXdD1ozBPFJo199xioQ@mail.gmail.com>
Subject: Re: Git - logo commercial use
To:     Agnieszka Borcz <agaborcz86@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Feb 14, 2019 at 12:50 PM Agnieszka Borcz <agaborcz86@gmail.com> wro=
te:

> We would love to be able to include your logo as part of our inventory bu=
t aren=E2=80=99t sure of the restrictions regarding its use for commercial =
purposes, so we would like to find out what your policy is regarding this a=
nd if this would be a possibility?

Did you check https://git-scm.com/downloads/logos ?

It contains the following:

"Git Logo by Jason Long is licensed under the Creative Commons
Attribution 3.0 Unported License."

and:

"This license lets others distribute, remix, tweak, and build upon
your work, even commercially, as long as they credit you for the
original creation. This is the most accommodating of the CC licenses
offered. Recommended for maximum dissemination and use of licensed
materials."
