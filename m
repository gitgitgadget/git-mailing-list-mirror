From: davidhq <david.krmpotic@gmail.com>
Subject: Segmentation fault on Mac OS Mavericks 10.9.2
Date: Sun, 6 Apr 2014 15:19:03 -0700 (PDT)
Message-ID: <1396822743004-7607349.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 07 00:19:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWvPh-0004iR-J8
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 00:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbaDFWTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2014 18:19:05 -0400
Received: from sam.nabble.com ([216.139.236.26]:45816 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057AbaDFWTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2014 18:19:03 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <david.krmpotic@gmail.com>)
	id 1WWvP5-0005JK-0X
	for git@vger.kernel.org; Sun, 06 Apr 2014 15:19:03 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245798>

I tried to push one of the repos with git 1.9.0 and 1.9.1 and I got 

*Segmentation fault 11*

Crash report for 1.9.1 <http://cl.ly/1h3F453F3A1i>  
Crash report for 1.9.0 <http://cl.ly/1x0N021L240V>  

It works with 1.8.5.5

Sorry I'm not sure if this has already been reported... not 'capable' enough
to check and be sure this is the same problem.





--
View this message in context: http://git.661346.n2.nabble.com/Segmentation-fault-on-Mac-OS-Mavericks-10-9-2-tp7607349.html
Sent from the git mailing list archive at Nabble.com.
