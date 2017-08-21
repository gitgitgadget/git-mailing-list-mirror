Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACD9C1F667
	for <e@80x24.org>; Mon, 21 Aug 2017 08:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752351AbdHUIV2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 04:21:28 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:33388 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbdHUIV1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 04:21:27 -0400
Received: by mail-ua0-f176.google.com with SMTP id q40so5839069uag.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=12PKr5tLAlrZV9r5NQqn3RlJ7iGtlIMw8303fHnIQzc=;
        b=syNeVgH6jFcUcSviUkj8w9MhdsSu/jNxT0i6WyiAd7JxDAotFNOb+dp/jC/YIdC7+c
         0pqu/72rVulaJeQ0Zoi9Z0lumIyDo48cHHYNn+QlHW2P0zRr/47tdRyPbwfJzP5z+zJk
         UqT57Vgn5S1bsw7uSzxnN6OJwpuCioArT/3CbHtz8QkmC1kEdHVvfUh8JKpW/ypAxGkS
         f9dnYQxnqh7texmFvx94ZFHgFPQlCogZB41cc6r6Ox381KX9IWsgwyqyPh3kr32AHERz
         +9CaRt2t/QtAtKPeZRwpyaYPd4c4bTQLLGNj978TqL/RHQPR3oaFjY5phM+w4cpRjTuF
         MT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=12PKr5tLAlrZV9r5NQqn3RlJ7iGtlIMw8303fHnIQzc=;
        b=dsSoxoDufOFJnpLYj2bgXjEQWNEorCWBBYrzXALR2emdL6+PK+mbGiKANmQ/YVvhHq
         ECbhDhRLIo1SH6iPn2ULYElNEtqT0NEWqJfGKUI7BQO7/WF0ToduTtJfyMJrWHOT0Y0V
         qSHzSNtZaI6WMtbp5oYjcXwzeCKBhzY8wWJxb4ynKM2/J/wU6wdKGHSPUfkIv0x0DbeO
         cf2jqJfrEGTc7uGVAEz5z3dfd6DZrfpckFbN7o3nlw6yoOGZ0DPdjuhynVW0k/6hoMuu
         /NHMN9oj30wj6znVMJGnGAt/q7NPiVXNb2eVOVjUCXh7bs9t1K5DZpGPxL/16UnpTKXP
         sA3w==
X-Gm-Message-State: AHYfb5gcyKpHleGgO7NH5YJJo4jKdAfli+pz7MOh9939kuphJ5VUPTMX
        BoJeX8j1WUBUjBXBOZPK1sdWUjGEvm0Smm8=
X-Received: by 10.159.40.5 with SMTP id c5mr7474300uac.11.1503303686359; Mon,
 21 Aug 2017 01:21:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.111.68 with HTTP; Mon, 21 Aug 2017 01:21:25 -0700 (PDT)
From:   STEVEN WHITE <stevencharleswhitevoices@gmail.com>
Date:   Mon, 21 Aug 2017 01:21:25 -0700
Message-ID: <CAJXxHvVzTrhJk6pFsOzUKBuU2VcW41-tMk5A7s+rxXsacXpppw@mail.gmail.com>
Subject: "Your branch is up-to-date ..." is incorrect English grammar
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Either of these two options is CORRECT:

=E2=80=9CYour branch is up to date =E2=80=A6=E2=80=9D

=E2=80=9CYou have an up-to-date branch =E2=80=A6=E2=80=9D



But =E2=80=9Cyour branch is up-to-date=E2=80=9D is INCORRECT. And, because =
it=E2=80=99s
incorrect, it conveys an odd and unsettling experience to native
English speakers whenever they read it.



If you=E2=80=99re curious, you can find plenty of discussion of this point =
of
grammar. Here=E2=80=99s just one example:
https://english.stackexchange.com/questions/180611/do-i-keep-myself-up-to-d=
ate-or-up-to-date-on-something.



Regards,

Steve
