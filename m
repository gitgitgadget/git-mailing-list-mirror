From: Jean-Luc Herren <jlh@gmx.ch>
Subject: [PATCH] Documentation: Fix typo
Date: Thu, 31 Jan 2008 03:06:04 +0100
Message-ID: <47A12D0C.7030304@gmx.ch>
References: <87myqoxvzk.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 03:06:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKOpI-0000iA-4a
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 03:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756414AbYAaCGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 21:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756408AbYAaCGP
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 21:06:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:54272 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754911AbYAaCGO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 21:06:14 -0500
Received: (qmail invoked by alias); 31 Jan 2008 02:06:12 -0000
Received: from 55-14.79-83.cust.bluewin.ch (EHLO [192.168.123.202]) [83.79.14.55]
  by mail.gmx.net (mp006) with SMTP; 31 Jan 2008 03:06:12 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/X90JNA7fXq4tBvqdvItwoZ75TSXPL52GMb52Csc
	wTAaUZ5mVDf3bg
User-Agent: Thunderbird 2.0.0.9 (X11/20071118)
In-Reply-To: <87myqoxvzk.fsf@rho.meyering.net>
X-Enigmail-Version: 0.95.5
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72091>


Signed-off-by: Jean-Luc Herren <jlh@gmx.ch>
---

Beside the obvious s/if/is/ typo, is it easier to read this way?
It might be my ears but "is run" sounds strange to me.

jlh

 Documentation/git-cvsserver.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index c831548..d3e9993 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -183,7 +183,7 @@ access method and requested operation.
 That means that even if you offer only read access (e.g. by using
 the pserver method), git-cvsserver should have write access to
 the database to work reliably (otherwise you need to make sure
-that the database if up-to-date all the time git-cvsserver is run).
+that the database is up-to-date any time git-cvsserver is executed).
 
 By default it uses SQLite databases in the git directory, named
 `gitcvs.<module_name>.sqlite`. Note that the SQLite backend creates
-- 
1.5.3.8
