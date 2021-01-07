Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7D4C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 03:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE949230F9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 03:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbhAGD3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 22:29:45 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:37100 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbhAGD3p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 22:29:45 -0500
Date:   Thu, 07 Jan 2021 03:28:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1609990101;
        bh=3iRAbLMDvj5xUGkYcmxqNxLtUENzn1/lZid/VVdkTNE=;
        h=Date:To:From:Reply-To:Subject:From;
        b=GFXmyTWu5YPl9/Ed+6QiiH1v9HjIJR+5VbVtvcmF/rvhy+HlmtLynnkI7a8HxtRZb
         /u9YfKvdGu7gpzxD5SqIVN/gY1kc8eCXwvok+KgcOAEoIrs2W9YQ9SJmk3PkkEii9E
         I8lZOYUl2PxkMAQoYnwdJZJ92R29SkHoqxb+5Gbk=
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "wireshark-dev@wireshark.org" <wireshark-dev@wireshark.org>
From:   Joey Salazar <jgsal@protonmail.com>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: [Outreachy] Internship blog 2020 post #3
Message-ID: <QQErW2YH2_v43WSO9XiMRaCcUglTY1szDusYI-xtSSMgw6K8pgLYX-SN09qAyvRYAj6Q9Jf_yKUQm-EgY_rLXUWkyrNhJEkBlJuBkoj6b0s=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

A new blog entry talking a bit about both Git and Wireshark here [1].

Check it out! Due to Xmas holidays last week, the next post will be there n=
ext week (as opposed to the 2-week break in between posts as usual).

Happy New Year everyone!
--
Joey

[1] www.jsal.home.blog/2021/01/06/think-about-your-audience/
