From: Junio C Hamano <junkio@cox.net>
Subject: Re: Something looks like CVS modules
Date: Fri, 11 Nov 2005 00:05:40 -0800
Message-ID: <7vfyq3sj6z.fsf@assigned-by-dhcp.cox.net>
References: <200511111313.27273.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 09:07:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaTur-0002bk-8P
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 09:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVKKIFm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 03:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVKKIFm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 03:05:42 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:34738 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932197AbVKKIFl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 03:05:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111080447.NZMI776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 03:04:47 -0500
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <200511111313.27273.lan@ac-sw.com> (Alexander Litvinov's message
	of "Fri, 11 Nov 2005 13:13:26 +0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11573>

Alexander Litvinov <lan@ac-sw.com> writes:

> Does anybody can guide me how to replace CVS modules in the git enviroment ?

Sorry, no such thing as far as I can tell.

And no, there is no plan to add such a thing before 1.0 at the
core level, sorry.  Porcelains are separate story, though.
