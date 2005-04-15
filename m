From: Petr Baudis <pasky@ucw.cz>
Subject: Re: ls-tree enhancements
Date: Fri, 15 Apr 2005 18:13:30 +0200
Message-ID: <20050415161330.GH19078@pasky.ji.cz>
References: <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org> <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org> <7v64ypsqev.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org> <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net> <20050414121624.GZ25711@pasky.ji.cz> <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org> <7vzmw0ok45.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 18:12:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMTOU-000315-CW
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 18:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVDOQNh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 12:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVDOQNg
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 12:13:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11228 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261850AbVDOQNc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 12:13:32 -0400
Received: (qmail 1658 invoked by uid 2001); 15 Apr 2005 16:13:30 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmw0ok45.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 04:21:30AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> +static void _usage(void)
> +{
> +	usage("ls-tree [-r] [-z] <key>");
> +}

(namespace-nazi-hat
 This infriges the system namespaces. FWIW, I prefer to add the
underscore at the end of the identifier if wanting to do stuff like
this. Or just call it my_usage().
)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
