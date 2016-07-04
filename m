Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1B620179
	for <e@80x24.org>; Mon,  4 Jul 2016 18:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbcGDS3c (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 14:29:32 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:49549 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcGDS3c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 14:29:32 -0400
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
	by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id u64ITR87008764;
	Mon, 4 Jul 2016 21:29:28 +0300
Date:	Mon, 4 Jul 2016 21:29:26 +0300
From:	Konstantin Khomoutov <kostix+git@007spb.ru>
To:	shawn wilson <ag4ve.us@gmail.com>
Cc:	Konstantin Khomoutov <kostix+git@007spb.ru>,
	Git List <git@vger.kernel.org>
Subject: Re: split directories into branches
Message-Id: <20160704212926.919a267706a6fa5791c47726@domain007.com>
In-Reply-To: <CAH_OBie4dUB8WXfmKhLaezVKi0=LhnFw=wKJO1c3oUMA7VkYdw@mail.gmail.com>
References: <CAH_OBieCcx0_=vuZgoJ8GrZhhReEAhnjrz2pQwbwGgPFww4JmQ@mail.gmail.com>
	<20160704203946.3ac8d3205c08bfaee9a93a46@domain007.com>
	<CAH_OBie4dUB8WXfmKhLaezVKi0=LhnFw=wKJO1c3oUMA7VkYdw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, 4 Jul 2016 14:15:58 -0400
shawn wilson <ag4ve.us@gmail.com> wrote:

[...]
> > I know Git tracks content, not files (and directory) but still many
> > folks have "stable" directories for their files, assign certain
> > semantics to them etc.  I've needed such transfers myself, and this
> > topic has been raised more than once by folks over there on the
> > git-users mailing list.
[...]
> Thanks for pointing out the users list - didn't notice it and sorry
> for posting a user question on a dev list.

I don't possess the official stance on this topic but AFAIK user-level
questions are fine on this list.  The git-users mailing list was
created -- as I understand it -- because of three reasons: 1) it's
easier to post to; 2) you don't receive all the bug reports and patch
traffic irrelevant to mere mortals; 3) you have good chances to get
even RTFM questions answered (mostly by those who just had RTFM
recently), though I'd say stackoverflow is better at this one. ;-)
