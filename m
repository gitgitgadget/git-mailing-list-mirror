Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DEAR_SOMETHING,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74EC11F453
	for <e@80x24.org>; Wed, 13 Feb 2019 19:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387419AbfBMTeZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 14:34:25 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:37165 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfBMTeZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 14:34:25 -0500
Received: by mail-wm1-f51.google.com with SMTP id x10so3659048wmg.2
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 11:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=VKE8Hb70agbgwFtF2wcxA/djQqge/RP4My1RKtCv4V4=;
        b=peQbJ7g5QGlbnpN3tTkrwqgqaZyzLqWU8ueKE1YTniN6j8TvPaRwxOVOl1mQ1r2Kno
         5dmXtLco/KFqaIISFFrPTlcRMHh+EZ57sYo9ulrw7RCK5vsh9B5n2KXu+ShSxGEwyF81
         B1IZNecDYC//Vj64TMwoR1z6wkktmLv4I87EWifFYVHcuP0dGLAGsKG+NLbMY31TokTP
         3bzoKliVJaRKKKsuVJKZ4acH8ve/fRCssL8ZTKg2V7pdJY1gikAU08DRkCRgxbMHfdXO
         xa1QEzJzYXlxc5ulm9NOSX3BBkQExEelZ64TlK6s5GqvooziL1k6xBN8JztfqZqlExV9
         0xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=VKE8Hb70agbgwFtF2wcxA/djQqge/RP4My1RKtCv4V4=;
        b=KSiTOn7NxL8+LihY0AudjlLF/lNH4HKKfY9rmFXS2SQVg1nL3uPahnZXPuLZavF5gl
         HYxaPAfKbTq5jrPC45X0BXJXS0XNpv89412ubN+9T4F9z1UYkQvMx/RId8Tr16k+x16m
         PYMAA+xQT+1qUpRQSY5fBa+CqNDtCUJA9hMSR7c3rX9GfjVuKTn5EHf4bhiCDB0PoOLi
         h+6+LjnzedtTxDs+mhjTURryHKCB8ou5x/lreuT03FADVltx9thyhtwK6+fWBOlh0Fsd
         xGn3ZHhpl4cQeZS5WC2WqeG0hccI+ITyp0bI05sjj8yMW3IWOr61uKwU9xeUB7Ml/fI3
         27CQ==
X-Gm-Message-State: AHQUAuYzY7PfPWWGAvYNYolIIwHCCeB3ofA1+s990CpNcSZCI5fV2Eps
        mdNoCRfWT97mTVrIZD3SaZjmH2x2SZYvUQ==
X-Google-Smtp-Source: AHgI3IYetm+P32w5RymE2f5tjI3qrhN9iZA9f4PSwjEXvoQMqkbIvH/MkZUWnNphg5Ihr0+s2C13Iw==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14mr1620498wmg.53.1550086463135;
        Wed, 13 Feb 2019 11:34:23 -0800 (PST)
Received: from [10.0.1.3] (host86-190-138-187.range86-190.btcentralplus.com. [86.190.138.187])
        by smtp.gmail.com with ESMTPSA id y24sm221929wma.0.2019.02.13.11.34.22
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 11:34:22 -0800 (PST)
From:   Agnieszka Borcz <agaborcz86@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Git - logo commercial use
Message-Id: <C9D9CE87-105E-4716-BF43-1D64239DD492@gmail.com>
Date:   Wed, 13 Feb 2019 19:34:21 +0000
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Sir/Madam,

My partner and I are in the initial stages of setting up an e-commerce =
business selling high-quality stickers of logos of popular software and =
libraries. We would mainly be marketing towards software developers, as =
there are many who enjoy placing stickers of their favorite tech on =
their laptops for display.

We would love to be able to include your logo as part of our inventory =
but aren=E2=80=99t sure of the restrictions regarding its use for =
commercial purposes, so we would like to find out what your policy is =
regarding this and if this would be a possibility?

We do not plan to modify or alter the logo in any way or claim that it =
is ours. To get a better idea of how we plan to use the logo, please see =
the following website, as this is very similar to what we plan to do: =
https://www.stickermule.com/unixstickers.

I see that others are already using your logo in a similar way on sites =
such as redbubble.com but wanted to double check your policy with you =
first.

We look forward to your response.

Warm regards,

Aga Borcz=
