Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C012C433E1
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 09:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7579E20734
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 09:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgGSJp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jul 2020 05:45:29 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54633 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSJp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 05:45:29 -0400
X-Originating-IP: 42.109.214.30
Received: from localhost (unknown [42.109.214.30])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DD582C0002;
        Sun, 19 Jul 2020 09:45:26 +0000 (UTC)
Date:   Sun, 19 Jul 2020 15:15:22 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [GIT PULL] git-gui pull request
Message-ID: <20200719094522.m6iopubstzvzrc73@yadavpratyush.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Please pull the changes in git-gui for Git v2.28.0-rc2. The changes this
time around the are fairly small (only one commit in fact).

Regards,
Pratyush Yadav

---
The following changes since commit c195247812f8cd38ba7e1c603112e6c1d8d8e71e:

  Merge branch 'il/ctrl-bs-del' (2020-05-21 18:25:32 +0530)

are available in the Git repository at:

  https://github.com/prati0100/git-gui.git

for you to fetch changes up to 469725c1a3d44f7e1475f1d37cd13e0824d4ea41:

  Merge branch 'mt/open-worktree' (2020-06-22 20:23:28 +0530)

----------------------------------------------------------------
Mikhail Terekhov (1):
      git-gui: allow opening work trees from the startup dialog

Pratyush Yadav (1):
      Merge branch 'mt/open-worktree'

 lib/choose_repository.tcl | 27 +++------------------------
 1 file changed, 3 insertions(+), 24 deletions(-)
