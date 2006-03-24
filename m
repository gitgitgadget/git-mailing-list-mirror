From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito asciidoc failure
Date: Fri, 24 Mar 2006 20:02:37 +0100
Message-ID: <20060324190237.GZ18185@pasky.or.cz>
References: <86u09n4y1k.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 20:02:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMrYc-0000fY-VF
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 20:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbWCXTCm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 14:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWCXTCm
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 14:02:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:54219 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932599AbWCXTCl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 14:02:41 -0500
Received: (qmail 2451 invoked by uid 2001); 24 Mar 2006 20:02:37 +0100
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
Content-Disposition: inline
In-Reply-To: <86u09n4y1k.fsf@blue.stonehenge.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17937>

Dear diary, on Fri, Mar 24, 2006 at 05:17:43PM CET, I got a letter
where "Randal L. Schwartz" <merlyn@stonehenge.com> said that...
> 
> asciidoc -b xhtml11 -d manpage -f asciidoc.conf cg-admin-rewritehist.1.txt
> ERROR: cg-admin-rewritehist.1.txt: line 54: title not allowed in list item continuation
> make[1]: *** [cg-admin-rewritehist.1.html] Error 1
> make: *** [doc] Error 2

Oh. Thanks, fixed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
