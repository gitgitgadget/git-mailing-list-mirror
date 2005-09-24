From: Petr Baudis <pasky@suse.cz>
Subject: Re: How to make Cogito use git-fetch-pack?
Date: Sat, 24 Sep 2005 03:19:12 +0200
Message-ID: <20050924011912.GK10255@pasky.or.cz>
References: <43347F98.6020101@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 03:19:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIyhD-0007BI-HZ
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 03:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbVIXBTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 21:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVIXBTQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 21:19:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52389 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751360AbVIXBTQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2005 21:19:16 -0400
Received: (qmail 23610 invoked by uid 2001); 24 Sep 2005 03:19:14 +0200
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <43347F98.6020101@zytor.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9219>

Dear diary, on Sat, Sep 24, 2005 at 12:20:08AM CEST, I got a letter
where "H. Peter Anvin" <hpa@zytor.com> told me that...
> Is there any way to make Cogito use git-fetch-pack instead of 
> git-ssh-fetch?  git+ssh:// seems to invoke the latter.

I just added git+packed+ssh:// to be used for this purpose.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
