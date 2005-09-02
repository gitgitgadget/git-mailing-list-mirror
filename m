From: Junio C Hamano <junkio@cox.net>
Subject: Re: please pull ppc64-2.6.git
Date: Thu, 01 Sep 2005 17:20:02 -0700
Message-ID: <7vpsrstj65.fsf@assigned-by-dhcp.cox.net>
References: <17170.25803.413408.44080@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508291006440.3243@g5.osdl.org>
	<20050829184510.A20605@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 02 02:21:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAzHw-0002EX-6u
	for gcvg-git@gmane.org; Fri, 02 Sep 2005 02:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030596AbVIBAUH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Sep 2005 20:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030599AbVIBAUG
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Sep 2005 20:20:06 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:34783 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030596AbVIBAUF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2005 20:20:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050902002005.WBIQ18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Sep 2005 20:20:05 -0400
To: Russell King <rmk@arm.linux.org.uk>
cc: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050829184510.A20605@flint.arm.linux.org.uk> (Russell King's
	message of "Mon, 29 Aug 2005 18:45:10 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8003>

Russell King <rmk@arm.linux.org.uk> writes:

> Is the expected filesystem layout documented somewhere online (_external_
> to the source code) ?

There already was a sketchy description in git(7), at
<http://www.kernel.org/pub/software/scm/git/docs/>

I've updated it a bit to describe the current status; please
look for "File/Directory Structure" section of the above URL.
