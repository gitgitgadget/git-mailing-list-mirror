Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE2AF1F424
	for <e@80x24.org>; Sun,  8 Apr 2018 09:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbeDHJIB (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 05:08:01 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:55620 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbeDHJIB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 05:08:01 -0400
Received: by mail-wm0-f47.google.com with SMTP id b127so11380687wmf.5
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Zka48IFdqQY4FH025/POKsSzK3uOHneMIn5H75T+7eQ=;
        b=gypqNQLQRYxy9f/7vD0sA4dvyMzZAMY05j2vxJqfIl7+CLfIscLQa6x+9Wy5YWKfik
         QECEGLrW+zKoGtttEzayO1wZnBJpilfKjFu/2xKg08V0fxm4d70C/sommoNPebchhnqx
         p1DwxE7sU3xIehZqhOJBZmVCyvaO0XHB8cn4pTtkfv+/z2RBZC1O4riPzxCoZd/CslJW
         GdzVscQUseMm1J3msXASASjmoPfwp/khhKuzimRXxhRwpRhZSLopZ2nEn7XmLrsupHWX
         +pEqcDCj0efy3BZYwenNeeRYDgF9Rzd/h4Ayf1r+pWJBTxr+F25hZCs18wU8qjJpawsm
         mmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Zka48IFdqQY4FH025/POKsSzK3uOHneMIn5H75T+7eQ=;
        b=bPbSSGl6OUc4CJ++NuqEEjuq7ZUadMbVDZGwVeT27vpp/D1sRwsp4gtYTDwRrQmty/
         sFzSRu58jdTpdwCfp8Z5V8lS22sUiIdqvVLwBPq90IqPNxcnmThIChsn1jv3QiAnqHZE
         v+ehrDSAL2USZA7CtbxyUQzMFSWXKYjZuj2qkrLfuWK/Q/+YfXtKo3VcyIb0Gw6XnCg5
         RjxnVTH9QrQ76f1f0vd+g4kMS/Bat5YAQqXNO929z0DIf3EEr8JoJohgzWeEQaxZDkzx
         zZQBMYdjC13irS++O1zxn8Bw+FH1gd32uEIbKxpZfCSu/tgotgh43dbIPtevPUrFksAU
         dJhw==
X-Gm-Message-State: ALQs6tATflcPV5af4cybXY7H0SwxjryTLdH0mPl1cr9u/POdiyqWsRcv
        yfLGicPQHWKXpJO/YzBl44SVNzsrk6vpkCTqpYbCNg==
X-Google-Smtp-Source: AIpwx4+7H1qywuZ5UrPAOVTBlddepf2Rj/SKACZmKpJIet9oe6uldDZQ7xQhlGi4iinqMKF6JO4uiFesIODq/3NJ0v0=
X-Received: by 10.46.48.15 with SMTP id w15mr20193410ljw.79.1523178479706;
 Sun, 08 Apr 2018 02:07:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:6d1b:0:0:0:0:0 with HTTP; Sun, 8 Apr 2018 02:07:59 -0700 (PDT)
From:   jiangwei zhao <wei257429821@gmail.com>
Date:   Sun, 8 Apr 2018 17:07:59 +0800
Message-ID: <CAJ1nrkCrvFAR4qD1ay9CCG80mRUf1BhcRtV21rOSh6BzVSoY6w@mail.gmail.com>
Subject: something about git clone
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hello!
  i am a chinese.
  i have some question for you ,i want to know how 'git clone'work,
it likes downloader? or other things. i think it'sdown speed is
heigher,so i email to you .
thanks ,and my english is so poor.:P
