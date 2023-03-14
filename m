Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B114EC6FD1C
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 06:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCNGwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 02:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCNGwc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 02:52:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E32E85364
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 23:52:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso531356pjf.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 23:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678776738;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l4w6+/GgiPI2tZK9IWTYQnPZe7BFCsFc6Hq2Lc7AfQ4=;
        b=ZGOt6YSigDPj3IY+oLFdeKmchPJFXVTofwaOLWckONnmrxZGIV6cwehYuL+iCze/yk
         YUBCc2nPdSbw9hTlnn3l3qXNMlsOkmYKZRFzUS6REVC5SpCirg6UPTWmr8zWhEEh80vu
         AArnLDxo0D+ESQCosVitxpFSRaI8/lmiFOxN0X8y8oX+0Re6gA8spD6wxyxsDs5qgVJJ
         uw/5zH1DGqn+R5l6V/BNuIFr772FrNuZs2LAZAjxPLjGgTTrT7RvS68PSbkJMeLFxEOp
         /Ao7Hp4LkTmlSacQGM8Iohu25aOU5hRpN+CVWvhOapqUYBJmJaeMhKCVWlzDPUj7QBNy
         8GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678776738;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l4w6+/GgiPI2tZK9IWTYQnPZe7BFCsFc6Hq2Lc7AfQ4=;
        b=a47lZGZiug06nWnuh2NClL2dyccIA9/BcnGI04oKg2rGx3JG2yneHjhfy7Kd71SDyx
         9Oz4jrlYPnTUOHbwFIcYQBVAYKzY7XTmM+8HaRazuwuD92olWGdK4SoDp3siCFOM7x10
         v+tvMTbreHMbOzL6ho9Ssodp29Wn7vzBOWtja9yFRlv0x+GGaXou5jfXbJEqe+vW2km4
         lhXft8BqW/uMwU2as5Ew8Sd9SBd1NsEFz/8Acu62dyl6zrhoPmexgnfCZl9q4W5Kvwn9
         /EnoqMGXFLZ+YjEYBH8bzlIBu9Gb+KsqhB10FfL9XaZ9VTPY2heeEvWArMG7Iv7EHRPN
         Ri5w==
X-Gm-Message-State: AO0yUKUkwd055RPZlxnOuE81F38IghmgMkePBL+Ru6KVsw00kPNwgSa5
        5R4d+BE6ZtDTkkAQjakFnWZG1iYNwZ83BZG9XoyBpuwSct0=
X-Google-Smtp-Source: AK7set+RMATkS1zsUxF/9yOXzzC5NjWPtJ843elyfcDKCEmMYm/8jA3X3TOfMI+l26t3KMXoe2bihqJxKsgcX3roCww=
X-Received: by 2002:a17:90a:9a90:b0:23d:3ff1:87b8 with SMTP id
 e16-20020a17090a9a9000b0023d3ff187b8mr103171pjp.8.1678776738141; Mon, 13 Mar
 2023 23:52:18 -0700 (PDT)
MIME-Version: 1.0
From:   Aman Agarwal <agaraman0@gmail.com>
Date:   Tue, 14 Mar 2023 12:22:06 +0530
Message-ID: <CAP9kvTjvsEj3S+mUrsY+350o7BB7Ewd-O0yzLQo1DKUQp+DNUQ@mail.gmail.com>
Subject: unsubscribing
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

unsubscribe git agaraman0@gmail.com
