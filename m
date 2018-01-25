Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EE391F404
	for <e@80x24.org>; Thu, 25 Jan 2018 17:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbeAYRDL (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 12:03:11 -0500
Received: from scunmail02.zurich.com ([195.28.226.207]:1235 "EHLO
        scunmail02.zurich.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeAYRDK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 12:03:10 -0500
X-IronPort-AV: E=Sophos;i="5.46,412,1511823600"; 
   d="scan'208";a="466586579"
Received: from unknown (HELO chknh741.emea.zurich.corp) ([172.28.78.80])
  by cendm0258.emea.zurich.corp with ESMTP; 25 Jan 2018 18:02:49 +0100
Received: from b0d0p4a1.rz.ch.zurich.com ([10.41.48.42])
          by cendm0070.emea.zurich.corp (Lotus Domino Release 8.5.3FP3)
          with ESMTP id 2018012518023585-400551 ;
          Thu, 25 Jan 2018 18:02:35 +0100 
Received: from b0d0p4a1.rz.ch.zurich.com (localhost [127.0.0.1])
        by b0d0p4a1.rz.ch.zurich.com (8.15.1+Sun/8.15.1) with ESMTP id w0PH2ah2000802
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 18:02:36 +0100 (CET)
Received: (from w1001179@localhost)
        by b0d0p4a1.rz.ch.zurich.com (8.15.1+Sun/8.15.1/Submit) id w0PH2YFI000707
        for git@vger.kernel.org; Thu, 25 Jan 2018 18:02:34 +0100 (CET)
Date:   Thu, 25 Jan 2018 18:02:34 +0100 (CET)
From:   christian.del.vecchio@zurich.com
Message-Id: <201801251702.w0PH2YFI000707@b0d0p4a1.rz.ch.zurich.com>
X-Authentication-Warning: b0d0p4a1.rz.ch.zurich.com: w1001179 set sender to christian.del.vecchio@zurich.com using -r
To:     git@vger.kernel.org
Subject: GIT 2.3.1 - Code Execution Vulnerability
X-RouteServers: CN=CHKNH010/O=Zurich;CN=CHZNH010/OU=ZI/OU=Switzerland/O=Zurich;CN=CHKNH000/O=Zurich
X-DLP:  Scanned
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

dear Team

I am Christian Del Vecchio,and i work in the infrastructure of Middleware on Zurich.
we have installed in our system Sun your product in order to connect to our bitbucket repository.

we have followed the instruction provided on your Web Page:

https://git-scm.com/download/linux
pkgutil -i git

the version installed is the 2.3.1, and actually it works.

but last week our security team informed that this software didn't pass the check control due: Git Server and Client Remote Code Execution Vulnerability


please, is it available a newer version that fix this problem?

our system is: Sun Solaris v10 sparc

best regards
__________________________________________ 

Christian Del Vecchio 
Middleware SME 

Zurich Insurance Group Ltd. 
bac de Roda 58, 
Building C, 4th floor 
08019 Barcelona, Spain 

64402 (internal) 
+34 93 4465402 (direct) 
christian.del.vecchio@zurich.com 
http://www.zurich.com 
