Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA217C05027
	for <git@archiver.kernel.org>; Sun, 12 Feb 2023 15:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBLPzM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Feb 2023 10:55:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBLPzL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2023 10:55:11 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFA410A8F
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 07:55:10 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id s20so6450448pfe.2
        for <git@vger.kernel.org>; Sun, 12 Feb 2023 07:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FXgFGFSVeV+3VL3fr/v//0zQFP8+1copvM6EhCC9fUo=;
        b=EGj84GOiJrctwI5JBmqp8g7DtVjk1pVJXsHOzKRkStlBiZbQl45l8SlZl+48GeZgFl
         AYwPYy/TipxBhafMyx2XEQjqRE/DVb6SF8ntVnT+bKYZEVtI1jWVB2bmr+d5xN9Ipqdo
         /zfE3GcYpFZWcRuPJeOpWbYn8g4xTMokt5xa/PnlMz6SI8yhZlyImTtDT8LA6GahDDhW
         JNZuFrAhfBtjxyZjq6KCR53VDnV8/n4I5tnVapJGN1UvXY93bev1f7mcIOeV1BwiqOus
         LIJ5d44ojkhFvQ/JA8j3Fj5tfh+YNnWvMEcttk6lyUoVAg/1cLWHr/Th3I+XkgSSSkXm
         Yv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXgFGFSVeV+3VL3fr/v//0zQFP8+1copvM6EhCC9fUo=;
        b=P6QSvfufLJTHpkGx72hbDsrfXiFlfEsX6KK4HuXaQYSjB2IuxgaAvXMZ+7lzUCTQ4g
         IUedT+6/cuzJwt6LRYKlmIgjign68KY69nVzvxM0VOjhbS1xfXFq8BRLYXwYtAiQooQN
         S/Yb/I7Uyy0r215YIsLMifEtQpDVDXfO6cmJpUeH94cqVLU2jD6HmJ1BCjtEZUjIp3s+
         55/7OuR+szfHtIAcYioR89hfKVUwZTN5xm5EvvFugePVKHh5XoFEJoRh228j3OwuSIHY
         alyXwMKkz0YvEGAjm5ieKOmqOPrBRaB0f0aX21XW2MReNP9PZOIIXZ0oub7Qw8n0IUDH
         tckw==
X-Gm-Message-State: AO0yUKUA/2hq4IeG6uqBFEytYY3L0iMNihvh70ei1wzS3uoDzysdsmGf
        kdX8r92XoseD2xzuZ/im7oCPpBZybxC1H4dyN2FvLX2ENMU=
X-Google-Smtp-Source: AK7set8gyWzJAqylhTeCdoa6+aqBAXsu6VuzJS6eHOOiZKfO4Ki1XXxI2LAnCi4HbN3PhoWYOCTEcbKpzDCyQlbyYTw=
X-Received: by 2002:a62:6181:0:b0:592:4543:162c with SMTP id
 v123-20020a626181000000b005924543162cmr4389494pfb.33.1676217309841; Sun, 12
 Feb 2023 07:55:09 -0800 (PST)
MIME-Version: 1.0
From:   Aman Agarwal <agaraman0@gmail.com>
Date:   Sun, 12 Feb 2023 21:24:58 +0530
Message-ID: <CAP9kvThRCjOnOFoCOXeHKT6H7kqYEWE+xK_9P1SMVRBFQSsjmw@mail.gmail.com>
Subject: Contributing to Git Source code | Open Projects | Patch Fixes
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I am trying to contribute and am looking for some patches and
projects, or to start contributing to the git source code. I would be
grateful if you could give me some helpful references to check for
patches or already-planned projects in git.


Thanks,
Aman
