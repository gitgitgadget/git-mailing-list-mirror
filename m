From: T Worman <lists@thetimmy.com>
Subject: problem with eGit/jGit install in Eclipse 3.4
Date: Tue, 2 Sep 2008 00:00:14 -0700
Message-ID: <D1AFAEA7-79A6-4CB8-B1D5-07DB1900B116@thetimmy.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 02 09:14:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaQ5S-0003XB-RL
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbYIBHM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 03:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbYIBHM5
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 03:12:57 -0400
Received: from smtpgw.gseis.ucla.edu ([149.142.5.109]:51473 "EHLO
	smtpgw.gseis.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbYIBHM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 03:12:56 -0400
X-Greylist: delayed 761 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Sep 2008 03:12:56 EDT
Received: from gseis.ucla.edu (mail.gseis.ucla.edu [149.142.5.69])
	by smtpgw.gseis.ucla.edu (8.14.2/8.14.2) with ESMTP id m8270EfD014380
	for <git@vger.kernel.org>; Tue, 2 Sep 2008 00:00:14 -0700
X-Scanned-By: MIMEDefang 2.64 on 149.142.5.109
X-Scanned-By: MPP/Sophos http://www.messagepartners.com
X-Scanned-By: This message was scanned by MPP v.3 (www.messagepartners.com)
Received: from [69.232.45.226] (account worman HELO [192.168.0.2])
  by gseis.ucla.edu (CommuniGate Pro SMTP 4.3.7)
  with ESMTPSA id 25210145 for git@vger.kernel.org; Tue, 02 Sep 2008 00:01:48 -0700
X-Mailer: Apple Mail (2.929.2)
X-Virus-Scanned: ClamAV 0.92.1/8137/Mon Sep  1 19:07:16 2008 on smtpgw.gseis.ucla.edu
X-Virus-Status: Clean
X-Probable-Spam: no
X-Spam-Score: -4.399 ()
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94654>

All:

Newbie to this list. I've been using eGit in Eclipse for a while now  
and I've been updating it manually. Most recently I've installed a new  
version of Eclipse (3.4 Ganymede) and I've imported the org.spearce.*  
projects into the new version and exported the projects to the Eclipse  
plugins directory. All looks normal to here and the products are where  
they should be. I quit and restart Eclipse.

When I access Team > Share Project on any of my projects the only  
option available is CVS. For some reason Git does not show up as an  
option. Since I have never had any problems installing egit before I  
have tried everything I know of to troubleshoot. Does anyone here have  
any ideas why Git is not showing up as an option for sharing in  
Ganymede?

Tim
