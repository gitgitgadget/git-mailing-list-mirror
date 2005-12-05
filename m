From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Clean up compatibility definitions.
Date: Tue, 6 Dec 2005 00:12:03 +0100
Message-ID: <20051205231203.GG22159@pasky.or.cz>
References: <81b0412b0512050519k5ed80035x9eb4907f569e0a4b@mail.gmail.com> <81b0412b0512050524w7b632651n93c836fda41a39d@mail.gmail.com> <7vfyp7cuii.fsf@assigned-by-dhcp.cox.net> <7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 00:13:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjPV9-0000aT-Qs
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 00:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVLEXLt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 18:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbVLEXLt
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 18:11:49 -0500
Received: from w241.dkm.cz ([62.24.88.241]:24811 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S964850AbVLEXLs (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 18:11:48 -0500
Received: (qmail 10549 invoked by uid 2001); 6 Dec 2005 00:12:03 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voe3vb8fh.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13243>

Dear diary, on Mon, Dec 05, 2005 at 09:22:42PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> diff --git a/git-compat-util.h b/git-compat-util.h
> new file mode 100644

What about compat/util.h or something? Nicer, shorter, and takes
advantage of this fancy hierarchical namespace "directories" invention.
;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
