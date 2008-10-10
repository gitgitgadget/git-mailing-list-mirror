From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Fri, 10 Oct 2008 09:12:50 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0810100910340.10709@ds9.cixit.se>
References: <48CF5127.5040507@gnu.org> <48CF5ABC.5060507@gmail.com>
 <48CF6A7C.4020604@gnu.org> <48E4C401.90409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 10 10:14:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoD8q-0007VU-Jn
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 10:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbYJJIM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 04:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755288AbYJJIM7
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 04:12:59 -0400
Received: from ds9.cixit.se ([193.15.169.228]:55663 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046AbYJJIMz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 04:12:55 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m9A8CoY1024213
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 10 Oct 2008 10:12:51 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m9A8CoNV024208;
	Fri, 10 Oct 2008 10:12:50 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <48E4C401.90409@drmicha.warpmail.net>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 10 Oct 2008 10:12:51 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97913>

Michael J Gruber:

> I'm not sure about the lessons, but I wanted to share the numbers
> anyways. I think this (your script and its usage) is heading in a useful
> direction and should maybe made more known, if not made easier from the
> git side.

I had very positive experiences with the script for my use-case. I did
post them to the list, but it seems as if they got lost. At least I
can't seem to find them, did they show up?

I had some problems with the script when trying to run it under
Windows, though. Running Windows-Git from a Cygwin prompt provides some
confusion about some of the Unix tools' behaviour that I needed to
work around (like removing "/cygdrive" prefixes).

-- 
\\// Peter - http://www.softwolves.pp.se/
