X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: t9100-git-svn-basic.sh fails
Date: Wed, 13 Dec 2006 01:53:33 -0800
Message-ID: <7vk60wktpe.fsf@assigned-by-dhcp.cox.net>
References: <20061212232321.GL2476@albany.tokkee.org>
	<Pine.LNX.4.63.0612130102000.2807@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061213084620.GN2476@albany.tokkee.org>
	<20061213094320.GD8179@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 09:53:52 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061213094320.GD8179@localdomain> (Eric Wong's message of "Wed,
	13 Dec 2006 01:43:20 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34196>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuQoA-0000Ur-Ao for gcvg-git@gmane.org; Wed, 13 Dec
 2006 10:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964781AbWLMJxf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 04:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbWLMJxf
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 04:53:35 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:39870 "EHLO
 fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932643AbWLMJxe (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 04:53:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061213095334.SEXI15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Wed, 13
 Dec 2006 04:53:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id y9sv1V0091kojtg0000000; Wed, 13 Dec 2006
 04:52:56 -0500
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> Junio:
> can you please cherry-pick that commit (and also apply
> "git-svn: correctly display fatal() error messages"
> (Message-Id: <11659636263755-git-send-email-normalperson@yhbt.net>)
> into maint?

Done.
