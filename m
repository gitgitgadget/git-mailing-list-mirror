From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb wishlist
Date: Wed, 25 May 2005 12:16:23 -0700
Message-ID: <7vll63ktfc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org>
	<20050524184612.GA23637@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org>
	<20050524202846.GC25606@cip.informatik.uni-erlangen.de>
	<Pine.LNX.4.58.0505241410380.2307@ppc970.osdl.org>
	<20050524213102.GB19180@vrfy.org>
	<7vu0ksoxg4.fsf@assigned-by-dhcp.cox.net>
	<20050525094841.GA24172@vrfy.org> <42945961.8060708@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 21:16:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db1Kw-0001rJ-G8
	for gcvg-git@gmane.org; Wed, 25 May 2005 21:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261525AbVEYTQ0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 15:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVEYTQ0
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 15:16:26 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:31634 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261525AbVEYTQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 15:16:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050525191624.EGXR7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 25 May 2005 15:16:24 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <42945961.8060708@dgreaves.com> (David Greaves's message of
 "Wed, 25 May 2005 11:54:25 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

DG> Anyway, done now, give it time to replicate.

Thanks.  Would something like the following (1) easy to arrange
and (2) make your life easier?

    - make index.html symlink to git.html
    - have cron job to build and install those pages at
      www.kernel.org


