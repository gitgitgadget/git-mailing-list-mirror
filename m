Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CD4C433E0
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 22:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2A523128
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbhAOWxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 17:53:48 -0500
Received: from mail-03.mail-europe.com ([91.134.188.129]:45932 "EHLO
        mail-03.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAOWxs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 17:53:48 -0500
Date:   Fri, 15 Jan 2021 22:52:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1610751145;
        bh=DiheXm4vKo99ox3UKVcKN6Ef7Xzp+WpueICr38tJHzU=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=s2Zr/nA77/OYSHr1AMgB8AacmYnHzavQfwtBB1KNfjtwHwhz6fzvaCYn6xGTA04hY
         DnKF/wJOQNWjpu6ah3ubTVBYjCB1CMqC4Nscd3Mcx7IF218BSL4ehU52cpqv5GMbv3
         yt+NKpiMCYYDFzQqJsleflBPOM7fX/d/EMfPDBAE=
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>
From:   Joey Salazar <jgsal@protonmail.com>
Cc:     Richard Sharpe <realrichardsharpe@gmail.com>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: [Outreachy] Internship blog 2020 post #4
Message-ID: <Ob9M1_ccpEx1oFXTyR-5eXk_yHT3l8dVsq6Dj75QjkCBsQl5KTpN-WduKm2kVJbjTo5Ryeojb53TvVHdmVinapIX1ApNhEBUTjGZwlGm42A=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again everyone!

A new blog entry talking about the work and progress of the project so far,=
 here [1].

Check it out! This one does mention a new MR (!1714) and a commit for addin=
g HTTPS support (thanks Richard!).

Very looking forward to your feedback,
--
Joey

[1] www.jsal.home.blog/2021/01/15/modifying-expectations
