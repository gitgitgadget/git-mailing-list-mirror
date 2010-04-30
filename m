From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Multiblobs
Date: Fri, 30 Apr 2010 09:20:39 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1004300918310.24359@ds9.cixit.se>
References: <loom.20100428T164432-954@post.gmane.org> <k2y32541b131004281107u6d15ed4ex54b5e5c138cc0e24@mail.gmail.com>  <loom.20100428T204406-308@post.gmane.org> <k2x32541b131004281427o2101720at3d324f5e94f05327@mail.gmail.com>  <alpine.DEB.2.00.1004291231410.16241@ds9.cixit.se>
 <x2v32541b131004290828ua9c2d194o1280177360dd231e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 30 18:58:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7tYD-0007hV-1b
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 18:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970Ab0D3QyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 12:54:15 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:36880 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757630Ab0D3QyF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 12:54:05 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id o3U8Kd03029178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 30 Apr 2010 10:20:39 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o3U8KdD5029175;
	Fri, 30 Apr 2010 10:20:39 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <x2v32541b131004290828ua9c2d194o1280177360dd231e@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Fri, 30 Apr 2010 10:20:39 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146031>

Avery Pennarun:

(I seem to have been unsubscribed from the list, and can't subscribe again; 
please keep cc's to me for the time being).

> This use case seems to be converging more and more on the "clean/smudge 
> filter like" idea, which might be ok.

That's what I am using now (recompressing files), but that approach is a bit 
fragile (it suddenly broke on my Mac install, and it only works 
intermittently on Windows).

> It might be saner to just write some wrapper scripts on top of git, and 
> cleanly just check in the individual components.

Yeah, that was my thought to (thus the "zgit" idea).

-- 
\\// Peter - http://www.softwolves.pp.se/
