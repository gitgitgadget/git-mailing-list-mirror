From: Petr Baudis <pasky@suse.cz>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Date: Thu, 22 Jun 2006 23:28:26 +0200
Message-ID: <20060622212826.GG21864@pasky.or.cz>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org> <20060622205859.GF21864@pasky.or.cz> <Pine.LNX.4.64.0606221402140.6483@g5.osdl.org> <e7f1pk$l1q$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 23:28:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtWj9-0006WL-14
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 23:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbWFVV2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 17:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbWFVV23
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 17:28:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63669 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932655AbWFVV22 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 17:28:28 -0400
Received: (qmail 14064 invoked by uid 2001); 22 Jun 2006 23:28:26 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e7f1pk$l1q$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22376>

> >> Isn't manually numbering the enum choices somewhat pointless, though?
> >> (Actually makes it more difficult to do changes in it later.)
> > 
> > Yeah, I just mindlessly followed Johannes' original scheme. 
> 
> You might want to start at 0, just in case...

C99 (6.7.2.2) guarantees the enumeration constants start at 0 if not
specified otherwise.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
