Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF191C3F2CD
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E2E2467D
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 19:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgB2TE3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Feb 2020 14:04:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:58194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727247AbgB2TE2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Feb 2020 14:04:28 -0500
Received: (qmail 11399 invoked by uid 109); 29 Feb 2020 19:04:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 29 Feb 2020 19:04:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26400 invoked by uid 111); 29 Feb 2020 19:13:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 29 Feb 2020 14:13:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 29 Feb 2020 14:04:12 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Contributor Summit Logistics
Message-ID: <20200229190412.GA546926@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The Git Merge Contributor Summit is this coming Thursday (March 5th), so
here are a few logistical details.

The plan is to have a videoconferencing setup so that people can join
remotely and actually participate. This will be through Zoom (the same
as last year's stream, and the virtual contributor summit). The URL will
be:

  https://github.zoom.us/j/680215398

The plan is to have actual discussion from 10am to 4:30pm PST (-0800).
I have the zoom meeting configured to let people connect without me, but
I'll try to be logged in at least a half hour before if people want to
connect and check their setup.

As far as topics go, I'll plan to do the usual whiteboard voting in the
morning. That's not very inclusive of remote people, so I'm happy to
take topic proposals here, or we can use an online tool if somebody has
a good suggestion for one.

The rest of this email is all details for people attending in-person. If
you're just joining remotely, you can stop reading.

The location is:

  Downtown Loft, 1054 S Olive St, Los Angeles, CA 90015

We have the space from 9am-5pm. I've scheduled 10-4:30 for actual
content, so we'll have 9-10 for arrival/mingling/breakfast and 4:30-5
for winding down. Breakfast and lunch will be provided (the latter at
12:30). The events folks will pull any dietary preferences from your Git
Merge registration; if you have any changes or special needs there, you
can email events@github.com.

My understanding is that the venue is fully accessible, but if you have
any concerns or requests, please email events@github.com.

Please bring your Git Merge badge from the day before, since we'll use
those for door access.

There's no dinner or other event planned for that evening. I figured
we'd let people break ad hoc into smaller groups if they want to for
dinner. But if somebody wants to plan something bigger, please be my
guest (we have 30+ people attending).

A final note on travel and coronavirus: to the best of my knowledge, the
current plan is that Git Merge and the contributor summit will go on as
planned. I'll reply to this thread if I hear any change there.

Let me know if you have any questions.

-Peff
