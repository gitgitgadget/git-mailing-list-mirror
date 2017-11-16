Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BAFC202A0
	for <e@80x24.org>; Thu, 16 Nov 2017 20:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759393AbdKPUep (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 15:34:45 -0500
Received: from ikke.info ([178.21.113.177]:39474 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759251AbdKPUen (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 15:34:43 -0500
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 4CD10440803; Thu, 16 Nov 2017 21:34:42 +0100 (CET)
Date:   Thu, 16 Nov 2017 21:34:42 +0100
From:   Kevin Daudt <me@ikke.info>
To:     Frank Burkitt <fburkitt@burkitt.com>
Cc:     git@vger.kernel.org
Subject: Re: Git on Mac - Segmentation fault:11
Message-ID: <20171116203442.GA16181@alpha.vpn.ikke.info>
References: <CAHY2EeuCUh3bzdZxtmvC3H=j=QchLgvkuHaW_KWcVsD=-fJUFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHY2EeuCUh3bzdZxtmvC3H=j=QchLgvkuHaW_KWcVsD=-fJUFw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 05:30:23PM -0700, Frank Burkitt wrote:
> I am using Git on a Macbook pro with MacOS High Sierra version 10.13.1
> (17B48).  I have been using it in a virtualenv with python 3.  I have
> begun to get "Segmentation fault: 11" with every git command.  I have
> been searching for a reason why this is occurring but have not been
> able to find a solution.  I have reinstalled the operating system,
> uninstalled and reinstalled Git, and a variety of other attempts at
> finding a solution.  Is this a know issue? Any suggestions would be
> appreciated.

Hello Frank,

Could you provide a bit more information?

- What version of git are you using?
- how did you install git,
- Do you also get segfaults outside of the virtualenv?

This sounds perhaps like it's a copattibility issue with a library.

Kind regards, Kevin.

