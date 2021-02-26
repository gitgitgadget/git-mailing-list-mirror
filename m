Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D84BC433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 22:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4289464F03
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 22:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhBZW0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 17:26:09 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:60394 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhBZWZ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 17:25:56 -0500
Date:   Fri, 26 Feb 2021 22:24:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1614378269;
        bh=hj1UL/nQBjJeXkDKD+PM7UUUyOmnTWEioxb1Nbdmbxk=;
        h=Date:To:From:Reply-To:Subject:From;
        b=jzVUj7rg9VJT35G5AkQqjDwSv6s6x7W98wwUHXUT0LCpbdIknoQwOROR116i/ROSN
         HsJmHZF0cBYmRK9UdBDD83SKz5cMW5iR6RGKFiGfVo2wqm6exfQ0TXk7K6oZbf3abD
         lO3uZhjfrvMQYlbxqFH7faPSggS0qP3ftPQF2IvU=
To:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>
From:   Joey Salazar <jgsal@protonmail.com>
Reply-To: Joey Salazar <jgsal@protonmail.com>
Subject: [Outreachy] Last Internship blog post, post #6
Message-ID: <JH4Wi8A_NoNMdML57D-RySWBJdknViBbC7hZWTwos3DZSRIsbPs0jK5t4w2-yCcDwlVZDITVvCzKK1BrkvHAcb2f6ozOA570rNnSBvTjjc4=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all!

The last blog entry for my internship is here [1], it talks about the achie=
ved goals and pending items for the next Outreachy intern. Check it out!

Thank you all in both the Git and Wireshark communities for the feedback an=
d guidance provided, I learnt a lot and had loads of fun.

--
Joey

[1] www.jsal.home.blog/2021/02/26/time-to-wrap-up/
