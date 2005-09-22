From: Petr Baudis <pasky@suse.cz>
Subject: Re: [Core GIT] Long-term cherrypicking
Date: Thu, 22 Sep 2005 11:58:45 +0200
Message-ID: <20050922095845.GE21019@pasky.or.cz>
References: <20050921164015.GC21971@pasky.or.cz> <20050922083142.GA6866@kroah.com> <tnxpsr12zu0.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg KH <greg@kroah.com>, git@vger.kernel.org, kkeil@suse.de
X-From: git-owner@vger.kernel.org Thu Sep 22 12:00:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EINqs-0006V1-DZ
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 11:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbVIVJ6s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 05:58:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbVIVJ6s
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 05:58:48 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31197 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751447AbVIVJ6r (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 05:58:47 -0400
Received: (qmail 28062 invoked by uid 2001); 22 Sep 2005 11:58:45 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnxpsr12zu0.fsf@arm.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9103>

Dear diary, on Thu, Sep 22, 2005 at 11:53:27AM CEST, I got a letter
where Catalin Marinas <catalin.marinas@gmail.com> told me that...
> But what I understand from Petr's e-mail is that re-basing the patches
> is not acceptable for a repository which is public. One option would
> be to keep a private tree where the patches are re-based and a public
> one which periodically pulls from Linus' tree and your private
> one. Not sure how complicated the commit graph would look.

It would be pretty ugly since the same patches would re-appear in the
commit graph in another incarnations many times.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
