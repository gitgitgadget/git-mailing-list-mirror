From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use git-update-ref and git-symbolic-ref in tests
Date: Tue, 11 Oct 2005 12:57:28 -0700
Message-ID: <7v1x2ru8rb.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510111601460.27536@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Oct 11 21:59:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPQFg-0001hC-MQ
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 21:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbVJKT5a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 15:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVJKT5a
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 15:57:30 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:28291 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751080AbVJKT53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 15:57:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051011195713.WINX29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Oct 2005 15:57:13 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510111601460.27536@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 11 Oct 2005 16:02:39 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9982>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This makes all tests pass on cygwin.

Thanks.  Forgot about these tests.
