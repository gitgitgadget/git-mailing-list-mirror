From: Abdelrazak Younes <younes.a@free.fr>
Subject: Git-windows and git-svn?
Date: Fri, 02 Nov 2007 22:55:23 +0100
Message-ID: <fgg6cd$3ep$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 22:56:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io4Uk-0006f7-AZ
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 22:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbXKBVzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 17:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbXKBVzo
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 17:55:44 -0400
Received: from main.gmane.org ([80.91.229.2]:57118 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752204AbXKBVzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 17:55:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Io4UN-0003kd-Si
	for git@vger.kernel.org; Fri, 02 Nov 2007 21:55:39 +0000
Received: from gre92-5-82-237-199-162.fbx.proxad.net ([82.237.199.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 21:55:39 +0000
Received: from younes.a by gre92-5-82-237-199-162.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2007 21:55:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: gre92-5-82-237-199-162.fbx.proxad.net
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63180>

Hello,

I would like to try git on Windows together with git-svn, I downloaded 
  Git-1.5.3-preview20071027.exe and tried:

yns@xxx /d/devel/lyx/git/trunk
$ git-svn init svn://svn.lyx.org/lyx/lyx-devel/trunk
Useless use of a constant in void context at /bin/git-svn line 848.
Can't locate Digest/MD5.pm in @INC (@INC contains: /lib 
/usr/lib/perl5/5.6.1/msy
s /usr/lib/perl5/5.6.1 /usr/lib/perl5/site_perl/5.6.1/msys 
/usr/lib/perl5/site_p
erl/5.6.1 /usr/lib/perl5/site_perl .) at /bin/git-svn line 2420.
BEGIN failed--compilation aborted at /bin/git-svn line 2420.

Is there something I am doing wrong?

Thanks in advance for any help,
Abdel.
