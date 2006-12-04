X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] move Git.pm build instructions into perl/Makefile
Date: Mon, 04 Dec 2006 02:31:42 -0800
Message-ID: <7v64csq7e9.fsf@assigned-by-dhcp.cox.net>
References: <20061121225911.GA24201@steel.home>
	<81b0412b0611300827h64722fa0i7e32808994a97a51@mail.gmail.com>
	<7vvektyi7n.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0612040156w794a276cqaa37f1734ba7a1ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 10:31:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <81b0412b0612040156w794a276cqaa37f1734ba7a1ca@mail.gmail.com>
	(Alex Riesen's message of "Mon, 4 Dec 2006 10:56:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33181>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrB6w-0007yp-Qe for gcvg-git@gmane.org; Mon, 04 Dec
 2006 11:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758364AbWLDKbo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 05:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758398AbWLDKbo
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 05:31:44 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:1505 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1758364AbWLDKbn
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 05:31:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204103143.FWOY18207.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Mon, 4
 Dec 2006 05:31:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id uaX81V0081kojtg0000000; Mon, 04 Dec 2006
 05:31:08 -0500
To: "Alex Riesen" <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

"Alex Riesen" <raa.lkml@gmail.com> writes:

> Updated patch attached.

Will apply, thanks, but with a few tweaks while I had to hand
munge your attachment anyway.
