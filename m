Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01DCE1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 14:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754585AbcJEOyp (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 10:54:45 -0400
Received: from mail.javad.com ([54.86.164.124]:43264 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753148AbcJEOyi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 10:54:38 -0400
Received: from localhost6.localdomain6 (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id A9D7A633DB;
        Wed,  5 Oct 2016 14:46:28 +0000 (UTC)
Received: from localhost6.localdomain6 (localhost.localdomain [127.0.0.1])
        by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u95EkOU3020659;
        Wed, 5 Oct 2016 17:46:27 +0300
Received: (from osv@localhost)
        by localhost6.localdomain6 (8.14.4/8.14.4/Submit) id u95EkOOc020655;
        Wed, 5 Oct 2016 17:46:24 +0300
From:   sorganov@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Sergey Organov <sorganov@gmail.com>
Subject: [PATCH 0/6] git-merge: a few documentation improvements
Date:   Wed,  5 Oct 2016 17:46:18 +0300
Message-Id: <cover.1475678515.git.sorganov@gmail.com>
X-Mailer: git-send-email 2.10.0.1.g57b01a3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sergey Organov <sorganov@gmail.com>

Sergey Organov (6):
  git-merge: clarify "usage" by adding "-m <msg>"
  Documentation/git-merge.txt: remove list of options from SYNOPSIS
  Documentation/git-merge.txt: fix SYNOPSIS of obsolete form to include
    options
  Documentation/git-merge.txt: improve short description in NAME
  Documentation/git-merge.txt: improve short description in DESCRIPTION
  Documentation/git-merge.txt: get rid of irrelevant references to
    git-pull

 Documentation/git-merge.txt | 63 ++++++++++++++++++++++-----------------------
 builtin/merge.c             |  2 +-
 2 files changed, 32 insertions(+), 33 deletions(-)

-- 
2.10.0.1.g57b01a3

