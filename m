From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-init bug
Date: Sun, 5 Jun 2005 20:10:42 +0200
Message-ID: <20050605181042.GH17462@pasky.ji.cz>
References: <20050605153053.GA6890@tumblerings.org> <20050605172854.GF17462@pasky.ji.cz> <20050605175634.GB6890@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 20:08:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DezWu-0006aZ-1Z
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 20:07:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVFESKt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 14:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVFESKt
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 14:10:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64926 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261597AbVFESKo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 14:10:44 -0400
Received: (qmail 16591 invoked by uid 2001); 5 Jun 2005 18:10:42 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050605175634.GB6890@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jun 05, 2005 at 07:56:34PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> Depending on how I check, I get very different lists. I'll include both in this email.
> 
> If I do the 'cg-init' on the full source.cogito directory, then do a 'cg-clone'
> into a new source.cogtst directory, here is the result of a comparison:

Hmm. That's very strange, I can't see what could be the problem. If you
try cg-init multiple times, do you always get the same list of files
missed out? Can you spot any error messages while doing cg-init?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
