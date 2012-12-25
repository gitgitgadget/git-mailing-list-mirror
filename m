From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: Using Eclipse git plugin
Date: Tue, 25 Dec 2012 22:01:59 +0100 (CET)
Message-ID: <803393135.2013806.1356469319924.JavaMail.root@dewire.com>
References: <50D72E73.8070501@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Dennis Putnam <dap1@bellsouth.net>
X-From: git-owner@vger.kernel.org Tue Dec 25 22:02:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnbdn-0008CI-GY
	for gcvg-git-2@plane.gmane.org; Tue, 25 Dec 2012 22:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab2LYVCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Dec 2012 16:02:04 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:54997 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148Ab2LYVCD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Dec 2012 16:02:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id C2DA382652;
	Tue, 25 Dec 2012 22:02:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iBg16E7q0YsP; Tue, 25 Dec 2012 22:02:00 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 071DB82319;
	Tue, 25 Dec 2012 22:02:00 +0100 (CET)
In-Reply-To: <50D72E73.8070501@bellsouth.net>
X-Originating-IP: [213.67.12.15]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Mac)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212124>



----- Ursprungligt meddelande -----
> This may be more of an Eclipse question than a git question but
> hopefully someone on this list knows both. I now have a working git
> central repository (on Linux) and a local repository clone (on
> Windows).
> I can see and edit my files in Eclipse, commit them and push them to
> the
> remote repository. The problem I am having now is developing my code
> in
> Eclipse. It seems I can no longer run the code as the 'Run as
> Application' menu item is missing. How do I test my code now? TIA.

You're better off visiting the some Eclipse forums for this. I see
no reason to suspect this has anything to do Git or even EGit. You should
check the Error log view for hints errors hidden from view. It can also
be the case that your selection is not a Java class with a test case or
main method.

If it is EGit-related, http://www.eclipse.org/egit/support contains more
tips on getting help.

-- robin
