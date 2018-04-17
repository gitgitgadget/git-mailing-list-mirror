Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 239611F513
	for <e@80x24.org>; Tue, 17 Apr 2018 06:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeDQGSQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 02:18:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51790 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbeDQGSP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 02:18:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 151121F404;
        Tue, 17 Apr 2018 06:18:15 +0000 (UTC)
Date:   Tue, 17 Apr 2018 06:18:14 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>,
        Andreas Heiduk <asheiduk@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] git-svn: commit-diff does not support
 --add-author-from
Message-ID: <20180417061814.GA19648@dcvr>
References: <20180410183224.10780-1-asheiduk@gmail.com>
 <20180410183901.11859-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180410183901.11859-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> wrote:
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>

Thanks.
Signed-off-by: Eric Wong <e@80x24.org>

And pushed for Junio:

The following changes since commit fe0a9eaf31dd0c349ae4308498c33a5c3794b293:

  Merge branch 'svn/authors-prog-2' of git://bogomips.org/git-svn (2018-04-12 08:05:28 +0900)

are available in the Git repository at:

  git://bogomips.org/git-svn.git svn/doc

for you to fetch changes up to ceb4d16198586f110aad5fbbd7eb68eec7a0c5cd:

  git-svn: commit-diff does not support --add-author-from (2018-04-16 21:24:30 +0000)

----------------------------------------------------------------
Andreas Heiduk (1):
      git-svn: commit-diff does not support --add-author-from

 Documentation/git-svn.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
