From: Petr Baudis <pasky@suse.cz>
Subject: Re: git cole give unexpected error message
Date: Tue, 13 Dec 2005 23:28:29 +0100
Message-ID: <20051213222829.GE22159@pasky.or.cz>
References: <20051213212820.GB5232@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 23:30:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmIdR-0005vn-M9
	for gcvg-git@gmane.org; Tue, 13 Dec 2005 23:28:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVLMW2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 17:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030284AbVLMW2d
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 17:28:33 -0500
Received: from w241.dkm.cz ([62.24.88.241]:952 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030278AbVLMW2b (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2005 17:28:31 -0500
Received: (qmail 2419 invoked by uid 2001); 13 Dec 2005 23:28:29 +0100
To: Sam Ravnborg <sam@ravnborg.org>
Content-Disposition: inline
In-Reply-To: <20051213212820.GB5232@mars.ravnborg.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13593>

Dear diary, on Tue, Dec 13, 2005 at 10:28:20PM CET, I got a letter
where Sam Ravnborg <sam@ravnborg.org> said that...
> cogito being a nice porcelain gives the git errormessage but manage to
> clean up when the clone fails.
> So also cogito would benefit from a more descriptive errormessage.

Well, git clone can fail for many reasons and I don't think the "no such
repository" one is completely overwhelming, so hinting that by Cogito
could be quite confusing (theme of the day: usability ;-)).

The real solution would be proper error reporting by the git daemon.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
