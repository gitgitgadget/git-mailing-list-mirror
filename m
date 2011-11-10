From: "Brand, Greg" <greg.brand@nordsonasymtek.com>
Subject: RE: Updating Files
Date: Wed, 9 Nov 2011 19:54:34 -0500
Message-ID: <338A71EC3E356A47BF5279971E4EF72A04D860D7F6@WESMSG51.nordsoncorp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 01:54:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROIuU-0006tq-Dh
	for gcvg-git-2@lo.gmane.org; Thu, 10 Nov 2011 01:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919Ab1KJAyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Nov 2011 19:54:18 -0500
Received: from mail144.messagelabs.com ([216.82.254.51]:23656 "EHLO
	mail144.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756849Ab1KJAyP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2011 19:54:15 -0500
X-Env-Sender: greg.brand@nordsonasymtek.com
X-Msg-Ref: server-7.tower-144.messagelabs.com!1320886401!139783790!1
X-Originating-IP: [192.189.192.220]
X-StarScan-Version: 6.3.6; banners=nordsonasymtek.com,-,-
X-VirusChecked: Checked
Received: (qmail 26163 invoked from network); 10 Nov 2011 00:53:22 -0000
Received: from mail.nordson.com (HELO mail.nordson.com) (192.189.192.220)
  by server-7.tower-144.messagelabs.com with RC4-SHA encrypted SMTP; 10 Nov 2011 00:53:22 -0000
Received: from WESMSG51.nordsoncorp.local ([172.18.5.60]) by
 WESHUB50.nordsoncorp.local ([172.18.5.71]) with mapi; Wed, 9 Nov 2011
 19:54:13 -0500
Thread-Topic: Updating Files
Thread-Index: AcyfQXmZ6ahwBs67SNOXdgYuXhsWgQAAQoBQAAAWFJA=
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
x-puremessage: [Scanned]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185180>

Good Day,

Let me begin by describing my SCM experience.
I am an old school UNIX guy, and grew up with RCS.
I have written many BASH and CSH scripts for RCS.

Moving on, the next logical step was CVS.
I've worked with (and administered) CVS for the last 12 years.
I have also worked with SourceSafe (ugh), Perforce and ClearCase.

I am an avid CVS proponent.

I have Recently changed jobs, to a SourceSafe shop.
We HAVE to move to something different.

I've played with both Subversion and GIT.
I REALLY like GIT, but have some questions.


=46or my questions, I will use a CVS comparison sense this is what I'm =
most familiar with.

- Updating a File:=20
=A0=A0=A0~ CVS's default behavior, is to try to merge changes from the =
repository into my local copy. Sometimes, this isn't desirable.=20
=A0=A0=A0~ With CVS I can also choose to get a "clean" copy. If the fil=
e I'm updating has been modified, CVS will create a backup of the origi=
nal file before updating to the clean version. The backup file is saved=
 as a "hidden" file, with the format:
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .<filename>.revision
=A0=A0 ~ Does GIT have the same, or similar options???=A0 I understand =
with the distributed nature of GIT, there may be several ways to accomp=
lish this. It is nice, though, to be able to get a clean version withou=
t losing changes you may (or may not) want to keep.


Thank you for your help.
I am sure I will have more questions.

Best Regards,
Greg Brand


_______________________________________________________________________=
______
Scanned by IBM Email Security Management Services powered by MessageLab=
s. For more information please visit http://www.ers.ibm.com

This email is intended only for the use of the party to which it is add=
ressed and may contain information that is privileged, confidential, or=
 protected by law.  If you are not the intended recipient you are hereb=
y notified that any dissemination, copying or distribution of the email=
 or its contents is strictly prohibited.  If you have received this mes=
sage in error, please notify us immediately, by replying to the message=
 and deleting it from your computer.

WARNING: Internet communications are not assured to be secure or clear =
of inaccuracies as information could be intercepted, corrupted, lost, d=
estroyed, arrive late or incomplete, or contain viruses.  Therefore, we=
 do not accept responsibility for any errors or omissions that are pres=
ent in this email, or any attachment, that have arisen as a result of e=
-mail transmission.
_______________________________________________________________________=
______
