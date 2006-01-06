From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] debian/ directory
Date: Fri, 06 Jan 2006 14:37:16 -0800
Message-ID: <7vzmm9rnj7.fsf@assigned-by-dhcp.cox.net>
References: <7v64pbc4fh.fsf@assigned-by-dhcp.cox.net>
	<20051228112018.19646.qmail@c226d15586b0bf.315fe32.mid.smarden.org>
	<87oe31urge.kvalo.fsf@purkki.valo.iki.fi>
	<20060102103138.3414.qmail@e631ec7a6a8b9a.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 23:38:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0Dk-0007b1-Pv
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWAFWh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWAFWh5
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:37:57 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:61061 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964848AbWAFWhT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:37:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223509.IXVJ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:35:09 -0500
To: Gerrit Pape <pape@smarden.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14220>

Gerrit Pape <pape@smarden.org> writes:

> Thanks to Norbert Tretkowski, the git* and cogito packages are now
> available for Debian sarge through http://backports.org/.

Good to hear.  Does that mean nobody would suffer if I drop
debian/ subdirectory along with deb target in the main Makefile
anymore?  If so I would.
