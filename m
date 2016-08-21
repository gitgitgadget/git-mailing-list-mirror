Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9951F6C1
	for <e@80x24.org>; Sun, 21 Aug 2016 15:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753324AbcHUPTr (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 11:19:47 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:19445 "EHLO shell1.rawbw.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbcHUPTq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 11:19:46 -0400
Received: from nad.dad.org (m206-54.dsl.tsoft.com [198.144.206.54])
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTP id u7LFJiMR090069;
        Sun, 21 Aug 2016 08:19:44 -0700 (PDT)
        (envelope-from norm@dad.org)
Message-Id: <201608211519.u7LFJiMR090069@shell1.rawbw.com>
X-Authentication-Warning: shell1.rawbw.com: Host m206-54.dsl.tsoft.com [198.144.206.54] claimed to be nad.dad.org
To:     git@vger.kernel.org
cc:     norm@dad.org
Reply-To: Norman Shapiro <norm@dad.org>
From:   norm@dad.org
Subject: Editing a typo in the message given to "git commit"
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28163.1471792783.1@nad.dad.org>
Date:   Sun, 21 Aug 2016 08:19:43 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am learning how to use git. I would like to know:

How can I correct a typo in the message I gave to an old "git commit"? I see
that the typo occurs in exactly two files in .git:

.git/logs/refs/heads/master
.git/logs/HEAD

/usr/bin/file says that they are both ASCII English text. So I could just
hand edit them. But that seems somehow sacrilegious and might break git.

    Norman Shapiro
