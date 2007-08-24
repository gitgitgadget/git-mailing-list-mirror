From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: git-kompare
Date: Fri, 24 Aug 2007 21:52:08 +0200
Message-ID: <200708242152.09176.robin.rosenberg.lists@dewire.com>
References: <46CE6F56.70803@csiro.au> <200708241813.48012.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jean-Marc Valin <jean-marc.valin@csiro.au>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 21:51:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOfBX-0005NR-Vl
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 21:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbXHXTus (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 15:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbXHXTur
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 15:50:47 -0400
Received: from [83.140.172.130] ([83.140.172.130]:22216 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750949AbXHXTur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 15:50:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EDBF780264D;
	Fri, 24 Aug 2007 21:42:58 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18102-08; Fri, 24 Aug 2007 21:42:58 +0200 (CEST)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 94DB080264B;
	Fri, 24 Aug 2007 21:42:58 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <200708241813.48012.andyparkins@gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56596>

fredag 24 augusti 2007 skrev Andy Parkins:
> On Friday 2007, August 24, Jean-Marc Valin wrote:
> 
> > (http://mail.kde.org/pipermail/kompare-devel/2006-August/000141.html
> > which is fixed in some later version of kompare I think)
> 
> I was the original reporter of that bug; I have to say the kompare 
> developers were fairly quick on the uptake and fixed that problem with the 
> next realease of kompare - which came very soon after the report.  I just 
I am more of a GIT developer than a KDE developer.

> waited for it to arrive in debian unstable, which also happened fairly 
> quickly.  If you are seriously that far behind in your kompare version I 
> strongly suggest upgrading, I mean, if it's in debian then it's in 
> everything else :-)

Adding the patch to your version isn't hard. Just download the source package
and add the patch in the patches section and rebuild. That's how I lived with
the fix until Mandriva delivered a newer KDE version. Thanks to the kdesdk src
rpm I could rebuild the package fairly easily without dowloading, configuring
and builing most of KDE. The src rpm declare the dependencies I need. My 
guess is that is about as easy with dpkg, ebuilds or ports.

> I found it quite nostalgic seeing that report, as I made the report a few 
> days after my first use of git, which means I've just had my git 
> anniversary.  How quickly time flys - I can hardly believe I ever managed 
> without it now.

This was about two months after starting to use git in my case. My first git bug was
encountered abour ten minutes after trying git. (Linus fixed the bug the day after).

-- robin
