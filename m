Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F45B20282
	for <e@80x24.org>; Thu, 15 Jun 2017 01:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbdFOBVh (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 21:21:37 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42694 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751836AbdFOBVg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 21:21:36 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id E82C320282;
        Thu, 15 Jun 2017 01:21:30 +0000 (UTC)
Date:   Thu, 15 Jun 2017 01:21:30 +0000
From:   Eric Wong <e@80x24.org>
To:     Andreas Heiduk <asheiduk@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-svn: document special options for commit-diff
Message-ID: <20170615012130.GA4829@starla>
References: <20170614093138.11861-1-asheiduk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170614093138.11861-1-asheiduk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Heiduk <asheiduk@gmail.com> wrote:
> Some options specific for `git svn commit-diff` where not documented
> so far.
> 
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>

Thanks again.  It's been a while since "commit-diff" :)

Signed-off and pushed for Junio:

  The following changes since commit 02a2850ad58eff6de70eb2dc5f96345c463857ac:

    Sync with maint (2017-06-13 13:52:53 -0700)

  are available in the git repository at:

    git://bogomips.org/git-svn.git svn-doc

  for you to fetch changes up to da446109ff75120a9836d21653e12154e58f8c46:

    git-svn: document special options for commit-diff (2017-06-15 01:09:31 +0000)

  ----------------------------------------------------------------
  Andreas Heiduk (1):
        git-svn: document special options for commit-diff

   Documentation/git-svn.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
