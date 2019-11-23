Return-Path: <SRS0=Rptp=ZP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AC0C432C0
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F215820706
	for <git@archiver.kernel.org>; Sat, 23 Nov 2019 00:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfKWARu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 19:17:50 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:35244 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKWARu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 19:17:50 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9FFCC1F463;
        Sat, 23 Nov 2019 00:17:49 +0000 (UTC)
Date:   Sat, 23 Nov 2019 00:17:49 +0000
From:   Eric Wong <e@80x24.org>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Announcing git-mentoring@googlegroups.com
Message-ID: <20191123001749.GA12923@dcvr>
References: <20191114194708.GD60198@google.com>
 <20191122203127.GA5292@dcvr>
 <20191122231921.GB101478@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191122231921.GB101478@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> wrote:
> On Fri, Nov 22, 2019 at 08:31:27PM +0000, Eric Wong wrote:
> > Emily Shaffer <emilyshaffer@google.com> wrote:
> > > The community expectations for the mailing list are the same as those
> > > for the main Git list, but posts are only visible to members (anyone can
> > > join) in order to create a more private space for beginner questions.
> > 
> > It would be better to promote anonymous or pseudonymous posts
> > if beginners aren't comfortable...
> > 
> > > For now, posting is limited to members only (again, anyone can join) -
> > > but if we find a high incidence of needing to forward messages to and
> > > from the main list, we can change that permission as needed.
> > 
> > ...because anybody can expose the archives, anyways.  And right now,
> > messages aren't visible to generic search engines, either; so fewer
> > people can get helped...
> 
> Hm, this is a little circular, right? Part of the rationale for keeping
> viewing limited was "that way it's not visible to generic search
> engines".

Sorry if I wasn't clear.  My points were:

1) limiting visibility harmful to helpfulness

2) trusting "members" to keep potentially embarrasing posts
   away from the public eye is unrealistic.  Let posters
   maintain anonymity or pseudonymity for themselves.
