From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-daemon enabled on kernel.org
Date: Tue, 8 Nov 2005 00:11:57 +0100
Message-ID: <20051107231157.GX1431@pasky.or.cz>
References: <43554D4F.7040403@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 08 00:12:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZG9k-0004bJ-Kg
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 00:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965283AbVKGXMA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 18:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVKGXMA
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 18:12:00 -0500
Received: from w241.dkm.cz ([62.24.88.241]:16291 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S965283AbVKGXL7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 18:11:59 -0500
Received: (qmail 5347 invoked by uid 2001); 8 Nov 2005 00:11:57 +0100
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43554D4F.7040403@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11289>

Dear diary, on Tue, Oct 18, 2005 at 09:30:23PM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> I consider this experimental so far, and if it imposes an unacceptable 
> load I'll have to disable it.  It currently runs with an inetd-imposed 
> limits of 10 instances per server.

I'm curious - how well does it do wrt. the load so far? Do you have any
statistics about the number of users and how CPU-intensive is it?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
