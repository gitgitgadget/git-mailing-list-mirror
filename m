From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Sun, 30 Oct 2005 22:48:57 -0800
Message-ID: <7vsluiji5i.fsf@assigned-by-dhcp.cox.net>
References: <43652934.8000308@zytor.com>
	<7vy84ajl4c.fsf@assigned-by-dhcp.cox.net>
	<20051031064105.GV8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 31 08:01:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWTTc-0002R4-HW
	for gcvg-git@gmane.org; Mon, 31 Oct 2005 07:49:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVJaGtA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 01:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932534AbVJaGtA
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 01:49:00 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:18357 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932533AbVJaGs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 01:48:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051031064833.RNQX4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Oct 2005 01:48:33 -0500
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20051031064105.GV8041@shell0.pdx.osdl.net> (Chris Wright's
	message of "Sun, 30 Oct 2005 22:41:05 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10852>

Chris Wright <chrisw@osdl.org> writes:

> It's fine for FC3.  Certain irony that git now effectively requires
> subversion.

Haha.

> BTW, mind pushing the tag?

Done; thanks for noticing.
