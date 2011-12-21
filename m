From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Escape character for .gitconfig
Date: Wed, 21 Dec 2011 13:54:30 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1112211352580.17957@ds9.cixit.se>
References: <4EEC6A9D.1060005@icefield.yk.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Erik Blake <erik@icefield.yk.ca>
X-From: git-owner@vger.kernel.org Wed Dec 21 14:05:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdLr4-0007n7-Gk
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 14:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab1LUNFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 08:05:06 -0500
Received: from upper-gw.cixit.se ([92.43.32.133]:46744 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751671Ab1LUNFE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 08:05:04 -0500
X-Greylist: delayed 627 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Dec 2011 08:05:04 EST
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id pBLCsVSt031360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 21 Dec 2011 13:54:31 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id pBLCsU3d031357;
	Wed, 21 Dec 2011 13:54:31 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <4EEC6A9D.1060005@icefield.yk.ca>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Wed, 21 Dec 2011 13:54:31 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187561>

Erik Blake:

> As you can see, I'm running git on a Win7 64 machine. Is there any way to 
> escape the brackets? Or do I need to reinstall notepad++ on a different path?

Just use the 8.3 path instead, using either "C:/Progra~1" or "C:/Progra~2" 
(depending on how the system got installed). You can mix 8.3 and long paths 
in the same command (so keeping the "Notepad++" component is fine).

-- 
\\// Peter - http://www.softwolves.pp.se/
