From: Eric Raible <raible@gmail.com>
Subject: Re: Help before pushing to remote repo.
Date: Fri, 6 Jun 2008 23:28:33 +0000 (UTC)
Message-ID: <loom.20080606T232618-691@post.gmane.org>
References: <351720.25873.qm@web30503.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 01:29:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4lNP-0002Vy-Rr
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757616AbYFFX2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756482AbYFFX2u
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:28:50 -0400
Received: from main.gmane.org ([80.91.229.2]:47756 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756308AbYFFX2u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 19:28:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1K4lMS-0005tA-50
	for git@vger.kernel.org; Fri, 06 Jun 2008 23:28:44 +0000
Received: from 12.96.234.114 ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 23:28:44 +0000
Received: from raible by 12.96.234.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 23:28:44 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080404 Firefox/2.0.0.14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84142>

Ralph Churchill <mrchucho <at> yahoo.com> writes:

> 
> I have a file that contains a "secret" key value. I unwittingly committed two
commits to my local repository
> that contained the value. Is there anything I can do to prevent the value from
making it to the version(s)
> visible in the remote repository? I don't know if I can "edit" the commits or
change the history of the file.
> 
> I'm using github for the remote repo. and am, obviously, very new to Git.

Assuming that you haven't yet pushed it to the remote repository...

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#fixing-a-mistake-by-rewriting-history
http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#undoing-a-merge
