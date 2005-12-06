From: Petr Baudis <pasky@suse.cz>
Subject: Re: ssh removed?
Date: Wed, 7 Dec 2005 00:29:45 +0100
Message-ID: <20051206232945.GJ22159@pasky.or.cz>
References: <20051206211918.GP21705@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 07 00:31:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjmFZ-0000w4-MQ
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 00:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbVLFX3b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 18:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030294AbVLFX3b
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 18:29:31 -0500
Received: from w241.dkm.cz ([62.24.88.241]:50378 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030293AbVLFX3a (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 18:29:30 -0500
Received: (qmail 25950 invoked by uid 2001); 7 Dec 2005 00:29:45 +0100
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Content-Disposition: inline
In-Reply-To: <20051206211918.GP21705@schottelius.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13304>

Dear diary, on Tue, Dec 06, 2005 at 10:19:18PM CET, I got a letter
where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> said that...
> Did somebody remove git+ssh in git? If I search for ssh in cg-log
> in the git source I do not see any hint. But I see that when trying to
> use it:
..snip..
> [22:16] hydrogenium:ccollect.sh% cg-version
> cogito-0.17pre.GIT (c10cc1d2a99b01ed3bf45d5f2ad6157940a22365)
> [22:17] hydrogenium:ccollect.sh% git --version
> git version 0.99.8.GIT

Quite on the contrary, your GIT is too old - at least 0.99.9 is required
as noted in the INSTALL file.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
