From: Paul Franz <thefranz@comcast.net>
Subject: Attributes for commits
Date: Sat, 09 Jun 2007 09:11:48 -0400
Message-ID: <466AA714.4050500@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 15:17:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx0oW-0008GT-LB
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 15:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755667AbXFINQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 09:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755508AbXFINQ4
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 09:16:56 -0400
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:53877 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbXFINQz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 09:16:55 -0400
Received: from paul-franzs-computer.local (c-69-136-89-103.hsd1.pa.comcast.net[69.136.89.103])
          by comcast.net (rwcrmhc13) with ESMTP
          id <20070609131153m1300dm3o4e>; Sat, 9 Jun 2007 13:11:53 +0000
User-Agent: Thunderbird 2.0.0.0 (Macintosh/20070326)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49571>

    I am a ClearCase administrator and one of the things that I love 
about it is the ability to assign attributes to versions of files. Is 
there anybody thinking of adding the ability to assign attributes to a 
commit? I ask because I was thinking about how I would move from 
ClearCase to git and part of our process is to assign the BugNum 
attribute to every checkin so that we can see what bugs have been fixed. 
We also track the files checked in the bug tracking software to. Thus 
giving us a two way linkage between repository and the bug tracking 
system. This is VERY useful. And I was wondering if there are any 
thought to this for commits.

Now, I will be honest it is possible that this has already been done (I 
have not read all the documentation yet) and I am justing wasting 
bandwidth. In which, please excuse my ignorance and tell me to just RTFM.

Paul Franz

-- 

-------------------------------------------

There are seven sins in the world.
     Wealth without work.
     Pleasure without conscience.
     Knowledge without character.
     Commerce without morality.
     Science without humanity.
     Worship without sacrifice.
     Politics without principle.

   -- Mohandas Gandhi

-------------------------------------------
