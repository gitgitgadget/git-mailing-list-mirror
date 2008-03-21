From: Joe Fiorini <joe@faithfulgeek.org>
Subject: Switching branches without committing changes
Date: Thu, 20 Mar 2008 23:27:09 -0400
Message-ID: <A17C3E8C-3D0E-41B4-8A43-37EC8C3F55C2@faithfulgeek.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 04:33:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcY08-0002GH-8D
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 04:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbYCUDcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 23:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbYCUDcN
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 23:32:13 -0400
Received: from mail-out1.fuse.net ([216.68.8.175]:36038 "EHLO
	mail-out1.fuse.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752321AbYCUDcM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 23:32:12 -0400
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Mar 2008 23:32:12 EDT
X-CNFS-Analysis: v=1.0 c=1 a=pKGSeumCwS0A:10 a=UNh3mgtbqqMk3S39kGMA:9 a=Ml41IJfJUI6oG3xkF5UnNeeSgOkA:4 a=b8hG5vVbyAkA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: gwout1 smtp.user=jfiorini@zoomtown.com; auth=pass (LOGIN)
Received: from [66.93.11.195] ([66.93.11.195:52708] helo=[192.168.1.33])
	by mail-out1.fuse.net (ecelerity 2.1.1.22 r(17669)) with ESMTPA
	id 2C/61-08390-E0B23E74 for <git@vger.kernel.org>; Thu, 20 Mar 2008 23:27:10 -0400
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77700>

He all,

I'm still a newbie to Git (and this list), so if I don't provide  
enough details please let me know what you need and I will provide :).

I'm trying to switch branches without committing my changes.  Is this  
possible?  For example, I'm working on a site, I'm testing the  
implementation of a new technology (branch B), I'm not quite done  
there (or I forget to commit everything) and I want to implement  
something else new.  I create a new branch off of B, called B.1, and  
then make some changes.  I commit only the changes that apply to B.1  
and then try to go back to B.  However, I get an error saying a file I  
changed in B is not uptodate and it cannot merge.  What am I doing  
wrong and how can I get back to B?

Thanks all!
Joe
