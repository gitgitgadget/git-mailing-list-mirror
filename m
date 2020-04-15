Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F33C2BB85
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 09:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3222A206D9
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 09:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405626AbgDOJzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:55:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:36096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405623AbgDOJzd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 05:55:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4D473AE63;
        Wed, 15 Apr 2020 09:55:31 +0000 (UTC)
Date:   Wed, 15 Apr 2020 11:55:29 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: has anyone bothered to read this "Git is a security risk"?
Message-ID: <20200415095529.GA25468@kitsune.suse.cz>
References: <alpine.LFD.2.21.2004141612580.6138@localhost.localdomain>
 <20200414201701.sacbvbgt6ajde7gp@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414201701.sacbvbgt6ajde7gp@LykOS.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 04:17:02PM -0400, Santiago Torres Arias wrote:
> On Tue, Apr 14, 2020 at 04:13:39PM -0400, Robert P. J. Day wrote:
> > 
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__twitter.com_blubracket_status_1250123442600513547&d=DwIBAg&c=slrrB7dE8n7gBJbeO0g-IQ&r=yZMPY-APGKyVIX7HgQFZJA&m=k4RlH5EiWlU380Hq8LD-BPM9q79__emrQNq4FBNAbh8&s=7_aq2xl8ld0WDJk4yd_gefOvg47E8MdlXvcj5aZwjug&e= 
> > 
> 
> Yeah,
> 
> Not entirely fond of the phrasing to what reads to me like a
> static-analysis tool (from what I can grok) whitepaper.
> 
> I don't think there's much that can be done in this regard though, no?

There is. Education. Prevention is much more useful than any number of
such tools.

Thanks

Michal
