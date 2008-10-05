From: "Tjernlund" <tjernlund@tjernlund.se>
Subject: RE: gitweb improvements
Date: Mon, 6 Oct 2008 00:25:03 +0200
Message-ID: <00b201c92739$36585eb0$a3091c10$@se>
References: <00a201c92701$54ec6980$fec53c80$@se> <m34p3rq7og.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'git'" <git@vger.kernel.org>
To: "'Jakub Narebski'" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 00:26:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmc41-0003eV-5s
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 00:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113AbYJEWZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 18:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756069AbYJEWZq
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 18:25:46 -0400
Received: from csmtp3.one.com ([195.47.247.213]:57724 "EHLO csmtp3.b-one.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755986AbYJEWZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 18:25:45 -0400
Received: from jockexp (84-217-5-146.tn.glocalnet.net [84.217.5.146])
	by csmtp3.b-one.net (Postfix) with ESMTP id DCDB6385F7E7;
	Mon,  6 Oct 2008 00:25:42 +0200 (CEST)
In-Reply-To: <m34p3rq7og.fsf@localhost.localdomain>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AcknDuwLA5v0Qv8RShe9EXsw7Cv8PgAKa4zg
Content-Language: sv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97546>



> -----Original Message-----
> From: Jakub Narebski [mailto:jnareb@gmail.com]
> Sent: den 5 oktober 2008 19:22
> To: Tjernlund
> Cc: 'git'
> Subject: Re: gitweb improvements
> 
> "Tjernlund" <tjernlund@tjernlund.se> writes:
> 
> > When I browse a repo using gitweb, I miss two things:
> > 1) looking at the history for a file or directory I really want
> >    to see the tags there too.
> 
> Should be easy to do, but would probably wait (and be indirect result)
> of refactoring/unification of log-like views code ('log', 'shortlog',
> 'history', perhaps also 'rss', 'atom', 'search')
> 
> I have added it to my gitweb TODO list...

Great! Thanks.

> 
> > 2) looking at a merge like:
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
> 2.6.git;a=commit;h=66120005e65eed8a05b14a36ab448bdec42f0d6b
> >    is somewhat confusing. It really doesn't tell you which commits that is
> >    included in the merge.
> 
> I don't understand you there. First, you have "(merge: 0d0f3ef 9778e9a)"
> in the navbar, so you can easily go to commit view for parents. Second,
> among commit headers you have two "parent", where SHA-1 of a commit is
> hidden link, and there are also 'commit' and 'diff' link for those.

hmm, looks like I overlooked "(merge: 0d0f3ef 9778e9a)" part. However, I can't
find the "ALSA: make the CS4270 driver a new-style I2C driver" from within
this page.

> 
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
