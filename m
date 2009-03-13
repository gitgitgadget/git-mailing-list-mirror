From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Not pushing all branches?
Date: Fri, 13 Mar 2009 10:44:49 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0903131043510.17450@perkele.intern.softwolves.pp.se>
References: <alpine.DEB.2.00.0903130846410.17450@perkele.intern.softwolves.pp.se>
 <7bfdc29a0903130112w17d40473s14a895d518dbf8ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 10:47:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li3zf-0004Oh-7S
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 10:47:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756780AbZCMJpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 05:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753866AbZCMJpq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 05:45:46 -0400
Received: from smtp.getmail.no ([84.208.20.33]:57637 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755458AbZCMJpp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 05:45:45 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0KGF0016VV46FG00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 13 Mar 2009 10:45:42 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KGF00G2AV2XOO20@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 13 Mar 2009 10:44:57 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0KGF00M59V2X0M30@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 13 Mar 2009 10:44:57 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 583A02FC0B; Fri,
 13 Mar 2009 10:44:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 54BC92FBF7; Fri, 13 Mar 2009 10:44:49 +0100 (CET)
In-reply-to: <7bfdc29a0903130112w17d40473s14a895d518dbf8ae@mail.gmail.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113160>

Imran M Yousuf:

> Just try -
> git push remote branch :)

That is what I do. Unfortunately, the times I forged to name the branch, it 
pushes my master branch, which is different from the remote's, and I have to 
go to the other repository and reset it manually...

-- 
\\// Peter - http://www.softwolves.pp.se/
