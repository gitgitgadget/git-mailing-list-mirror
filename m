From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Mon, 14 Nov 2005 10:32:26 +0100
Message-ID: <20051114093226.GS30496@pasky.or.cz>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43730E39.6030601@pobox.com> <7v64qzni9c.fsf@assigned-by-dhcp.cox.net> <4375DD4A.5050103@op5.se> <7vwtjb3c4i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 10:32:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbahU-0002v3-Ih
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 10:32:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVKNJca (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 04:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVKNJc3
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 04:32:29 -0500
Received: from w241.dkm.cz ([62.24.88.241]:33463 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751045AbVKNJc3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 04:32:29 -0500
Received: (qmail 27137 invoked by uid 2001); 14 Nov 2005 10:32:26 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwtjb3c4i.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11781>

Dear diary, on Mon, Nov 14, 2005 at 08:46:37AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> BTW, does anybody actually use these commit walkers over SSH?
> Cogito switched out of it before 0.16r1 if I understand
> correctly, and git barebone never used it.  It might not be a
> bad idea to deprecate these altogether, now packed transfer
> seems to be much nicer.

Yes, Cogito switched out of it before 0.16rc1, but there is still plenty
of users of older Cogito versions. Well, when 0.16 is out, those should
upgrade anyway, so this could be a nice gentle kick... ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
