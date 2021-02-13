Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE715C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 13:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA11B64E3F
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 13:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBMN0X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Feb 2021 08:26:23 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:20986 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhBMN0W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Feb 2021 08:26:22 -0500
Received: from [IPv6:2a01:e0a:562:1540:2499:88b1:dbb6:7c20] (unknown [IPv6:2a01:e0a:562:1540:2499:88b1:dbb6:7c20])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id E73F7B00533
        for <git@vger.kernel.org>; Sat, 13 Feb 2021 14:25:03 +0100 (CET)
Message-ID: <24e39c2c4b7b86aa4a671601a069eaee767a63fb.camel@free.fr>
Subject: git ability
From:   PANEL Christian <ch.panel@free.fr>
To:     git@vger.kernel.org
Date:   Sat, 13 Feb 2021 14:25:03 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (by Flathub.org) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hello,

does git have the ability to handle a repository on a removable disk?

here is the experience I had:

I have a project that I manage on a removable disk (therefore with a
".git" directory on it).

until now I did "commits" and "push" on the server from windows10.

I made changes to the source and made a "commit" from linux (on the
same computer). Git asked me again for my username (email and user
name): I then thought that these were not stored in the ".git"
directory

I then saw a new branch called "linuxcompatibility" appear.

I would like to understand.

I thought to myself that I would then merge the "linuxcompatibility"
branch to the "master" branch and push it all back to the server.

if that went well with me, on the server the branch
"linuxcompatibility" remained.

how to get rid of it: nothing seems indicated in the documentation.

Thanks for any clarification

