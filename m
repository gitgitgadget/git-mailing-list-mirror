From: Peter Krefting <peter@softwolves.pp.se>
Subject: Get a copy of an old version of a file, using git gui/gitk
Date: Fri, 19 Sep 2008 08:58:04 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0809190855060.17960@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 19 09:59:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kgate-0007UY-Sr
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 09:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbYISH6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Sep 2008 03:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbYISH6I
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 03:58:08 -0400
Received: from ds9.cixit.se ([193.15.169.228]:45680 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908AbYISH6H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Sep 2008 03:58:07 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8J7w5Y1025090
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 19 Sep 2008 09:58:05 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m8J7w4Jc025085;
	Fri, 19 Sep 2008 09:58:04 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 19 Sep 2008 09:58:05 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96264>

Hi!

I am trying to introduce new people to Git, and am primarily showing
how to use the GUI tools (git gui/gitk), since the project is running
on Windows. A question that I couldn't answer arose:

How do I save a copy of an older version of a file (one that has either
been modified locally, or an earlier version in the project history),
from git gui or gitk?

>From the command line, I would try to find the SHA-1 and use git
cat-file, but I can't figure out how to do it from the GUIs. Or, to
fall back to the command-line, how to get the SHA-1 for the object out
of git gui/gitk.

-- 
\\// Peter - http://www.softwolves.pp.se/
