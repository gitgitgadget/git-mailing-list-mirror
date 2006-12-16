X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Fri, 15 Dec 2006 22:18:41 -0800
Message-ID: <7vk60sl5xa.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<200612132237.10051.andyparkins@gmail.com>
	<7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
	<200612140959.19209.andyparkins@gmail.com>
	<7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612141343200.18171@xanadu.home>
	<Pine.LNX.4.64.0612142307160.18171@xanadu.home>
	<20061215042459.GC27343@spearce.org> <45825E0B.5010200@op5.se>
	<20061215150909.GE17860@spearce.org>
	<Pine.LNX.4.64.0612151032240.18171@xanadu.home>
	<7vvekdvxeo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612151317380.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 06:18:59 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Andreas Ericsson <ae@op5.se>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612151317380.18171@xanadu.home> (Nicolas Pitre's
	message of "Fri, 15 Dec 2006 15:13:41 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34591>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvSsm-0006Ar-VV for gcvg-git@gmane.org; Sat, 16 Dec
 2006 07:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030635AbWLPGSn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 01:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030637AbWLPGSn
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 01:18:43 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:45613 "EHLO
 fed1rmmtao07.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030635AbWLPGSm (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 01:18:42 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216061842.PXJQ22053.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Sat, 16
 Dec 2006 01:18:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id zJJ21V0031kojtg0000000; Sat, 16 Dec 2006
 01:18:03 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> What about this (on top of my previous patch):

Looks good.
