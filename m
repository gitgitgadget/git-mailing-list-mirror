From: "Edward Z. Yang" <ezyang@MIT.EDU>
Subject: Re: git-ftp for /contrib
Date: Thu, 27 May 2010 18:46:59 -0400
Message-ID: <1275000359-sup-1204@ezyang>
References: <1274987983.17078.35.camel@zoulou.moser.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?q?Ren=C3=A9_Moser?= <mail@renemoser.net>
X-From: git-owner@vger.kernel.org Fri May 28 00:52:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHlvy-0007Tx-GW
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 00:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab0E0WwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 18:52:08 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:53846 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751777Ab0E0WwG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 May 2010 18:52:06 -0400
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2010 18:52:06 EDT
X-AuditID: 1209190f-b7b20ae000003f85-30-4bfef6654a9c
Received: from mailhub-auth-4.mit.edu (MAILHUB-AUTH-4.MIT.EDU [18.7.62.39])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id 92.E3.16261.566FEFB4; Thu, 27 May 2010 18:47:01 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id o4RMl1R5013918;
	Thu, 27 May 2010 18:47:01 -0400
Received: from localhost (ool-44c4de0a.dyn.optonline.net [68.196.222.10])
	(authenticated bits=0)
        (User authenticated as ezyang@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o4RMkxqI004797;
	Thu, 27 May 2010 18:47:00 -0400 (EDT)
In-reply-to: <1274987983.17078.35.camel@zoulou.moser.lan>
User-Agent: Sup/git
X-Brightmail-Tracker: AAAAAQCq+Kk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147904>

Excerpts from Ren=C3=A9 Moser's message of Thu May 27 15:19:43 -0400 20=
10:
> Hi
>=20
> I scripted a small tool called git-ftp for optimal interaction betwee=
n
> git and ftp. I use it quite often and I thought it might fit in the
> contrib section of git.
>=20
> Please have a look at http://github.com/resmo/git-ftp and give me som=
e
> feedback. See README and an (almost outdated) screencast.
>=20
> Thanks for the great work.
> =20
> Ren=C3=A9 Moser
>=20

What a coincidence! I've also made a small Python script for git<->ftp
synchronization, unsurprisingly called the same thing.

http://github.com/ezyang/git-ftp

(Unfortunately, since it's written in Python it seems pretty unlikely
to go into the contrib section of git.)

Cheers,
Edward
