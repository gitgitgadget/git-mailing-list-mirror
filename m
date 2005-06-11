From: Marco Costalba <mcostalba@yahoo.it>
Subject: Re: qgit-0.4
Date: Sat, 11 Jun 2005 01:01:51 -0700 (PDT)
Message-ID: <20050611080151.53794.qmail@web26304.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: berkus@gmail.com
X-From: git-owner@vger.kernel.org Sat Jun 11 09:58:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dh0ss-0001d2-1a
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 09:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVFKICd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Jun 2005 04:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbVFKICc
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jun 2005 04:02:32 -0400
Received: from web26304.mail.ukl.yahoo.com ([217.146.176.15]:47550 "HELO
	web26304.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261645AbVFKIB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2005 04:01:57 -0400
Received: (qmail 53796 invoked by uid 60001); 11 Jun 2005 08:01:51 -0000
Received: from [151.38.74.248] by web26304.mail.ukl.yahoo.com via HTTP; Sat, 11 Jun 2005 01:01:51 PDT
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Marco Costalba wrote:

>Here is qgit-0.4, a git GUI viewer
>
>New in this version:
>
>- file history
>
>- command line arguments passed to git-rev-list, eg: qgit v2.6.12-rc6 ^v2.6.12-rc4
>
>- complete rewrite of start-up thread, should be faster now, expecially with warm start
>
>You can download from 
>http://prdownloads.sourceforge.net/qgit/qgit-0.4.tar.gz?download
>
>To try qgit:
>
>1) Unpack downloaded tar file
>2) ./configure
>3) make
>4) cd bin
>5) copy qgit file anywhere in your path
>
>There are also some screenshots:
>http://sourceforge.net/project/screenshots.php?group_id=139897&ssid=13524
>
>Have fun
>Marco
>

thanks to Stanislav Karchebny we have a new scons update, no more

scons: *** No tool named 'qt': No module named qt


here is the link

http://prdownloads.sourceforge.net/qgit/qgit-0.41.tar.gz?download


tested by at least one with the previous mentioned problem, confirmed to disappear.

Marco







		
__________________________________ 
Discover Yahoo! 
Use Yahoo! to plan a weekend, have fun online and more. Check it out! 
http://discover.yahoo.com/
