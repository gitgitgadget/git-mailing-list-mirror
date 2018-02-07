Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860ED1F576
	for <e@80x24.org>; Wed,  7 Feb 2018 11:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeBGL6I (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 06:58:08 -0500
Received: from cpanel2.indieserve.net ([199.212.143.6]:51724 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753496AbeBGL6H (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 06:58:07 -0500
Received: from 69-196-158-250.dsl.teksavvy.com ([69.196.158.250]:56832 helo=android-a172fe96dd584b41)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1ejOMY-00032x-RT; Wed, 07 Feb 2018 06:58:06 -0500
Date:   Wed, 7 Feb 2018 06:58:06 -0500 (EST)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@android-a172fe96dd584b41
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: is http://git-scm.com an *official* git-affiliated site?
In-Reply-To: <CACsJy8CWkjoFvDmB_EEvrJR=4snFqnVGUKvo_vR33asOXB3CWw@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.1802070656020.11183@android-a172fe96dd584b41>
References: <alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41> <CACsJy8Dt_TjfRk05oNW8DXrdn6s_QV8NQZKnnrgGkj3WTN_=3A@mail.gmail.com> <alpine.LFD.2.21.1802070637190.7359@android-a172fe96dd584b41>
 <CACsJy8CWkjoFvDmB_EEvrJR=4snFqnVGUKvo_vR33asOXB3CWw@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 7 Feb 2018, Duy Nguyen wrote:

> On Wed, Feb 7, 2018 at 6:41 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> > On Wed, 7 Feb 2018, Duy Nguyen wrote:
> >
> >> On Wed, Feb 7, 2018 at 5:54 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >> >
> >> >   i ask WRT whether it should be up to date. i'm currently writing a
> >> > number of git-related wiki pages, and i want to link to whatever are
> >> > the canonical man pages for various git commands,
> >>
> >> I think this one is updated often by Junio (Git maintainer)
> >>
> >> https://www.kernel.org/pub/software/scm/git/docs/
> >
> >   whoops, just noticed that there is still no entry for "git subtree"
> > there; is there something about that git command that makes it so hard
> > to track down? :-)
>
> git-subtree is not an official command, so it's not there.

  i'm going to push back a bit on that since, at the bottom of the man
page for git-subtree, it states:

  GIT
       Part of the git(1) suite

so either it's part of the git suite, or it isn't.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
