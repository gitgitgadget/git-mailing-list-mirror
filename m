X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: HOWTO set up a repository which can be pushed into over HTTP
Date: Mon, 07 Aug 2006 00:55:43 -0700
Message-ID: <7vd5bd6ku8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608042021300.1800@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vac6kjoxh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0608050044000.1800@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 7 Aug 2006 07:56:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0608050044000.1800@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 5 Aug 2006 00:45:55 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1G9zxk-0000iO-TI for gcvg-git@gmane.org; Mon, 07 Aug
 2006 09:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751135AbWHGHzq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 7 Aug 2006
 03:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWHGHzq
 (ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 03:55:46 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63666 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1751135AbWHGHzp
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 03:55:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203]) by
 fed1rmmtao07.cox.net (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with
 ESMTP id
 <20060807075545.BHJP23903.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
 Mon, 7 Aug 2006 03:55:45 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Do people find it useful? Or would you like to wait until I implement an 
> option in git-http-push to actually init an HTTP repo remotely?

I do not have need for push over http-dav at the moment myself,
but I would imagine I would certainly look for it when I would
need to later.

Do people find it useful?  More importantly, has somebody else
independently tried to follow the documentation and found the
description accurate and helpful?
