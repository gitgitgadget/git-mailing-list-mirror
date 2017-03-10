Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2381A1FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 16:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755462AbdCJQ7D (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 11:59:03 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:42423 "EHLO
        mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755050AbdCJQ7B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 11:59:01 -0500
Received: from tigra.domain007.com (tigra.domain007.com [192.168.2.102])
        by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4+deb7u1) with SMTP id v2AGvx3o016181;
        Fri, 10 Mar 2017 19:58:57 +0300
Date:   Fri, 10 Mar 2017 19:57:59 +0300
From:   Konstantin Khomoutov <kostix+git@007spb.ru>
To:     "COLLINS, ROGER W GG-12 USAF NASIC/SCPW" <roger.collins@us.af.mil>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git Vendor Support
Message-Id: <20170310195759.de1e06b0a28c8390b9b3b5c4@domain007.com>
In-Reply-To: <C81F618483B6A04381181BA5435FB9706A70191B@52ZHTX-D03-05E.area52.afnoapps.usaf.mil>
References: <C81F618483B6A04381181BA5435FB9706A70191B@52ZHTX-D03-05E.area52.afnoapps.usaf.mil>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Mar 2017 16:13:20 +0000
"COLLINS, ROGER W GG-12 USAF NASIC/SCPW" <roger.collins@us.af.mil>
wrote:

> ALCON,
> 
> Is there is a specific group or vendor backing Git?  As part of our
> internal approval process, our organization requires that we list a
> vendor that provides active support (ie. Patches) for the Git
> software.

As Git is a volunteer-driven free-software project, there are no vendors
behind it.

Looks like you basically have two options to fulfill the requirements
of your organization:

 * Contact the Software Freedom Conservancy [1] which is an official
   body serving as an aegis for Git and a bunch of other F/OSS projects.
   They are not vendor but at least they are a legal entity and are
   able to do law-speak.

 * Sign a contract with any company offerring support for Git or
   its Git-based solutions.  Atlassian might be an option (I don't know
   for sure -- just speculating, and I'm not affiliated with them
   in any regard).

1. https://sfconservancy.org/about/contact/
