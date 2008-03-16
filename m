From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: [PATCH] Update Japanese translation
Date: Sun, 16 Mar 2008 14:08:27 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.1.00.0803161405270.19370@perkele.intern.softwolves.pp.se>
References: <200803141303.m2ED3nUj016918@mi1.bluebottle.com>
 <20080315050840.GF8410@spearce.org>
 <7vlk4ko7px.fsf@gitster.siamese.dyndns.org>
 <20080315062734.GG8410@spearce.org> <7v4pb8o2jd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	=?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 14:10:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jasd8-00074W-Rl
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 14:10:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbYCPNJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 09:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbYCPNJT
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 09:09:19 -0400
Received: from smtp.getmail.no ([84.208.20.33]:47800 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbYCPNJS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 09:09:18 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JXT00201R7FI000@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 16 Mar 2008 14:09:15 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JXT00LSAR63EC10@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 16 Mar 2008 14:08:27 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JXT002XCR634C30@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 16 Mar 2008 14:08:27 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 0A41F2FC3B; Sun,
 16 Mar 2008 14:08:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 067DB2FB8C; Sun, 16 Mar 2008 14:08:27 +0100 (CET)
In-reply-to: <7v4pb8o2jd.fsf@gitster.siamese.dyndns.org>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77363>

Junio C Hamano:

> What was unwarranted was that the same commit updated language files by 
> running msgmerge before checking if there is any outstanding translation 
> work.

Indeed, that was probably not such a good idea. I should just have updated 
the POT file and the Swedish translation, and let the other files be updated 
by the other translator, or someone who co-ordinates the translations.

BTW, this is one of the reasons why I would like you to consider using 
Translation Project for these things. They have infrastructure to handle 
these conditions.

-- 
\\// Peter - http://www.softwolves.pp.se/
