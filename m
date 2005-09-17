From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Newbie falls at first hurdle
Date: Sat, 17 Sep 2005 13:09:46 +0100
Message-ID: <200509171309.46893.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 17 14:11:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGbVv-0006Qt-Ij
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 14:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVIQMJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Sep 2005 08:09:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbVIQMJo
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Sep 2005 08:09:44 -0400
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:59546
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S1751085AbVIQMJn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2005 08:09:43 -0400
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1EGbVm-0008Sm-M5
	for git@vger.kernel.org; Sat, 17 Sep 2005 13:09:42 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8763>

I have been lurking on this mailing list since the beginning, but have just 
got to the point where I want to use git to manage something I am doing.

I have already got a working directory (or rather a directory hierarchy) of an 
application with files (combination of html and java), and I need to start 
applying some control to it.  The Tutorial unfortunately does not cover this 
case.  Nevertheless I have proceeded.

So at the top-level I have done 'git-init-db'

but I now assume I have to add all the files to the cache

So 'git-update-cache --add *' would seem to be the next step.

However this fails with a message 

error: JavaSource: is a directory
fatal: Unable to add JavaSource to database; maybe you want to use --add 
option?

Since I am already using the --add option, I really don't understand what I am 
doing wrong.

Help please.

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
