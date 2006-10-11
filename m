From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: blame porcelain: lineno and orig lineno swapped
Date: Wed, 11 Oct 2006 01:37:47 -0700
Message-ID: <7virirtfhg.fsf@assigned-by-dhcp.cox.net>
References: <20061011073005.1178.qmail@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 10:38:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXZbB-0007C9-Er
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 10:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWJKIht (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 04:37:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbWJKIht
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 04:37:49 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:53461 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965176AbWJKIhs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 04:37:48 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061011083748.FMCM12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Oct 2006 04:37:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Ywdq1V00j1kojtg0000000
	Wed, 11 Oct 2006 04:37:51 -0400
To: ltuikov@yahoo.com
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28706>

Sheesh.  I thought I swapped both blame side and gitweb side to
match your suggestion but apparently I didn't.

Thanks for catching this.
 
