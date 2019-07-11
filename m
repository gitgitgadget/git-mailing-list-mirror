Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_EMPTY_SUBJ,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764241F461
	for <e@80x24.org>; Thu, 11 Jul 2019 20:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfGKULq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 16:11:46 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:39735 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfGKULp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 16:11:45 -0400
Received: by mail-io1-f51.google.com with SMTP id f4so15376379ioh.6
        for <git@vger.kernel.org>; Thu, 11 Jul 2019 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=a67+Xn2ScPIinix0jYfRqCmskGmMpaGSAycuaim21OI=;
        b=q/coBXIs74Rm4lRKtI6fpcZ5v8qCa6+o7g4qDpOAh4hpvAZBjokJ5Wz5y+NEsUVPGY
         eWxbsqS6rW4dul/sEYOQZ2v9NdQ1RKwzPjt/fMbenfGGqZOH78Cr79vZcgpldlC6hNDC
         Tmq+13Cnw5g4x6cPO+VLu5t6cgIVrNJ1wFSF/YfqOx8oY8RtNYs1heKTouRMgYhKD8Tu
         d+0Zl13Pbj6IfU471A70hfjiD0MKEVYCpS4bc3gc1FWT7C+qyQPA0uQ1zTqPhTm4NBFE
         XFU3qGe1C1UWi+Gs5jzyY0vC8FIO24uBXzbWm8u0lep+GFwKG7PM2Hg4I5EvJVzxF13v
         Fe5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=a67+Xn2ScPIinix0jYfRqCmskGmMpaGSAycuaim21OI=;
        b=jMf4I2c50OXEpWvI40lscfEfDBGQTDtSv/D9AMOXMfReNqEJclR2CaV6H7nqUJPUeO
         cn6gD2cq1v04Ft4XdvR3AAWbHzbiR2wPMFVxBnkOeiLidzlFIv7Y4hBADLR0fVpZraZr
         lUqdFeAoJf4OFV99g4aSZf7nMjU8y9lbCPwuL9WARJOnhkHBpmOatlqAqOhCymoLmjGq
         7tVu4SRhhbu+WuFcyhfaJcUnGKnDVjrq/VKUi7m6/aMZK638Fqnm9AfLiEyYTV1QjS3N
         V7a/l5eiedm2STfY36FnPNXwC3FOdGyNe0obgNpEm7GObI0qvs23xfKlCL13BxlKf6Zr
         2K+w==
X-Gm-Message-State: APjAAAUhmxH4Q2ZzQ16NQWVmJFuazgDjzdMB//8mLcez0baT+evSawbK
        bDfHHyzGjFwO5pI2z8TZXfwUGwDE+pdiCaJTWCxgaQ==
X-Google-Smtp-Source: APXvYqwQKz2fuY7rp8baToarq/WJEQyHqkjRmSObwMQUR1kpMhyGjFAM3ooU6e7RVwidP6dQ+Nmf11vJ3Q72j9lRgMg=
X-Received: by 2002:a02:aa1d:: with SMTP id r29mr6846943jam.127.1562875904183;
 Thu, 11 Jul 2019 13:11:44 -0700 (PDT)
MIME-Version: 1.0
From:   Robert Morgan <robert.thomas.morgan@gmail.com>
Date:   Thu, 11 Jul 2019 15:11:33 -0500
Message-ID: <CAMgm5nNRYQpjFeDA=tLZax_vdn4F1nxH4EgbbLY0or7dnYG2Hg@mail.gmail.com>
Subject: 
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

subscribe git
