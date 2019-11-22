Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950ACC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D1520708
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 20:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKVUb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:31:28 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:54776 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKVUb2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 15:31:28 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 1CED71F463;
        Fri, 22 Nov 2019 20:31:28 +0000 (UTC)
Date:   Fri, 22 Nov 2019 20:31:27 +0000
From:   Eric Wong <e@80x24.org>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Announcing git-mentoring@googlegroups.com
Message-ID: <20191122203127.GA5292@dcvr>
References: <20191114194708.GD60198@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191114194708.GD60198@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> wrote:
> The community expectations for the mailing list are the same as those
> for the main Git list, but posts are only visible to members (anyone can
> join) in order to create a more private space for beginner questions.

It would be better to promote anonymous or pseudonymous posts
if beginners aren't comfortable...

> For now, posting is limited to members only (again, anyone can join) -
> but if we find a high incidence of needing to forward messages to and
> from the main list, we can change that permission as needed.

...because anybody can expose the archives, anyways.  And right now,
messages aren't visible to generic search engines, either; so fewer
people can get helped...
