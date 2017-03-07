Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BAE61FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 21:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933207AbdCGVsv (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 16:48:51 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:56848 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933191AbdCGVss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 16:48:48 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 80C491FBEC;
        Tue,  7 Mar 2017 21:32:17 +0000 (UTC)
Date:   Tue, 7 Mar 2017 21:32:17 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>,
        Hiroshi Shirosaki <h.shirosaki@gmail.com>
Cc:     git@vger.kernel.org
Subject: [PULL] git svn branch authentication fix
Message-ID: <20170307213217.GA20443@starla>
References: <1488779947-25264-1-git-send-email-h.shirosaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1488779947-25264-1-git-send-email-h.shirosaki@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you.  I fixed spelling in the title (s/authenticaton/authentication/),
added my S-o-b, and pushed for Junio to pick up

The following changes since commit 3bc53220cb2dcf709f7a027a3f526befd021d858:

  First batch after 2.12 (2017-02-27 14:04:24 -0800)

are available in the git repository at:

  git://bogomips.org/git-svn.git svn-auth-branch

for you to fetch changes up to e0688e9b28f2c5ff711460ee8b62077be5df2360:

  git svn: fix authentication with 'branch' (2017-03-07 21:29:03 +0000)

----------------------------------------------------------------
Hiroshi Shirosaki (1):
      git svn: fix authentication with 'branch'

 git-svn.perl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
