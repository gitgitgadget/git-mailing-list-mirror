From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Git / Subversion Interoperability
Date: Thu, 22 Mar 2007 19:48:29 -0300
Message-ID: <20070322224829.GA7048@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 23 00:15:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUWUl-0008Mm-F5
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 00:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbXCVXOm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 19:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbXCVXOm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 19:14:42 -0400
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:47463 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbXCVXOm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2007 19:14:42 -0400
X-Greylist: delayed 1570 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Mar 2007 19:14:41 EDT
Received: from montecristo (montecristo.c3sl.ufpr.br [200.17.202.51])
	by urquell.c3sl.ufpr.br (Postfix) with SMTP id 097293019A3D
	for <git@vger.kernel.org>; Thu, 22 Mar 2007 19:48:30 -0300 (BRT)
Received: by montecristo (sSMTP sendmail emulation); Thu, 22 Mar 2007 19:48:30 -0300
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42887>

Hello,

I'm going to apply for the Git / Subversion Interoperability project.

I saw that there is no mentor yet assigned for the "job". So i'm sending this
mail to get some help to start the project by submiting to GSOC and begin to
work :)

My idea on this project is to create:
1.  git-svnserver
2.  write a backend for Subversion

And make it easy to work with SSH using those "common" flags in
authorized_keys like:
command="svnserve -t -r /home/svn --tunnel-user=bruno" ssh-dss bla bla

And as an idea i would like to make the same funcionality to git, as it is
not as easy today to do something like above :)

Well, that's it for now! And i'm waiting for replys

Regards,
Bruno

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
