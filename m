X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] vim syntax: follow recent changes to commit template
Date: Mon, 18 Dec 2006 00:02:06 -0800
Message-ID: <7vk60p1vk1.fsf@assigned-by-dhcp.cox.net>
References: <20061218072642.GA13858@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 08:02:23 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061218072642.GA13858@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 18 Dec 2006 02:26:42 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34725>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwDS0-0001k5-Jy for gcvg-git@gmane.org; Mon, 18 Dec
 2006 09:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753487AbWLRICK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 03:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753489AbWLRICJ
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 03:02:09 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62344 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753487AbWLRICI (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 03:02:08 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218080206.LBLM4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Mon, 18
 Dec 2006 03:02:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id 082J1W00S1kojtg0000000; Mon, 18 Dec 2006
 03:02:19 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This patch changes the syntax highlighting to correctly match the new
> text of the commit message introduced by
>   82dca84871637ac9812c0dec27f56d07cfba524c
>
> Signed-off-by: Jeff King <peff@peff.net>

Thanks.
