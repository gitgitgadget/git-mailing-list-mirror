Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0A481F463
	for <e@80x24.org>; Wed, 25 Sep 2019 13:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391575AbfIYNbi (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 09:31:38 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:30827 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391587AbfIYNbi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 09:31:38 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iD7OK-0002Dy-4D; Wed, 25 Sep 2019 14:31:36 +0100
To:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Subject: Bi-Weekly Standup - Time/timezone in calendar?
Message-ID: <a56e5ebe-53ba-5f20-5606-b4b17dc660b5@iee.email>
Date:   Wed, 25 Sep 2019 14:31:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

At the Virtual Git Contributors Summit we discussed (#13) the bi-weekly 
standup meetings (mentioned in the Git Rev News edition 55 under 
'News/Various').

The Git Events calendar [1] that's linked from the Rev News doesn't 
actually say what time zone to use for the stand-up start time, so at 
first glance one can get confused by summer time and national time zone 
differences.

Currently it's saying (when clicked on, via 'more details')

Git Standup
Monday, September 30⋅6:00 – 7:00pm
Every 2 weeks on Monday

I thought it was to be 1700 UTC, which currently is 1800 BST her in UK, 
and 1900 CST in Europe.

If I hover over the event (have to restart the calendar), I (depending 
on view) do get an indicator in the lower left status bar that
"Events shown in time zone: Coordinated Universal Time". but with a 5pm 
indication in the calendar sheet.

Is this google calendar trying to be too clever, or should "1700 UTC" be 
included in the event details? I don't use Google calendar except for 
occasional reference.

Philip


[1] 
https://calendar.google.com/calendar/embed?src=nk8ph2kh4p5tgfcctb8i7dm6d4%40group.calendar.google.com

