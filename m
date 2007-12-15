From: Luke Diamand <luke@vidanti.com>
Subject: One of my commits is missing
Date: Sat, 15 Dec 2007 22:16:18 +0000
Message-ID: <47645232.7050502@vidanti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 23:22:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3fPE-0005SP-Ke
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 23:22:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383AbXLOWW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753267AbXLOWW0
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 17:22:26 -0500
Received: from c2bthomr09.btconnect.com ([213.123.20.127]:18060 "EHLO
	c2bthomr09.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbXLOWWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 17:22:25 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Dec 2007 17:22:24 EST
Received: from salieri.ballroom.vidanti.com 
	by c2bthomr09.btconnect.com
	with ESMTP id DHU20802;
	Sat, 15 Dec 2007 22:16:19 GMT
Received: from [10.9.0.18]
	by salieri.ballroom.vidanti.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <luke@vidanti.com>)
	id 1J3fIx-0000Iw-5R
	for git@vger.kernel.org; Sat, 15 Dec 2007 22:16:19 +0000
User-Agent: Icedove 1.5.0.14pre (X11/20071018)
X-Junkmail-Status: score=10/50, host=c2bthomr09.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0203.4764510F.00BA,ss=1,fgs=0,
	ip=0.0.0.0,
	so=2006-12-09 10:45:40,
	dmn=5.4.3/2007-11-16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68419>


My last commit seems to have vanished, and I wonder if anyone knows 
where it might have gone.

I had a branch with a big pile of changes on it, and I merged those onto 
a second branch to tidy it all up and fix one last bug.

I did a git-commit, and then created a third branch to start some other 
unrelated work (git-checkout -b ...).

Now that second branch no longer has my last commit.

Obviously most of my changes are still on the first branch, but I'd 
quite like to get back my commit.

Looking through my history I don't see any signs of errant git-reset's 
so I'm baffled.

Any ideas?

Thanks
Luke Diamand
