X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove --syslog in git-daemon inetd documentation examples.
Date: Wed, 25 Oct 2006 23:11:59 -0700
Message-ID: <7viri7k3m8.fsf@assigned-by-dhcp.cox.net>
References: <20061026063307.45872277.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 26 Oct 2006 06:12:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061026063307.45872277.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 26 Oct 2006 06:33:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30139>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcyTK-0006fn-63 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 08:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423448AbWJZGMF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 02:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423449AbWJZGME
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 02:12:04 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:34228 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1423447AbWJZGMB
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 02:12:01 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061026061200.HKQJ12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 02:12:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id euBj1V0011kojtg0000000 Thu, 26 Oct 2006
 02:11:43 -0400
To: Christian Couder <chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org

Thanks; will apply.
