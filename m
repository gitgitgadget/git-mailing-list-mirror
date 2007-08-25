From: Jean-Marc Valin <jean-marc.valin@csiro.au>
Subject: Re: git-kompare
Date: Sat, 25 Aug 2007 10:17:13 +1000
Message-ID: <46CF7509.5080206@csiro.au>
References: <46CE6F56.70803@csiro.au> <200708241813.48012.andyparkins@gmail.com> <200708242152.09176.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 02:43:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOjkh-0005ow-9v
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 02:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756921AbXHYAnn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 20:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756917AbXHYAnn
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 20:43:43 -0400
Received: from 142.163.233.220.exetel.com.au ([220.233.163.142]:37841 "EHLO
	nemesis.dnsalias.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751247AbXHYAnm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 20:43:42 -0400
X-Greylist: delayed 1579 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Aug 2007 20:43:42 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by nemesis.dnsalias.com (Postfix) with ESMTP id 95501200148;
	Sat, 25 Aug 2007 10:17:13 +1000 (EST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <200708242152.09176.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56617>

> Adding the patch to your version isn't hard. Just download the source package
> and add the patch in the patches section and rebuild. That's how I lived with
> the fix until Mandriva delivered a newer KDE version. Thanks to the kdesdk src
> rpm I could rebuild the package fairly easily without dowloading, configuring
> and builing most of KDE. The src rpm declare the dependencies I need. My 
> guess is that is about as easy with dpkg, ebuilds or ports.

Unless I missed something, there are more things to work around than the
one that was fixed in your patch, no? For example, the fact that kompare
doesn't understand when the filename is /dev/null. As for upgrading
kompare, I'm all for the idea, but the KDE folks aren't making that
easy. The only link in the Kompare download section is for www.kde.org,
which isn't making the source code any easier to find (including a 404
link for "Source code" on the front page!). Any direct link?

BTW, I'm running the latest Ubuntu (Feisty) that ships with kompare 3.4.

	Jean-Marc
