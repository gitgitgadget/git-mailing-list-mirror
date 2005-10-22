From: Petr Baudis <pasky@suse.cz>
Subject: Re: How do I clear the directory cache
Date: Sat, 22 Oct 2005 23:09:39 +0200
Message-ID: <20051022210939.GR30889@pasky.or.cz>
References: <2b05065b0510170720n5333f03l1941e84c1288fc5d@mail.gmail.com> <20051020085931.GW30889@pasky.or.cz> <2b05065b0510202023i62ab7c03uea1381d76535dcc7@mail.gmail.com> <20051021105235.GF30889@pasky.or.cz> <2b05065b0510211340y9551767i53fe53c0dc14460a@mail.gmail.com> <20051021214326.GJ30889@pasky.or.cz> <2b05065b0510221220r5c498c28lcb00d8846f156686@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 22 23:10:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETQcc-00034o-9Z
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 23:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVJVVJm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Oct 2005 17:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbVJVVJm
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Oct 2005 17:09:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10658 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751044AbVJVVJm (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Oct 2005 17:09:42 -0400
Received: (qmail 24229 invoked by uid 2001); 22 Oct 2005 23:09:39 +0200
To: eschvoca <eschvoca@gmail.com>
Content-Disposition: inline
In-Reply-To: <2b05065b0510221220r5c498c28lcb00d8846f156686@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10476>

Dear diary, on Sat, Oct 22, 2005 at 09:20:40PM CEST, I got a letter
where eschvoca <eschvoca@gmail.com> told me that...
> I think it would make a lot of sense to print out an error to stderr
> if the file is
> bad (maybe you already do).  From there it should be easy to capture stderr
> and construct .gitignore.

Yes, we already do.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
