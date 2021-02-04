Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A71DC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 02:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 589D164F60
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 02:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhBDCGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 21:06:00 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:57686 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbhBDCF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 21:05:57 -0500
Date:   Thu, 04 Feb 2021 02:04:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1612404271;
        bh=SFAis802z+xUbMQgBFPw+WXxPbrRW4gmHJO/8BD6fIc=;
        h=Date:To:From:Reply-To:Subject:From;
        b=VGuzi6oYoRR2v+8c8mcyh+GnnYeot7qY4JdizICtkd97km12P7mcM0UTz8IiX82Pm
         L3LupjQ3WBSZuiFx0j1SCYYcvqo57w2bxfnw7expGDQiE5Zkf8ZbTc7w4gyW+LGL6n
         cS2Bt8QrJNV7bcP4iuYwbrpJJjLVKkRTPeRtTe+Q=
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>
From:   Joey Salazar <jgsal@protonmail.com>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: [Outreachy] Internship blog 2020 post #5
Message-ID: <J_m0qWQsKX4Tlw_DhkoSvN8fJelMJBbvRtiDApY6ngSF92EVYPAKciXm5s4ZAHz696OMPO1476ouLLuRhzH2bG1y3mk5gRLgsv8UzDn_E38=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all!

A new blog entry talking about Career Goals and post-Outreachy hopes, here =
[1].

Check it out!

PS: unrelated to the blog post, MR !1922 [2] ready for your feedback ^^ and=
 another one on the way soon.

--
Joey

[1] www.jsal.home.blog/2021/02/03/career-goals/
[2] gitlab.com/wireshark/wireshark/-/merge_requests/1922
