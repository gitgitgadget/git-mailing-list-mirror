Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C3901FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 14:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbcHNO6S (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 10:58:18 -0400
Received: from shell1.rawbw.com ([198.144.192.42]:61076 "EHLO shell1.rawbw.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752538AbcHNO6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 10:58:17 -0400
Received: from nad.dad.org (m206-54.dsl.tsoft.com [198.144.206.54])
	by shell1.rawbw.com (8.15.1/8.15.1) with ESMTP id u7EEwF8P099500;
	Sun, 14 Aug 2016 07:58:15 -0700 (PDT)
	(envelope-from norm@dad.org)
Message-Id: <201608141458.u7EEwF8P099500@shell1.rawbw.com>
X-Authentication-Warning: shell1.rawbw.com: Host m206-54.dsl.tsoft.com [198.144.206.54] claimed to be nad.dad.org
To:	git@vger.kernel.org
cc:	norm@dad.org
Reply-To: Norman Shapiro <norm@dad.org>
From:	norm@dad.org
Subject: Getting the "message" given a branch designation and conversely
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19499.1471186694.1@nad.dad.org>
Date:	Sun, 14 Aug 2016 07:58:14 -0700
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I am learning how to use git. I would like to know how:

Given a branch's designation, such as "master~4", how can I see the message I
furnished when I created the branch using "git commit"?

Conversely, given the message I furnished to "git commit", when I created a
branch, how can I see the branch's designation?

Context:

    Operating System: Red Hat Enterprise Linux Workstation release 6.8

    git version: 1.7.1

Thank you, very much.

    Norman Shapiro
