From: Thell Fowler <git@tbfowler.name>
Subject: Re: [PATCH] gitk: new option to hide remote refs
Date: Sun, 9 Aug 2009 19:14:12 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.0908091909140.3470@GWPortableVCS>
References: <55b7e43bcd59aa64c70edde83ac87147aa0091bb.1249336225.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 10 03:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaJbd-0008CB-Ls
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 03:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbZHJBXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 21:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbZHJBXE
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 21:23:04 -0400
Received: from 216.38.49.125.servint.net ([216.38.49.125]:49312 "EHLO
	vps5.pyrapat.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbZHJBXD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 21:23:03 -0400
X-Greylist: delayed 4116 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Aug 2009 21:23:03 EDT
Received: from ip70-178-75-143.ks.ks.cox.net ([70.178.75.143] helo=GWPortableVCS.local)
	by vps5.pyrapat.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tbfowler.name>)
	id 1MaIWk-0008KU-SC; Sun, 09 Aug 2009 19:14:15 -0500
X-X-Sender: almostautomated@GWPortableVCS
In-Reply-To: <55b7e43bcd59aa64c70edde83ac87147aa0091bb.1249336225.git.trast@student.ethz.ch>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vps5.pyrapat.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tbfowler.name
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125395>

Thomas Rast (trast@student.ethz.ch) wrote on Aug 3, 2009:

> In repositories with lots of remotes, looking at the history in gitk
> can be borderline insane with all the red labels for remote refs.
> Introduce a new option in the preferences that hides them.

Thanks for doing this!  It definitely is saving the sanity and is working 
great!

-- 
Thell
