From: Ralph Churchill <mrchucho@yahoo.com>
Subject: Help before pushing to remote repo.
Date: Fri, 6 Jun 2008 16:13:04 -0700 (PDT)
Message-ID: <351720.25873.qm@web30503.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 01:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4lEc-0000ZH-EA
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 01:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980AbYFFXTp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 19:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756930AbYFFXTp
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 19:19:45 -0400
Received: from web30503.mail.mud.yahoo.com ([68.142.200.116]:41702 "HELO
	web30503.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756384AbYFFXTo (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 19:19:44 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Jun 2008 19:19:44 EDT
Received: (qmail 26397 invoked by uid 60001); 6 Jun 2008 23:13:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=Q9PjOSeaLwVmTx6lUgmRcMMeH8F3XZ1OlIFnk3bw23tSV2YSITaaQ+kAQa7IeNlJN47sPsgeYpa0Wly5pA7Ej5mxpBaSdvl1t+4nbkxeITKxaAYEyopqtacUUQ1KXeGzNSV0GX2LQld7naaXQij3QIv2q0NNh2YpuNcLP56qb88=;
Received: from [98.160.104.117] by web30503.mail.mud.yahoo.com via HTTP; Fri, 06 Jun 2008 16:13:04 PDT
X-Mailer: YahooMailRC/975.41 YahooMailWebService/0.7.199
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84139>

I have a file that contains a "secret" key value. I unwittingly committed two commits to my local repository that contained the value. Is there anything I can do to prevent the value from making it to the version(s) visible in the remote repository? I don't know if I can "edit" the commits or change the history of the file.

I'm using github for the remote repo. and am, obviously, very new to Git.


      
