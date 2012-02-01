From: "Dr. Lars Hanke" <lars@lhanke.de>
Subject: Request for git-svn man page
Date: Wed, 01 Feb 2012 23:32:53 +0100
Message-ID: <4F29BD95.2030708@lhanke.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 23:33:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsijo-0005a1-9L
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 23:33:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786Ab2BAWdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 17:33:07 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:62063 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444Ab2BAWdF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 17:33:05 -0500
Received: from hermod.mgr (p5B36360E.dip.t-dialin.net [91.54.54.14])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0M8zxV-1RiUvw0Wi5-00CNlZ; Wed, 01 Feb 2012 23:33:01 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by hermod.mgr (Postfix) with ESMTP id 6CEF51DC2C4
	for <git@vger.kernel.org>; Wed,  1 Feb 2012 23:33:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hermod.mgr
Received: from hermod.mgr ([127.0.0.1])
	by localhost (hermod.mgr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nQONofKwpsHq for <git@vger.kernel.org>;
	Wed,  1 Feb 2012 23:32:53 +0100 (CET)
Received: from [172.16.1.2] (midgard.mgr [172.16.1.2])
	by hermod.mgr (Postfix) with ESMTP id BE4CF1DC222
	for <git@vger.kernel.org>; Wed,  1 Feb 2012 23:32:53 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20110818 Icedove/3.0.11
X-Provags-ID: V02:K0:DidRxygeK8YZHAcK2KIcO9t0/Wc+wbkGQAnQm8N0LoR
 aijdDft2FodyYZ0igaigPpZGrMnUpSAodg56BPCFAgf4VkZ5Fj
 xLG0EcRn1HeFZnE68e+rYhm/d7/ejpojV67ol6KGWyQxG1zQIq
 KTwCwt99fN5rRCCvkyA0FaWfxR7f9Dao8EBylqQiA/AkNZVHc2
 YUxuljNuM8Y3fOd+I6E5yzkeBGQW6PFmPd1eREiIugKx/lBvKI
 EvulgQcXhjiJEZEFIJguCpHlXZ9clz2Zh8LqO5IkjUhG4fxsV+
 o6Ld7ulFTT4UurlD1ZEJWhMRCaNxfM/IbJHhnaeuVuheq5wKA=
 =
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189547>

Please add instructions to the git-svn man page concerning cloning a SVN 
repositiory through a proxy. In particular make clear that also the SVN 
software has to be configured to use the proxy. See e.g. 
http://stackoverflow.com/questions/9057111/git-svn-ignores-http-proxy-debian.

I'd prepare a patch, but I have no clue about SVN, so I'm probably not 
the best choice for writing a SVN related manual. ;)

Kind regards,
  - lars.
