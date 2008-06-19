From: Mike Gaffney <mike@uberu.com>
Subject: Question: git commit -v uncomment Changes to be commited
Date: Wed, 18 Jun 2008 21:36:16 -0500
Message-ID: <4859C620.1020702@uberu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 05:12:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9AZV-0008Fh-64
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 05:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbYFSDL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 23:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbYFSDL3
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 23:11:29 -0400
Received: from 9a.26.1243.static.theplanet.com ([67.18.38.154]:43772 "EHLO
	rubble.crucialcrossbar.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751905AbYFSDL3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 23:11:29 -0400
X-Greylist: delayed 2155 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jun 2008 23:11:29 EDT
Received: from adsl-70-237-220-102.dsl.stlsmo.sbcglobal.net ([70.237.220.102] helo=[192.168.1.106])
	by rubble.crucialcrossbar.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <mike@uberu.com>)
	id 1K99zi-0006RN-T1
	for git@vger.kernel.org; Wed, 18 Jun 2008 21:35:26 -0500
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rubble.crucialcrossbar.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - uberu.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85444>

I find myself always uncommenting the "Changes to be commited:" section 
on a git commit -v. Other than a nifty regex with vi, I'm wondering if 
there is a way to customize the unified diff that is created with commit 
-v. I've looked through the list, but it is one of those things where I 
don't really know how to ask the question (phrase the search). I would 
be glad of any help that people could give me.

Thanks,
    gaffo
