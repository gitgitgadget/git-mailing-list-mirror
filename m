From: "mike.gaffney" <mike.gaffney@asolutions.com>
Subject: Question: git commit -v uncomment Changes to be commited
Date: Wed, 18 Jun 2008 22:04:21 -0500
Message-ID: <4859CCB5.9070200@asolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 06:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9BNB-000273-Vu
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 06:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbYFSECu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 00:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbYFSECu
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 00:02:50 -0400
Received: from 9a.26.1243.static.theplanet.com ([67.18.38.154]:44036 "EHLO
	rubble.crucialcrossbar.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750726AbYFSECt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 00:02:49 -0400
X-Greylist: delayed 3550 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Jun 2008 00:02:49 EDT
Received: from adsl-70-237-220-102.dsl.stlsmo.sbcglobal.net ([70.237.220.102] helo=[192.168.1.106])
	by rubble.crucialcrossbar.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <mike.gaffney@asolutions.com>)
	id 1K9AQu-0006Z7-Of
	for git@vger.kernel.org; Wed, 18 Jun 2008 22:03:32 -0500
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rubble.crucialcrossbar.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - asolutions.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85447>

I find myself always uncommenting the "Changes to be commited:" section 
on a git commit -v. Other than a nifty regex with vi, I'm wondering if 
there is a way to customize the unified diff that is created with commit 
-v. I've looked through the list, but it is one of those things where I 
don't really know how to ask the question (phrase the search). I would 
be glad of any help that people could give me.

Thanks,
   Mike Gaffney
