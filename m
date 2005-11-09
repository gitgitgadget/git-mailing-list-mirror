From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Thu, 10 Nov 2005 00:44:05 +0100
Message-ID: <20051109234405.GK30496@pasky.or.cz>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz> <7vvf0r6x97.fsf@assigned-by-dhcp.cox.net> <20050924125001.GB25069@pasky.or.cz> <7virwqwd3z.fsf@assigned-by-dhcp.cox.net> <20051109223303.GG30496@pasky.or.cz> <7v3bm59zxu.fsf@assigned-by-dhcp.cox.net> <20051109233614.GA4051@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 00:46:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZzbv-0007BN-Gb
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 00:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbVKIXoI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 18:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751616AbVKIXoI
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 18:44:08 -0500
Received: from w241.dkm.cz ([62.24.88.241]:33723 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751614AbVKIXoH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 18:44:07 -0500
Received: (qmail 13093 invoked by uid 2001); 10 Nov 2005 00:44:05 +0100
To: Nick Hengeveld <nickh@reactrix.com>
Content-Disposition: inline
In-Reply-To: <20051109233614.GA4051@reactrix.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11444>

Dear diary, on Thu, Nov 10, 2005 at 12:36:14AM CET, I got a letter
where Nick Hengeveld <nickh@reactrix.com> said that...
> Wouldn't this be a problem on public repositories that are hosted with
> DAV?

Hmm. Yes, that's bad. Couldn't the HTTP pusher actually get the current
server info, update it at the pusher's side and send it back?

And add a warning to some documentation that HTTP push won't trigger the
update hooks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
