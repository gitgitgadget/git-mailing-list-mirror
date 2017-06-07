Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CF2A1FAEB
	for <e@80x24.org>; Wed,  7 Jun 2017 23:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbdFGXcd (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 19:32:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48022 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751665AbdFGXcc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 19:32:32 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 7FD171FAEB;
        Wed,  7 Jun 2017 23:32:26 +0000 (UTC)
Date:   Wed, 7 Jun 2017 23:32:26 +0000
From:   Eric Wong <e@80x24.org>
To:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: describe git svn init --ignore-refs
Message-ID: <20170607233226.GA7061@starla>
References: <20170607183214.21259-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170607183214.21259-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> wrote:
> Add the missing documentation for `git svn init --ignore-refs`.
> 
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>

Thanks, signed-off and pushed for Junio:

  The following changes since commit 8d1b10321b20bd2a73a5b561cfc3cf2e8051b70b:

    Sync with maint (2017-06-07 09:32:04 +0900)

  are available in the git repository at:

    git://bogomips.org/git-svn.git master

  for you to fetch changes up to 16fbca07e295358406dfad88c4a9721f57357cbc:

    doc: describe git svn init --ignore-refs (2017-06-07 23:10:09 +0000)

  ----------------------------------------------------------------
  Andreas Heiduk (1):
        doc: describe git svn init --ignore-refs

   Documentation/git-svn.txt | 16 ++++++++++++++++
   1 file changed, 16 insertions(+)
