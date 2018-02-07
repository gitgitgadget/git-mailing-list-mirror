Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F045E1F576
	for <e@80x24.org>; Wed,  7 Feb 2018 10:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeBGKyJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 05:54:09 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:44685 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753454AbeBGKyI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 05:54:08 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:56230 helo=android-a172fe96dd584b41)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ejNMe-0005y1-2e
        for git@vger.kernel.org; Wed, 07 Feb 2018 05:54:08 -0500
Date:   Wed, 7 Feb 2018 05:54:06 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@android-a172fe96dd584b41
To:     Git Mailing list <git@vger.kernel.org>
Subject: is http://git-scm.com an *official* git-affiliated site?
Message-ID: <alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


  i ask WRT whether it should be up to date. i'm currently writing a
number of git-related wiki pages, and i want to link to whatever are
the canonical man pages for various git commands, but that site seems
a bit off.

  if one follows a link to get here:

https://git-scm.com/doc

there is another link to the "Reference Manual" that promises "The
official and comprehensive man pages that are included in the Git
package itself."

  but upon getting there:

https://git-scm.com/docs

it seems clear that that page doesn't come close to covering all of
the available git commands.

  as an example, there is a link "submodule" on that page, which does
indeed take one to the page https://git-scm.com/docs/git-submodule. so
far, so good.

  however, while there is no link for the "worktree" command, there
does in fact exist a similarly-named web page
https://git-scm.com/docs/git-worktree.

  finally, there is no reference to the git "subtree" command, either
as a link *or* as an existing web page
https://git-scm.com/docs/git-subtree. it all seems kind of arbitrary.

  is there an actual, canonical set of online web pages for all
current git commands one should use?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
