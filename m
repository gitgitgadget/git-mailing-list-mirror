From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 08 Jan 2008 22:26:53 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.1.00.0801082226110.21686@perkele.intern.softwolves.pp.se>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
 <200801071947.28586.robin.rosenberg.lists@dewire.com>
 <alpine.LSU.1.00.0801071915470.10101@racer.site>
 <200801072203.23938.robin.rosenberg.lists@dewire.com>
 <alpine.LFD.1.00.0801071332530.3148@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Steffen Prohaska <prohaska@zib.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 23:27:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCMvC-0003LU-KO
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 23:27:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYAHW1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 17:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752420AbYAHW1S
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 17:27:18 -0500
Received: from smtp.getmail.no ([84.208.20.33]:50101 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbYAHW1R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 17:27:17 -0500
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2008 17:27:16 EST
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JUC00111GXEFH00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 08 Jan 2008 22:27:14 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JUC005O1GWTZ100@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 08 Jan 2008 22:26:53 +0100 (CET)
Received: from perkele ([84.215.146.18]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JUC00A9XGWTZ9D0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 08 Jan 2008 22:26:53 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 2BF312FC25; Tue,
 08 Jan 2008 22:26:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 272822FC24; Tue, 08 Jan 2008 22:26:53 +0100 (CET)
In-reply-to: <alpine.LFD.1.00.0801071332530.3148@woody.linux-foundation.org>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69932>

Linus Torvalds:

> So defaulting to (or asking) "autocrlf" at install time is probably the 
> safest thing, and then people can edit their global .gitconfig to turn it 
> off.

Indeed. A checkbox in the Windows installer (like Cygwin has) would be nice.

-- 
\\// Peter - http://www.softwolves.pp.se/
