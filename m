From: David Birchfield <dbirchfield@asu.edu>
Subject: jgit merge question
Date: Wed, 14 Jan 2009 00:55:14 -0700
Message-ID: <4EDE3D74-CEA3-473C-ADD1-03B79AAB9EDF@asu.edu>
References: <S1760244AbZANHqN/20090114074613Z+1959@vger.kernel.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 08:56:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN0cD-0005SM-1G
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 08:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbZANHzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 02:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbZANHzR
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 02:55:17 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:59595 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZANHzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 02:55:16 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090114075515.EVAW12838.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>
          for <git@vger.kernel.org>; Wed, 14 Jan 2009 02:55:15 -0500
Received: from [10.0.1.195] ([98.165.228.151])
	by fed1rmimpo01.cox.net with bizsmtp
	id 3KvF1b0013GdtNi03KvFtu; Wed, 14 Jan 2009 02:55:15 -0500
X-Authority-Analysis: v=1.0 c=1 a=LuCH5bpmhgwnlXbmK-cA:9
 a=f1n_Nkp6hFi8GH5qZmcmcHX-X_4A:4 a=50e4U0PicR4A:10
X-CM-Score: 0.00
In-Reply-To: <S1760244AbZANHqN/20090114074613Z+1959@vger.kernel.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105598>

Hi all,

My apologies in advance for the newbie question, and I hope this is  
the correct forum - please let me know if there is a better place.

I have been working with the JGit library and with the pgm files and  
other documentation I have been able to implement most of the basic  
functions that I need for my testing application - including fetch.   
This is great!  However, I have not been able to successfully  
implement the merge function with JGit.  There is some reference to  
this in the mail archive, but I cannot find any of the merge code that  
is referenced in the distribution.  I have tried to pull from  
pgm.MergeBase.java, but that hasn't been successful.

My question:
Is there any sort of tutorial or reference code snippet that  
implements merge?  Or is there a trick to getting the MergeBase code  
to achieve a basic merge?

Thanks in advance!

Best,
David
