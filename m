From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: Git documentation at kernel.org
Date: Fri, 10 Feb 2012 13:00:34 -0500
Message-ID: <FC56A942-EE70-48B7-A2D3-CF53A189A55E@mit.edu>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com> <20120208213410.GA5768@ecki> <7vmx8rtu3e.fsf@alter.siamese.dyndns.org> <vpqbop6tyj6.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 10 19:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvur0-0008EC-1h
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 19:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380Ab2BJSFp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 13:05:45 -0500
Received: from DMZ-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.36]:65306 "EHLO
	dmz-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750913Ab2BJSFo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 13:05:44 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Feb 2012 13:05:44 EST
X-AuditID: 12074424-b7fae6d000000906-f8-4f355b4b22a4
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	by dmz-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id F9.A3.02310.B4B553F4; Fri, 10 Feb 2012 13:00:43 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id q1AI0fnf016748;
	Fri, 10 Feb 2012 13:00:41 -0500
Received: from [192.168.155.222] ([216.239.45.22])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id q1AI0YtA026237
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 10 Feb 2012 13:00:36 -0500 (EST)
In-Reply-To: <vpqbop6tyj6.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.1257)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRmVeSWpSXmKPExsUixCmqresdbepv0PyF2eLfnGmsFps3fmSx
	6LrSzWTR0HuF2eJro7XFpc/rWR3YPO6sPMbusXPWXXaPiV+Os3psWtXJ5nHxkrLH501yAWxR
	XDYpqTmZZalF+nYJXBnvnp1jKXjEWTHnVBtTA+M59i5GTg4JAROJs82LWCBsMYkL99azgdhC
	AvsYJRZ3MHUxcgHZGxglHj7dwQ6RWM0k8fRXOogtLKAjce/lDWYQm1fAUGLmq3ZWEJtZQE9i
	x/VfYDabgJLEnU/7wRZwCuhKHN/wDWwOi4CqxLyN+xlBFjALHGGUmHt7FztEs7bEsoWvoYZa
	SdxZcZURYvEORomdW6q7GDk4RAT0JX5OZoM4Wlbi9sH9TBMYBWchOWMWkjNmIZm6gJF5FaNs
	Sm6Vbm5iZk5xarJucXJiXl5qka65Xm5miV5qSukmRlAksLuo7GBsPqR0iFGAg1GJh9eJwcRf
	iDWxrLgy9xCjJAeTkijvsyhTfyG+pPyUyozE4oz4otKc1OJDjBIczEoivD1iQDnelMTKqtSi
	fJiUNAeLkjivhtY7PyGB9MSS1OzU1ILUIpisDAeHkgTva5ChgkWp6akVaZk5JQhpJg5OkOE8
	QMP3gtTwFhck5hZnpkPkTzHqcky6sO4CoxBLXn5eqpQ4722QIgGQoozSPLg5sAT2ilEc6C1h
	3t0gVTzA5Ac36RXQEiagJdLnTECWlCQipKQaGBV9Nx6t33LH9L124de2wGer/XwU0l6rM2yt
	akjM3b33g7GJaJ/tW+d0l765qprlZ7fze/TPW2Lb8/7Jdp/fT0yEXTZu0Xaznn9x 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190429>


On Feb 10, 2012, at 11:59 AM, Matthieu Moy wrote:
>=20
> Is it possible to have the static HTML uploaded from another machine,
> not necessarily for each push, but e.g. for every release?
>=20
> I don't think anyone cares about having the very latest documentation
> there, but it would still be great to have an official place to point=
 to
> when writing documentation on the web about such or such command.

I think that's a great idea.

I used to use that service quite a lot, so I'd be willing to push the t=
ar balls
to kernel.org, since I have PGP key set up for kernel.org uploads (so d=
o
other people, and if someone else wants to do it, I'm happy to let them=
 get
all the glory :-)   Most of the infrastructure to do this has been impl=
emented,
except for the part where the tar ball gets unpacked in the correct dir=
ectory.

This would satisfy the security concerns, and it wouldn't be hard, but =
it would
require some implementation work.   Anyone have some perl hacking time =
to
take a look at:=20

      git://git.kernel.org/pub/scm/utils/kup/kup.git

=85 and add a "UNPACK pathanme" to the kup-server file, and work with t=
he
sysadmins at kernel.org to get it reviewed and accepted?

-- Ted
