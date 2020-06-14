Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF8FC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 15:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D064206A4
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 15:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgFNPfb convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 14 Jun 2020 11:35:31 -0400
Received: from felt-1.demon.nl ([82.161.237.226]:35220 "EHLO felt-1.demon.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgFNPfb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 11:35:31 -0400
X-Greylist: delayed 1573 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jun 2020 11:35:28 EDT
Received: from [192.168.129.40] (x040.home.local [192.168.129.40])
        by felt-1.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id 05EFDSOL10748006;
        Sun, 14 Jun 2020 15:13:28 GMT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   "Michael Felt (aixtools)" <aixtools@felt.demon.nl>
Mime-Version: 1.0 (1.0)
Subject: Re: Rename offensive terminology (master)
Date:   Sun, 14 Jun 2020 17:13:28 +0200
Message-Id: <0795A4A3-4D5B-4AAF-B032-499700DFFFA5@felt.demon.nl>
References: <CAOhcEPZ6Ygm5fpiYpR1VnHv8ZrvMtOtjc+DwW2QZZy47JE45yA@mail.gmail.com>
Cc:     Simon Pieters <simon@bocoup.com>, Git Users <git@vger.kernel.org>
In-Reply-To: <CAOhcEPZ6Ygm5fpiYpR1VnHv8ZrvMtOtjc+DwW2QZZy47JE45yA@mail.gmail.com>
To:     Thomas Adam <thomas@xteddy.org>
X-Mailer: iPhone Mail (17F80)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Btw. The default branch, if it must have a new default label - how about calling it “default”?

Sent from my iPhone

> On 14 Jun 2020, at 16:59, Thomas Adam <thomas@xteddy.org> wrote:
> 
> ﻿On Mon, 4 May 2020 at 18:22, Simon Pieters <simon@bocoup.com> wrote:
>> To avoid offensive terminology and to avoid further inconsistency, I
>> think git should use a different branch name than "master" when
>> initiating a repo. I don't have a strong opinion, but I like "main"
>> since it shares the first two characters and it's shorter.
> 
> Hi Simon,
> 
> Definitely agree, and thanks for starting this.
> 
> One question that's been rattling round my mind is how we change the
> documentation to suit.  By that, I mean, it has become common parlance
> at the moment to say "master" as the canonical branch, because that's
> the one that's been baked as the default.  Now that we're making this
> configurable, I'm curious how we're going to change our semantics to
> match the "default" branch (which was "master") when talking about git
> branches, either here on the list, or in documentation.
> 
> Kindly,
> Thomas

