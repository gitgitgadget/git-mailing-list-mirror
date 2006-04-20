From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Thu, 20 Apr 2006 22:19:15 +0200
Message-ID: <20060420201915.GF27689@pasky.or.cz>
References: <20060419053640.GA16334@tumblerings.org> <20060419094916.GD27689@pasky.or.cz> <20060419142131.GD4104@tumblerings.org> <20060419144827.GX27631@pasky.or.cz> <20060420164908.GA540@tumblerings.org> <7vejzsywrq.fsf@assigned-by-dhcp.cox.net> <20060420200849.GA3653@tumblerings.org> <7vslo8xaql.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zack Brown <zbrown@tumblerings.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 22:19:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWfcU-0000fG-Gd
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 22:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWDTUTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 16:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWDTUTN
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 16:19:13 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58064 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751255AbWDTUTM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Apr 2006 16:19:12 -0400
Received: (qmail 4565 invoked by uid 2001); 20 Apr 2006 22:19:15 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vslo8xaql.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18993>

Dear diary, on Thu, Apr 20, 2006 at 10:17:38PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Zack Brown <zbrown@tumblerings.org> writes:
> 
> > Not true. I went into the git source directory, and ran "make". Nothing more.
> 
> Ah, I misunderstood.  You are trying to run it _without_
> installing it.
> 
> Well, then probably you do not have templates installed
> anywhere, especially not where git-init-db expects them to be
> found.

Duh, but shouldn't git-init-db create .git/info at any rate, even when
no templates are installed?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
