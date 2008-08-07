From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] Documentation: clarify that git-commit only works with
 tracked files
Date: Thu, 7 Aug 2008 12:52:02 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0808071250530.2808@ds9.cixit.se>
References: <Pine.GSO.4.62.0808061603340.18817@harper.uchicago.edu>
 <20080806214747.GY32057@genesis.frugalware.org>
 <Pine.GSO.4.62.0808061725450.21683@harper.uchicago.edu>
 <Pine.GSO.4.62.0808061906490.24977@harper.uchicago.edu>
 <alpine.DEB.1.00.0808070239120.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 07 14:34:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR4gx-0000xu-NF
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 14:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbYHGM3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 08:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbYHGM3g
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 08:29:36 -0400
Received: from ds9.cixit.se ([193.15.169.228]:58757 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756923AbYHGM3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 08:29:34 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m77Bq65e022625
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Aug 2008 13:52:06 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m77Bq2v2022614;
	Thu, 7 Aug 2008 13:52:02 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0808070239120.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Thu, 07 Aug 2008 13:52:06 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91575>

Johannes Schindelin:

> Funny.  I haven't used CVS for a while now, but I seem to remember
> that "cvs commit newfile.c" without a prior "cvs add newfile.c" is
> not allowed.

Only to add the file to revision control initially. After that, you
just use commit to create new revisions.

-- 
\\// Peter - http://www.softwolves.pp.se/
