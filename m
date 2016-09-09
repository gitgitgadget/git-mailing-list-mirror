Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289AA1F856
	for <e@80x24.org>; Fri,  9 Sep 2016 03:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbcIIDFW (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 23:05:22 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36474 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcIIDFV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 23:05:21 -0400
Received: by mail-vk0-f53.google.com with SMTP id m62so3819279vkd.3
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 20:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=Q72hY99VRE5WeyFxkITCV6MaL1ATKKZhx1Idmya3nDo=;
        b=HJXhSZD/+AmfNiM+VAFxXCw+RfITn0ZzPac7HFHd/oZ0mAVB5/VpoK6E4vdDpejvk7
         D5fOVeWuA3PEZQhoBjv4J9HSEhLN75P17MCsgAA5B8/TxO6d/a0E8/uE+4iyAIq7GHA+
         18XsnoedI4ZoMYkkg+/Huth9LBrurLV9+y1bXcnkPSyZR3zN5bKT5w6ScFKOM8tllkgt
         ytsajMNm68NoAVr0wGO4g0JRo2a6EgHcBQRm7ChmkM0yh0jhQiplvKzqsOYMVRVIug3h
         yAJHZNhPsteQ7DkuWwX+ZlGAdFGsTzVLLnAFxIDn2jUACKta7yKjfG6ymuff9KIddlX7
         PS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Q72hY99VRE5WeyFxkITCV6MaL1ATKKZhx1Idmya3nDo=;
        b=nLG0JI/4GV3EEJ8p1ri/TYUL6jxPgoUxFbC5sF07zNdh6HonJeHorRxUOWSRV58udx
         PQOX8br3pWmTxQ1Wg/qWirVGsSqY2BrB1kulVJ9NtmoufYYYyPq5KhBQBlm99RT7L5kC
         k/NPBfHvNTcYvtSI8bg7BrSP8dSYwf07VLgmjpI0wTkopkSMsvvt4cpkaR7Ru9+nV/wi
         +cak06Ue4z09sRPGJ0PiG/WoN/LTo9Iw2NTv4aQhJvvMpOw4P+UHhusCcb37NJfJh0ku
         WLEGpSZrDzE6BplGrx8UDK6+OD6lBtQREncYH9weLy72yvyLtvxEJuV1uiiLCq6gfvQC
         4JKg==
X-Gm-Message-State: AE9vXwM0WYYir9iaLcNVfTpoIVU4wMTb47M7L5kIvESc/JFq01yyYf+o0TFfrGeGk3Wxsp4426JAWyeY/NcyOQ==
X-Received: by 10.31.78.130 with SMTP id c124mr808254vkb.41.1473390320816;
 Thu, 08 Sep 2016 20:05:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.4.133 with HTTP; Thu, 8 Sep 2016 20:05:20 -0700 (PDT)
From:   =?UTF-8?Q?Andr=C3=A9_Marcondes?= <andremarcondesteixeira@gmail.com>
Date:   Fri, 9 Sep 2016 00:05:20 -0300
Message-ID: <CAHh1JP9=9OfdrKQA2mMXvHh2EFAkzSuLBQfjy9-X=LNvKQOStg@mail.gmail.com>
Subject: Git Bash and Git GUI freezing just after opening
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a fresh git installation on my windows 10 machine, but I am
unable to use the Git Bash or the Git GUI because the program freezes
just after opening.
The only difference I have made on my machine was to update Windows 10
Pro to it's latest version (build 14393.105) and change the default
Documents folder to another partition.
I really need to fix this. How can I get some help?
