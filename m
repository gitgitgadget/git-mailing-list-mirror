Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EEC1F454
	for <e@80x24.org>; Mon,  4 Nov 2019 15:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfKDPDq (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 10:03:46 -0500
Received: from fossies.org ([144.76.163.196]:41548 "EHLO fossies.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbfKDPDq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 10:03:46 -0500
Received: from fossies.org (localhost [127.0.0.1])
        by fossies.org (8.15.2/8.15.2) with ESMTP id xA4Et7kH014817
        for <git@vger.kernel.org>; Mon, 4 Nov 2019 15:55:11 +0100
Received: from localhost (admin@localhost)
        by fossies.org (8.15.2/8.15.2/Submit) with ESMTP id xA4Et7Ar014808
        for <git@vger.kernel.org>; Mon, 4 Nov 2019 15:55:07 +0100
Date:   Mon, 4 Nov 2019 15:55:07 +0100 (CET)
From:   Fossies Administrator <Jens.Schleusener@fossies.org>
To:     git@vger.kernel.org
Subject: Some misspelling errors in the git release 2.24.0
Message-ID: <alpine.LSU.2.21.1911041316270.23271@fossies.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 144.76.163.196
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

although misspelling corrections are not the most exciting issues and the 
spelling errors are rarely true code bugs but mostly contained in the 
comments and documentation parts they correction may still improve the 
overall quality of a software project a little bit.

In this sense I created a code misspelling report for "git" using the 
program "codespell"

  https://fossies.org/linux/misc/git-2.24.0.tar.xz/codespell.html

or version independent

  https://fossies.org/linux/misc/git/codespell.html

The latter URL redirects always to the report of the last "git" release 
supported on Fossies (if such a report was requested resp. is existing).

Principally it's possible to make further runs not only on "git" releases 
but also within a separated test environment on master or branches. If you 
found FPs please inform me and I will rerun the analysis.

Regards

Jens

-- 
FOSSIES - The Fresh Open Source Software archive
mainly for Internet, Engineering and Science
https://fossies.org/
