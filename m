Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PYZOR_CHECK,
	RCVD_IN_DNSWL_HI,TVD_SPACE_RATIO shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C7D820248
	for <e@80x24.org>; Tue, 19 Mar 2019 06:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfCSGyR (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 02:54:17 -0400
Received: from mx.sdf.org ([205.166.94.20]:55744 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfCSGyR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 02:54:17 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Mar 2019 02:54:17 EDT
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2J6krvX011272
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO)
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 06:46:53 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id x2J6krWE017093
        for git@vger.kernel.org; Tue, 19 Mar 2019 06:46:53 GMT
Date:   Tue, 19 Mar 2019 06:46:53 GMT
From:   George Spelvin <lkml@sdf.org>
Message-Id: <201903190646.x2J6krWE017093@sdf.org>
To:     git@vger.kernel.org
Subject: git-format-patch and dates
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

