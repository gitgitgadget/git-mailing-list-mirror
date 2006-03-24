From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cloning from sites with 404 overridden
Date: Fri, 24 Mar 2006 09:52:43 -0800
Message-ID: <7vu09nzq50.fsf@assigned-by-dhcp.cox.net>
References: <20060322025921.1722.qmail@science.horizon.com>
	<442152E0.4020604@op5.se>
	<slrne28b3a.cp6.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 18:53:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMqTb-0004sh-BZ
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 18:53:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWCXRwr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 12:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbWCXRwq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 12:52:46 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18166 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751318AbWCXRwp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 12:52:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324175245.KKSY20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Mar 2006 12:52:45 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <slrne28b3a.cp6.mdw@metalzone.distorted.org.uk> (Mark Wooding's
	message of "Fri, 24 Mar 2006 17:29:14 +0000 (UTC)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17930>

Mark Wooding <mdw@distorted.org.uk> writes:

> (Aside: `C-u 38 0' doesn't work because Emacs hears `C-u 380' and waits
> for a key.  `M-: (insert-char ?0 38) RET' does the right thing, but is
> ugly.  Any better suggestions?)

C-u 38 C-u 0
