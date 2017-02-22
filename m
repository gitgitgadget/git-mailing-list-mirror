Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FCD32023D
	for <e@80x24.org>; Wed, 22 Feb 2017 09:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754457AbdBVJpE (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 04:45:04 -0500
Received: from smtpq6.tb.mail.iss.as9143.net ([212.54.42.169]:46462 "EHLO
        smtpq6.tb.mail.iss.as9143.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751347AbdBVJpB (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Feb 2017 04:45:01 -0500
X-Greylist: delayed 1067 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Feb 2017 04:45:01 EST
Received: from [212.54.34.117] (helo=smtp9.mnd.mail.iss.as9143.net)
        by smtpq6.tb.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <jessie@jessiehernandez.com>)
        id 1cgTCb-0003MX-4W
        for git@vger.kernel.org; Wed, 22 Feb 2017 10:27:13 +0100
Received: from 53546d64.cm-6-5b.dynamic.ziggo.nl ([83.84.109.100] helo=jessiehernandez.com)
        by smtp9.mnd.mail.iss.as9143.net with esmtp (Exim 4.86_2)
        (envelope-from <jessie@jessiehernandez.com>)
        id 1cgTCb-0004Pi-2L
        for git@vger.kernel.org; Wed, 22 Feb 2017 10:27:13 +0100
Received: by jessiehernandez.com (Postfix, from userid 112)
        id 656952236D; Wed, 22 Feb 2017 10:27:12 +0100 (CET)
Received: from mail.jessiehernandez.com (localhost [127.0.0.1])
        by jessiehernandez.com (Postfix) with ESMTP id 00C0A2236A
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 10:27:04 +0100 (CET)
Received: from 185.46.212.86 (proxying for 145.30.124.15)
        (SquirrelMail authenticated user jessie)
        by mail.jessiehernandez.com with HTTP;
        Wed, 22 Feb 2017 10:27:05 +0100
Message-ID: <44fd4dce451fb0783de02c0a8c4a14aa.squirrel@mail.jessiehernandez.com>
Date:   Wed, 22 Feb 2017 10:27:05 +0100
Subject: [RFC][Git GUI] Make Commit message field in git GUI re sizable.
From:   "Jessie Hernandez" <jessie@jessiehernandez.com>
To:     git@vger.kernel.org
User-Agent: SquirrelMail/1.4.23 [SVN]
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-SourceIP: 83.84.109.100
X-Ziggo-spambar: /
X-Ziggo-spamscore: 0.0
X-Ziggo-spamreport: CMAE Analysis: v=2.2 cv=AMjotSop c=1 sm=1 tr=0 a=O0j+lLEKKvAiBX9A7DJArw==:17 a=8nJEP1OIZ-IA:10 a=n2v9WMKugxEA:10 a=sPby5YCG9STretb-KT4A:9 a=wPNLvfGTeEIA:10
 none
X-Ziggo-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I have been using git for a few years now and really like the software.
I have a small annoyance and was wondering if I could get the communities
view on this.

When using git GUI I find it handy to be able to re-size the "Unstaged
Changes" and the "Staged Changed" fields.

I would like the same thing for the "Commit Message" field, or to have it
re-size with the git GUI window.

I can re-size the "Commit Message" vertically when making the "Modified"
panel smaller.

Does this make sense?
I would be happy to get into more detail if that is necessary or if
something is not clear.

Thank you.

-----------------
Jessie Hernandez


