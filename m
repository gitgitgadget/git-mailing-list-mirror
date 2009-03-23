From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: should "git describe" include info about not already committed patches ?
Date: Mon, 23 Mar 2009 11:37:18 +0100
Message-ID: <200903231137.19103.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 11:39:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlhZQ-0006T7-W9
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 11:39:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894AbZCWKiJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 06:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755724AbZCWKiI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 06:38:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:52922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754776AbZCWKiF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 06:38:05 -0400
Received: (qmail invoked by alias); 23 Mar 2009 10:37:59 -0000
Received: from blueice1n1.de.ibm.com (EHLO n99hzp5a.hamburg.de.ibm.com) [195.212.29.163]
  by mail.gmx.net (mp004) with SMTP; 23 Mar 2009 11:37:59 +0100
X-Authenticated: #5108953
X-Provags-ID: V01U2FsdGVkX181ANdoUsk10JNIXhoeJTgSng5Y0puvEKAKAvBLCX
	fq3eCPx77cS6qb
User-Agent: KMail/1.9.10
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.82
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114282>

I'm wondering, if there's a option for "git describe" to point out the =
changes =20
(as seen with git diff) which are made w/o a commit to a current trunk.

--=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
