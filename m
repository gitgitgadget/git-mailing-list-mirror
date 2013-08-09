From: Peter Krefting <peter@softwolves.pp.se>
Subject: gitk: "Can't parse git log output: { }"
Date: Fri, 9 Aug 2013 07:31:53 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1308090727340.3907@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 09 08:32:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7gEz-000472-Lq
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 08:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220Ab3HIGb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 02:31:57 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:40000 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S967395Ab3HIGb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 02:31:56 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id r796VsPt011239
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 9 Aug 2013 08:31:54 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id r796Vs0M011236;
	Fri, 9 Aug 2013 08:31:54 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Fri, 09 Aug 2013 08:31:54 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231957>

Hi!

In my local clone of git.git, currently with the v1.8.4-rc2 tag 
checked out and built (and installed on the system), starting up gitk 
yields an empty window, with a dialog in front of it:

   error

   Can't parse git log output: { }

   [ OK ]

Has anyone else seen this, and know what might have happened? I do not 
get the behaviour in other repositories (including other clones of 
git.git), only this particular one.

-- 
\\// Peter - http://www.softwolves.pp.se/
