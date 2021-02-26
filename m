Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF84C433E0
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD5C764EF3
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 16:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBZQTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 11:19:55 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:57073 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBZQTy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 11:19:54 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 422983A2F53
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 16:11:19 +0000 (UTC)
X-Originating-IP: 180.94.33.18
Received: from localhost (unknown [180.94.33.18])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 29E4BFF80F;
        Fri, 26 Feb 2021 16:10:05 +0000 (UTC)
Date:   Fri, 26 Feb 2021 21:40:01 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [GIT PULL] git-gui pull request
Message-ID: <20210226161001.x3j2pligndqnzlbu@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the changes in git-gui for v2.31.

---
The following changes since commit 
7b0cfe156e1f1fbb77ab35d55d48eef41625944d:

  Merge branch 'sh/inactive-background' (2020-12-19 01:02:34 +0530)

are available in the Git repository at:

  https://github.com/prati0100/git-gui.git 

for you to fetch changes up to b1056f60b63f1bc8226d01881bc829e171fc78bf:

  Merge branch 'py/commit-comments' (2021-02-22 20:19:53 +0530)

----------------------------------------------------------------
Mikhail Klyushin (1):
      git-gui: fix typo in russian locale

Pratyush Yadav (3):
      Merge branch 'mk/russian-translation'
      git-gui: remove lines starting with the comment character
      Merge branch 'py/commit-comments'

 git-gui.sh     |  5 +++++
 lib/commit.tcl | 18 ++++++++++++++++--
 po/ru.po       |  2 +-
 3 files changed, 22 insertions(+), 3 deletions(-)


-- 
Regards,
Pratyush Yadav
