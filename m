From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Announce: Git for Windows 1.6.3
Date: Sat, 16 May 2009 20:19:20 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0905162017450.2954@ds9.cixit.se>
References: <alpine.DEB.1.00.0905071554070.16585@intel-tinevez-2-302> <alpine.DEB.2.00.0905141920140.10118@ds9.cixit.se> <alpine.DEB.1.00.0905142101450.27348@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat May 16 21:19:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5PPv-0005Qa-VB
	for gcvg-git-2@gmane.org; Sat, 16 May 2009 21:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668AbZEPTTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 May 2009 15:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755528AbZEPTTX
	(ORCPT <rfc822;git-outgoing>); Sat, 16 May 2009 15:19:23 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:49914 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754971AbZEPTTX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 May 2009 15:19:23 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5) with ESMTP id n4GJJKVD003307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 May 2009 21:19:20 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id n4GJJK7F003301;
	Sat, 16 May 2009 21:19:20 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0905142101450.27348@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Sat, 16 May 2009 21:19:20 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119377>

Johannes Schindelin:

> But the puzzle is easy to solve: git-upload-pack is called on the remote 
> side.  So it is not Git for Windows having this issue.

Yes, of course. I didn't think of that.

Now to figure out what makes it different from when I do a pull from other 
Git installs over ssh from this repository and have it working.

Thanks for the pointer!

-- 
\\// Peter - http://www.softwolves.pp.se/
