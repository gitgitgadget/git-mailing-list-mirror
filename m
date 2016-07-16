Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9EB72018F
	for <e@80x24.org>; Sat, 16 Jul 2016 19:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbcGPTTW (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 15:19:22 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:32089 "EHLO shell1.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751668AbcGPTTU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2016 15:19:20 -0400
X-Greylist: delayed 416 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jul 2016 15:19:20 EDT
Received: from nad.dad.org (m206-54.dsl.tsoft.com [198.144.206.54])
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTP id u6GJCM79069898;
	Sat, 16 Jul 2016 12:12:22 -0700 (PDT)
	(envelope-from norm@dad.org)
Message-Id: <201607161912.u6GJCM79069898@shell1.rawbw.com>
X-Authentication-Warning: shell1.rawbw.com: Host m206-54.dsl.tsoft.com [198.144.206.54] claimed to be nad.dad.org
To:	git@vger.kernel.org
cc:	norm@dad.org
Reply-To: Norman Shapiro <norm@dad.org>
From:	norm@dad.org
Subject: Question: Getting 'git diff' to generate /usr/bin/diff output
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24325.1468696341.1@nad.dad.org>
Content-Transfer-Encoding: 8BIT
Date:	Sat, 16 Jul 2016 12:12:21 -0700
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I am trying to learn how to use git, and am having difficulty using 'git diff'.

I can't deal with its output very well. What I would really like to do is apply
/usr/lib/diff. Would some kind soul be willing to tell me if there is a way to
do that, short of making a backup copy of the relevant file, and then doing
'git checkout'. Maybe the '--ext-diff' argument to 'git diff' will do that,
but I can't figure out how to use it.

Thank you, most kindly.

Context:

    Operating System: Red Hat Enterprise Linux Workstation release 6.8

    git version: 2.5.1.454.g1616360

 Norman Shapiro
