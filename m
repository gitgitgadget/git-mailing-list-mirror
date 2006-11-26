X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sat, 25 Nov 2006 21:30:03 -0800
Message-ID: <7vfyc6ydus.fsf@assigned-by-dhcp.cox.net>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
	<ekafpm$fs7$1@sea.gmane.org> <7vvel3yuzz.fsf@assigned-by-dhcp.cox.net>
	<200611260034.23974.jnareb@gmail.com>
	<7virh2zxni.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 05:30:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7virh2zxni.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 25 Nov 2006 19:37:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32331>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoCaj-0003vE-0Y for gcvg-git@gmane.org; Sun, 26 Nov
 2006 06:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967299AbWKZFaF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 00:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935243AbWKZFaF
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 00:30:05 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:16817 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S935242AbWKZFaE
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 00:30:04 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061126053003.MMJT5465.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Sun, 26
 Nov 2006 00:30:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rHVY1V00Q1kojtg0000000; Sun, 26 Nov 2006
 00:29:33 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> In either case, I do not think generating _both_ by default is a
> bad idea.  They will become out of sync and the user either need

Eh, excuse me.  "generating both is a BAD idea" is what I meant...
