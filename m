From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-clean, cg-status improvements
Date: Tue, 14 Feb 2006 16:53:56 +0100
Message-ID: <20060214155356.GB9573@pasky.or.cz>
References: <1139930899.1944.13.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 17:01:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F92UR-0002US-M8
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 16:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161099AbWBNPxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 10:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbWBNPxR
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 10:53:17 -0500
Received: from w241.dkm.cz ([62.24.88.241]:23478 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161097AbWBNPxQ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 10:53:16 -0500
Received: (qmail 32725 invoked by uid 2001); 14 Feb 2006 16:53:56 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1139930899.1944.13.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16137>

  Hello,

Dear diary, on Tue, Feb 14, 2006 at 04:28:19PM CET, I got a letter
where Pavel Roskin <proski@gnu.org> said that...
> Hello, Petr!
> 
> Is cogito 0.17 going to require git 1.2.0?  If so, I'm ready to submit a
> patch for cg-clean that would use the fixed functionality of git
> regarding ignores when run in subdirectories (commit
> 701ca744e386c2429ca44072ea987bbb4bdac7ce).  I think cg-status can be
> improved as well.
> 
> If cogito 0.17 is not going to require git 1.2.0, I'm ready to add a
> temporary workaround for older versions of git.

  I didn't plan to require git 1.2.0 with 0.17, so it would be better if
you could do the workaround. But if the workaround means significant
hassle, it's no biggie if git 1.2.0 will be required.

> The problem with cg-clean right now is that it removes contents of
> untracked directories by default, which makes it pointless to keep the
> directories.  I submitted a patch for that, but it it wasn't noticed.
> Anyway, I can do it better now.

  Hmm, strange, I really did not notice the patch. Well, I'm certainly
interested.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
