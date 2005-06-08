From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Problem with Cogito repository?
Date: Wed, 8 Jun 2005 20:49:27 +0200
Message-ID: <20050608184927.GF982@pasky.ji.cz>
References: <42A3E858.7070809@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:49:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dg5Zm-0000Ua-Up
	for gcvg-git@gmane.org; Wed, 08 Jun 2005 20:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbVFHSuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 14:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVFHSuF
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 14:50:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40671 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261515AbVFHSt3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 14:49:29 -0400
Received: (qmail 6063 invoked by uid 2001); 8 Jun 2005 18:49:27 -0000
To: Philip Pokorny <ppokorny@mindspring.com>
Content-Disposition: inline
In-Reply-To: <42A3E858.7070809@mindspring.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Jun 06, 2005 at 08:08:24AM CEST, I got a letter
where Philip Pokorny <ppokorny@mindspring.com> told me that...
> I've just updated my tree with cg-pull from 
> rsync://rsync.kernel.org/pub/scm/cogito/cogito.git
> 
> There seems to be a problem with the repository object for tag 
> "pull_from_pasky"

Indeed, unbelievable. I've deleted it several times but somehow it
always pops up again. Yes, its contents is nonsensical as it points to
the history at some point before the hashing changes. Please just delete
it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
