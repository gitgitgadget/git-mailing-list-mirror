Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3170F2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 12:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752354AbcGGMuI (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 08:50:08 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:60414 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbcGGMtt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 08:49:49 -0400
Received: from glandium by zenigata with local (Exim 4.87)
	(envelope-from <mh@glandium.org>)
	id 1bL8kR-0005yr-8Q; Thu, 07 Jul 2016 21:49:43 +0900
Date:	Thu, 7 Jul 2016 21:49:43 +0900
From:	Mike Hommey <mh@glandium.org>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: counteract gender bias
Message-ID: <20160707124943.GA22668@glandium.org>
References: <d54f8f8b32ecc024eb3a58dd42ef9f855f8e2cb9.1467892022.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d54f8f8b32ecc024eb3a58dd42ef9f855f8e2cb9.1467892022.git.johannes.schindelin@gmx.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 07, 2016 at 01:47:19PM +0200, Johannes Schindelin wrote:
> Since d1c5f2a (Add git-am, applymbox replacement., 2005-10-07), i.e. for
> almost 11 years already, we demonstrated our disrespect to the pioneers
> of software development like Ada Lovelace, Grace Hopper and Margaret
> Hamilton, by pretending that each and every software developer is male
> ("his_tree"). It appears almost as if we weren't fully aware that the
> first professional software developers were all female.
> 
> We know our field to have this unfortunate gender bias that has nothing
> to do with qualification or biological reasons, and we are very sad
> about the current gender imbalance of the Git developer community.
> 
> Let's start changing that by using the variable name "her_tree" for an
> equal number of years out of fairness, and change to the gender neutral
> "their_tree" after that.

You make it sound like the decision to use "his" was conscious and on
purpose. I doubt that was the case, especially 11 years ago, when these
issues weren't as publicized. Let's not attribute to malice on part of
the people who wrote those lines what can be attributed to linguistics.

Mike
