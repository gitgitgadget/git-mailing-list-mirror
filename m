From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Announce: Git for Windows 1.6.3
Date: Thu, 14 May 2009 19:23:00 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0905141920140.10118@ds9.cixit.se>
References: <alpine.DEB.1.00.0905071554070.16585@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 20:28:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4ffd-0000es-Qv
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 20:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbZENS2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 14:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbZENS2c
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 14:28:32 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:43542 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751766AbZENS2c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 14:28:32 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2009 14:28:31 EDT
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n4EIN0aM010455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 May 2009 20:23:00 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n4EIN0E5010451;
	Thu, 14 May 2009 20:23:00 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0905071554070.16585@intel-tinevez-2-302>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Thu, 14 May 2009 20:23:00 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119211>

Johannes Schindelin:

> Git Release Notes (Git-1.6.3-preview20090507)
> Last update: 07 May 2009

I installed the -2 version, but I am having problems pushing:

  > git pull
  git-upload-pack: error while loading shared libraries: libcurl.so.3: cannot open shared object file: No such file or directory
  fatal: The remote end hung up unexpectedly

I used the install that puts git in the PATH, and am running it from CMD in 
this case. Any ideas on what might be wrong?

-- 
\\// Peter - http://www.softwolves.pp.se/
