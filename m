From: Lucas Sandery <lucas@wallcann.com>
Subject: releasing your work
Date: Thu, 16 Apr 2009 14:23:55 +0930
Message-ID: <49E6B9E3.30707@wallcann.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 08:04:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuKiQ-0003pr-Rp
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 08:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbZDPGDS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 02:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbZDPGDR
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 02:03:17 -0400
Received: from carbon.wallcanndns.com ([202.174.106.50]:58292 "EHLO
	host.carbon.wallcanndns.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751671AbZDPGDR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Apr 2009 02:03:17 -0400
X-Greylist: delayed 4154 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Apr 2009 02:03:17 EDT
Received: from 219-90-196-119.static.adam.com.au ([219.90.196.119] helo=[192.168.1.102])
	by host.carbon.wallcanndns.com with esmtpa (Exim 4.69)
	(envelope-from <lucas@wallcann.com>)
	id 1LuJVP-00043V-UO
	for git@vger.kernel.org; Thu, 16 Apr 2009 14:47:20 +1000
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.carbon.wallcanndns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - wallcann.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116672>

Hoping someone can help,

I have a repository for a web application. It has lots of testing files 
and also others from caching and dynamic content generation (they are 
gitignored).

How do I make a "release" a copy (not a clone) of the repository that 
contains only tracked files without .gitignore files? I am using git 
archive but the resulting zip file still contains .gitignore files.

Cheers,
Lucas.
