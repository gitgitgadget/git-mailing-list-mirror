Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54FB21F403
	for <e@80x24.org>; Tue,  5 Jun 2018 12:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeFEMKf convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 5 Jun 2018 08:10:35 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:34828 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751707AbeFEMKe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 08:10:34 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id EDB744671A
        for <git@vger.kernel.org>; Tue,  5 Jun 2018 14:10:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter02.heinlein-hosting.de (spamfilter02.heinlein-hosting.de [80.241.56.116]) (amavisd-new, port 10030)
        with ESMTP id IyQEhHeHKhMH for <git@vger.kernel.org>;
        Tue,  5 Jun 2018 14:10:31 +0200 (CEST)
Date:   Tue, 5 Jun 2018 14:10:31 +0200 (CEST)
From:   Tim Friske <me@tifr.de>
To:     git@vger.kernel.org
Message-ID: <374116891.50361.1528200631824@office.mailbox.org>
Subject: Git not creating merge commit when merging signed/annotated tag
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

ten days ago I asked on https://unix.stackexchange.com/ why Git is not creating a merge commit when merging a signed/annotated tag. Does someone has an answer to my question https://unix.stackexchange.com/questions/446154/git-not-creating-merge-commit-when-merging-signed-annotated-tag?

Thank you in advance!

– Tim
