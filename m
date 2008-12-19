From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Announcement: Git Extensions stable (windows shell extensions)
Date: Fri, 19 Dec 2008 11:36:25 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0812191134220.6540@ds9.cixit.se>
References: <1229540813648-1669264.post@n2.nabble.com>
 <1229543462897-1669467.post@n2.nabble.com> <1229547366402-1669761.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Henk <henk_westhuis@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 11:37:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDcjt-0000jw-Jl
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 11:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbYLSKgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 05:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbYLSKgb
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 05:36:31 -0500
Received: from ds9.cixit.se ([193.15.169.228]:53288 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751106AbYLSKgb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 05:36:31 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mBJAaQac031110
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 19 Dec 2008 11:36:26 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mBJAaPsM031102;
	Fri, 19 Dec 2008 11:36:25 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1229547366402-1669761.post@n2.nabble.com>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 19 Dec 2008 11:36:26 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103558>

Henk:

> I just rereleased a 0.9 version without the visual studio plugin. Too bad it
> causes problems, I will try to fix them soon. I was able to reproduce the
> error on my laptop, so thats a good start.

I tried with the 0.91 version but ran into a different problem:

  "The system cannot open the device or file specified."

followed by

  "The installer has encountered an unexpected error installing this
   package. This may indicate a problem with this package. The error code
   is 2755."

-- 
\\// Peter - http://www.softwolves.pp.se/
