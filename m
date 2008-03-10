From: Filippo Zangheri <filippo.zangheri@yahoo.it>
Subject: [QUESTION] Selective fetch possible?
Date: Mon, 10 Mar 2008 23:02:27 +0100
Message-ID: <47D5AFF3.90000@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 23:46:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYqle-0005U7-PD
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 23:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbYCJWqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 18:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbYCJWqM
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 18:46:12 -0400
Received: from n10.bullet.mail.mud.yahoo.com ([209.191.125.208]:26868 "HELO
	n10.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751252AbYCJWqL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2008 18:46:11 -0400
Received: from [68.142.194.243] by n10.bullet.mail.mud.yahoo.com with NNFMP; 10 Mar 2008 15:41:37 -0000
Received: from [68.142.201.252] by t1.bullet.mud.yahoo.com with NNFMP; 10 Mar 2008 22:46:10 -0000
Received: from [127.0.0.1] by omp413.mail.mud.yahoo.com with NNFMP; 10 Mar 2008 22:46:10 -0000
X-Yahoo-Newman-Id: 630218.85964.bm@omp413.mail.mud.yahoo.com
Received: (qmail 42466 invoked from network); 10 Mar 2008 22:02:32 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:X-Enigmail-Version:OpenPGP:Content-Type:Content-Transfer-Encoding;
  b=gq1yF4AJ+XcK/U1eP/IrYm7TevFalXjSWm6xulU94d+BEpwDEa8wB+irKZLejTKJoZRFodv3fHNKYQ6BNfsus5NaUKz2I1AEV4/jvVPhUc+NoNyA0LGG66BMW0Mh0t+TrfkH3nsWizTWA2HGlDyCfm0MjBpUXZP57LyWCBnUMjE=  ;
Received: from unknown (HELO ?82.50.29.33?) (filippo.zangheri@82.50.29.33 with plain)
  by smtp113.plus.mail.mud.yahoo.com with SMTP; 10 Mar 2008 22:02:31 -0000
X-YMail-OSG: UxnEBbMVM1noHlmzls.7LwWpRqyHX4S7UgC8PiRoLOSzvayuGvhGOg49wRcChB6U7.0YJgfedNJO1G2kDrNDBlgFBLxfpARE9b18EjMtBHAQpQMC8xrTOyg5G8x5nnV1ce1HPEIBrfPliU2U
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
X-Enigmail-Version: 0.95.6
OpenPGP: id=E1D879FA;
	url=http://pgp.mit.edu:11371/pks/lookup?op=get&search=0xE1D879FA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76765>

Hi everybody,

Is it possible to git-fetch only a portion of the tree
of the specified repository, say, fetch only one directory or a
subset of files matching some regular expression? This is currently
- to my knowledge - only possible via wget iff the GIT repository
has gitweb enabled. But that's just a workaround.

Thanks for the great instrument that GIT is.
Best regards.

PS: please CC me in replies, because I'm not subscribed to git ML.

-- 
Filippo Zangheri

GPG key ID: 0xE1D879FA
Key fingerprint: 816B CE57 D43C 0A47 EF35 3378 EA5F A72A E1D8 79FA
Key server: pgp.mit.edu

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GE d- s+:- a-- C++ UL+++ P+ L+++ E-- W+ N* o-- K- w--- O-- M--
V- PS++ PE+ Y+ PGP++ t 5-- X++ R* tv b+ DI-- D---- G-- e++ h--
r++ z*
------END GEEK CODE BLOCK------
