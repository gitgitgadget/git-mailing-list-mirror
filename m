From: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
Subject: Re: [PATCH] cvsps/cvsimport: fix branch point calculation and	broken branch imports
Date: Mon, 7 Apr 2008 14:07:37 -0400
Message-ID: <72D530CB-3228-42BC-A4F7-253E37F6EAAB@yahoo.ca>
References: <1207100091.10532.64.camel@gandalf.cobite.com> <0C7AA499-56AD-4D20-AED0-9E7DDD0C77DF@zib.de> <1207230582.17329.39.camel@gandalf.cobite.com> <47F5FA79.8010604@alum.mit.edu> <1207590845.17329.98.camel@gandalf.cobite.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Steffen Prohaska <prohaska@zib.de>, Git <git@vger.kernel.org>
To: David Mansfield <david@cobite.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 20:15:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JivsL-0006Nv-00
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 20:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602AbYDGSOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 14:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbYDGSO3
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 14:14:29 -0400
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:31346 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753175AbYDGSO0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2008 14:14:26 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Apr 2008 14:14:26 EDT
Received: (qmail 74137 invoked from network); 7 Apr 2008 18:07:46 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:In-Reply-To:References:Mime-Version:Content-Type:Message-Id:Cc:Content-Transfer-Encoding:From:Subject:Date:To:X-Mailer;
  b=aN9AKKouNptF05xa6aTjvJAvPXYI376ITpkcJFABN3gQVPbuoK+KwjQfrLXrKIrlZRXmBRWQ5V6E0f1+BKGTufjS6r5p4jKCh7/uISQbQAWPGDMG3/nLnUaZVANSJRnqKfERN7Ri5WE7abagO/btx70gKmM9pRvael7zqRK4iWQ=  ;
Received: from unknown (HELO ?192.168.3.34?) (jean_francois_veillette@207.96.147.134 with plain)
  by smtp106.mail.mud.yahoo.com with SMTP; 7 Apr 2008 18:07:46 -0000
X-YMail-OSG: jpUqlRcVM1nKobvd0kpv5m0QFuZX8eV75WXxinhvmLwtjyWg6BKQWjbhXhylMP5IZxY09MZQSQ--
X-Yahoo-Newman-Property: ymail-3
In-Reply-To: <1207590845.17329.98.camel@gandalf.cobite.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78983>


> However, if possible, I'd like to fix problems with the cvsps/git- 
> cvsimport if possible, unless someone can tell me for sure that  
> it's obsolete and noone uses it.

I do use it, please fix the duo cvsps/git-cvsimport (if possible).
The fact that it's integrated with git make it very useful and handy.
It is working well for almost all of my cvs repo that I track with git.
If it would work for all of them it would be wonderful !

- jfv
