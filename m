From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: author/commit counts
Date: Fri, 22 Dec 2006 21:24:49 -0800
Organization: YPO4
Message-ID: <20061222212449.dd5bf939.rdunlap@xenotime.net>
References: <20061222181030.d733deb3.rdunlap@xenotime.net>
	<7vfyb7usqd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 06:23:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxzMH-000454-C1
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 06:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbWLWFXc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 00:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbWLWFXc
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 00:23:32 -0500
Received: from xenotime.net ([66.160.160.81]:48621 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752288AbWLWFXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 00:23:32 -0500
Received: from midway.site ([71.245.99.70]) by xenotime.net for <git@vger.kernel.org>; Fri, 22 Dec 2006 21:23:29 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyb7usqd.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35266>

On Fri, 22 Dec 2006 20:43:54 -0800 Junio C Hamano wrote:

> Randy Dunlap <rdunlap@xenotime.net> writes:
> 
> > Is this useful?  or it needs fixing?
> > or you already have better solutions?
> >
> > example:
> > git log v2.6.19.. | authorcount -m | less
> 
> Perhaps you are talking about this command?
> 
> $ git shortlog -n -s v2.6.19..

Yes, thanks, probably something like that....

git version 1.4.3.GIT

> git shortlog -n -s v2.6.19..
Can't open v2.6.19..: No such file or directory at /usr/local/bin/git-shortlog line 99.

---
~Randy
