From: Markus Fischer <markus@fischer.name>
Subject: Git bugtraq for all users who clone my repos?
Date: Mon, 28 Feb 2011 13:05:18 +0100
Message-ID: <4D6B8F7E.4070804@fischer.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 28 13:06:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu1ry-0002cE-Do
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 13:06:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab1B1MGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 07:06:25 -0500
Received: from fep22.mx.upcmail.net ([62.179.121.42]:50685 "EHLO
	fep22.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497Ab1B1MGY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 07:06:24 -0500
Received: from edge03.upcmail.net ([192.168.13.238])
          by viefep14-int.chello.at
          (InterMail vM.8.01.02.02 201-2260-120-106-20100312) with ESMTP
          id <20110228120520.RNCK1458.viefep14-int.chello.at@edge03.upcmail.net>
          for <git@vger.kernel.org>; Mon, 28 Feb 2011 13:05:20 +0100
Received: from mail02.home ([80.109.57.233])
	by edge03.upcmail.net with edge
	id DQ5J1g03351v47k03Q5KT3; Mon, 28 Feb 2011 13:05:20 +0100
X-SourceIP: 80.109.57.233
Received: from mail02.home ([192.168.1.201] helo=[IPv6:::1])
	by mail02.home with esmtp (Exim 4.72)
	(envelope-from <markus@fischer.name>)
	id 1Pu1r4-0004v7-LW
	for git@vger.kernel.org; Mon, 28 Feb 2011 13:05:35 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
X-Spam_report: Spam detection software, running on the system "scanner01.home", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi, I'm used to svn to use svn:propset to set bugtraq URLs,
    pus^H^H^Hcommit them to the server and all users who clo^H^H^Hcheckout from
    it have the settings. In git I can store them in my local or repository specific
    configuration, but other users who clone from it don't benefit from it: they
    simply don't get my/the bugtraq configuration. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 A 
X-Cloudmark-Analysis: v=1.1 cv=CqMFsqQC4gx7bBgpmnW/wKYuJF/a5pXPeCAfngFtYkU= c=1 sm=0 a=XU2IyiEZIEYA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=mkzvCsXLHb3EoMk6daMA:9 a=uIfZGAT4nnPnSiqBifwAfusdpMYA:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168100>

Hi,

I'm used to svn to use svn:propset to set bugtraq URLs, pus^H^H^Hcommit 
them to the server and all users who clo^H^H^Hcheckout from it have the 
settings.

In git I can store them in my local or repository specific 
configuration, but other users who clone from it don't benefit from it: 
they simply don't get my/the bugtraq configuration.

Do I need to educate every developer to configure their checkouts (also 
unsatisfying for myself when I move somewhere else have to do clone my 
repository again) or it possible to feed it when the repository is being 
cloned?

thanks,
- Markus
