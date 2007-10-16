From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 13:38:59 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0710161335500.8571@ds9.cixit.se>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <471448D0.6080200@op5.se> <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
 <Pine.LNX.4.64.0710161324490.25221@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eli Zaretskii <eliz@gnu.org>, Andreas Ericsson <ae@op5.se>,
	barkalow@iabervon.org, raa.lkml@gmail.com, tsuna@lrde.epita.fr,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 14:39:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihlhn-0004rL-18
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 14:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758453AbXJPMjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 08:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758589AbXJPMjQ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 08:39:16 -0400
Received: from ds9.cixit.se ([193.15.169.228]:47760 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758319AbXJPMjP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 08:39:15 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9GCd0nQ008699
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Oct 2007 14:39:00 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id l9GCcxRn008686;
	Tue, 16 Oct 2007 14:38:59 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <Pine.LNX.4.64.0710161324490.25221@racer.site>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Tue, 16 Oct 2007 14:39:00 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61156>

> No, it is not.  On FAT filesystems, for example, I experienced Windows 
> happily naming a file "head" which was created under then name "HEAD".

If you create a file name with only capital letters, I believe Explorer
and the file browser will display the name with an initial capital, and
the rest lowercase, or in all lowercase. IIRC, this is because such a
file is saved with only an MS-DOS name and no LFN entry, and those have
special rules to avoid them being displayed in all-uppercase.

I believe it is possible to create a LFN entry for such a file, but I
can't remember right now how to do it.

-- 
\\// Peter - http://www.softwolves.pp.se/
