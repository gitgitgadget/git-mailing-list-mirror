From: Gary Pickrell <gary@pickrell.com>
Subject: Approach for collaborative branches
Date: Sun, 06 Dec 2009 08:57:10 -0800
Message-ID: <4B1BE266.2000208@pickrell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 06 18:03:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHKVi-0001El-NP
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 18:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933889AbZLFRCv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 12:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933887AbZLFRCu
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 12:02:50 -0500
Received: from qmta09.emeryville.ca.mail.comcast.net ([76.96.30.96]:59414 "EHLO
	QMTA09.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933886AbZLFRCu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 12:02:50 -0500
X-Greylist: delayed 346 seconds by postgrey-1.27 at vger.kernel.org; Sun, 06 Dec 2009 12:02:50 EST
Received: from OMTA05.emeryville.ca.mail.comcast.net ([76.96.30.43])
	by QMTA09.emeryville.ca.mail.comcast.net with comcast
	id DsLh1d0060vp7WLA9sxCWR; Sun, 06 Dec 2009 16:57:12 +0000
Received: from [192.168.1.101] ([24.19.102.232])
	by OMTA05.emeryville.ca.mail.comcast.net with comcast
	id DsxB1d00350qwaY8RsxCL5; Sun, 06 Dec 2009 16:57:12 +0000
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134679>


My apologies if this is the wrong place to ask my question.

I've setup a git remote repository and placed the source for a windows 
program there.   I'm working on getting it to compile on Ubuntu.  The 
compilers are different so the code needs to be tweeked to make sure it 
compiles fine in Ubuntu without breaking anything in Windows.  Great!  
This is a situation that calls for git branches, I thought.  Did the 
following:

1) Clone the repository on Ubuntu
2) Made an Ubuntu branch
3) Made my changes to the code.  Added files...ect
4) Used git push origin Ubuntu to push the changes to the repository

I'm unable to see my Ubuntu changes on my windows machine.  How should I 
proceed?

Thanks in advance.

    -Gary
