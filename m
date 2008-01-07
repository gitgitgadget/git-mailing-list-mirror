From: Peter Karlsson <peter@softwolves.pp.se>
Subject: CRLF problems with Git on Win32
Date: Mon, 7 Jan 2008 10:16:50 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 10:17:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBo6m-0008AC-Pa
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 10:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753508AbYAGJQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 04:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781AbYAGJQy
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 04:16:54 -0500
Received: from ds9.cixit.se ([193.15.169.228]:60452 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbYAGJQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 04:16:53 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m079GpZZ016902
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 7 Jan 2008 10:16:51 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m079GoVl016897;
	Mon, 7 Jan 2008 10:16:50 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Mon, 07 Jan 2008 10:16:51 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69774>

Hi!

When I clone git://git.debian.org/git/turqstat/turqstat.git using the
msys-Windows version of git (1.5.4-rc2), some but not all the files get
autoconverted to CRLF. Is it possible to set properties for the files
that are text, to make sure they are converted properly?

-- 
\\// Peter - http://www.softwolves.pp.se/
