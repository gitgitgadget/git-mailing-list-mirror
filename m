From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.9j aka 1.0rc3
Date: Fri, 18 Nov 2005 00:29:35 -0800
Message-ID: <7v4q6amk9c.fsf@assigned-by-dhcp.cox.net>
References: <7vfypvzsos.fsf@assigned-by-dhcp.cox.net>
	<20051118083215.GA9551@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 09:31:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed1d6-0001rg-KH
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 09:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbVKRI3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 03:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030507AbVKRI3h
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 03:29:37 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:39582 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1030502AbVKRI3g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 03:29:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051118082830.PCSF17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 18 Nov 2005 03:28:30 -0500
To: "Fernando J. Pereda" <ferdy@ferdyx.org>
In-Reply-To: <20051118083215.GA9551@ferdyx.org> (Fernando J. Pereda's message
	of "Fri, 18 Nov 2005 09:32:15 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12215>

"Fernando J. Pereda" <ferdy@ferdyx.org> writes:

> We use the full tarball to build git in Gentoo Linux, are you planning
> to provide it ? Or from now on you won't provide the full tarball ?

No, it was a fallout from RPM renaming.  I'll fix up the release
script.

Thanks for letting me know.
 
