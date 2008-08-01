From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Merging submodules
Date: Fri, 1 Aug 2008 09:04:22 +0200
Message-ID: <20080801090422.55c6a45f@pc09.procura.nl>
References: <20080730230336.GA6481@Hermes>
	<20080731092104.1a6ce8bd@pc09.procura.nl>
	<20080731143955.034f0577@pc09.procura.nl>
	<20080731130626.GQ32184@machine.or.cz>
	<20080731170123.79e0d3e9@pc09.procura.nl>
	<8aa486160807310824h25c9630dxc25b156e80fcdb29@mail.gmail.com>
	<20080731201530.067be667@pc09.procura.nl>
	<8aa486160807311203o3fb4deb8u4a5ae57818c76fab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Petr Baudis" <pasky@suse.cz>,
	"Brian Gernhardt" <benji@silverinsanity.com>,
	"Git List" <git@vger.kernel.org>,
	"Lars Noschinski" <lars-2008-1@usenet.noschinski.de>
To: "Santi =?UTF-8?B?QsOpamFy?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 09:06:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOoi3-0002JI-V1
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 09:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbYHAHEg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2008 03:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757487AbYHAHEf
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 03:04:35 -0400
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:1672 "EHLO
	smtp-vbr3.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056AbYHAHEe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 03:04:34 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id m7174NqT085647
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 09:04:23 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <8aa486160807311203o3fb4deb8u4a5ae57818c76fab@mail.gmail.com>
X-Mailer: Claws Mail 3.5.0cvs35 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91032>

On Thu, 31 Jul 2008 21:03:26 +0200, "Santi B=C3=A9jar" <sbejar@gmail.co=
m>
wrote:

> On Thu, Jul 31, 2008 at 20:15, H.Merijn Brand <h.m.brand@xs4all.nl> w=
rote:
> > On Thu, 31 Jul 2008 17:24:40 +0200, "Santi B=C3=A9jar" <sbejar@gmai=
l.com> wrote:
> >
> >> I see all OK. Can you provide a self consistent simple testcase th=
at
> >> shows what is wrong?
> >
> > Yes. was rather easy.
> > http://www.xs4all.nl/~hmbrand/testcase.tgz
>=20
> It is because you cannot merge a branch with an empty branch. So, or
> you create an initial commit in the "superproject"  or you create a
> commit just moving the files of the first module as in:
>=20
> http://article.gmane.org/gmane.comp.version-control.git/79887

Almost perfect now.

4gl/new 121 > git-ls-files | grep fnc_declare
include/fnc_declare.h
4gl/new 122 > git-show d971ec91a3dbc9f1f27a96e4f9b95366babd036c
commit d971ec91a3dbc9f1f27a96e4f9b95366babd036c
Author: H.M. Brand <merijn@a5.(none)>
Date:   Tue Jul 29 16:45:43 2008 +0200

    Backward comp functie voor PV indicatie

diff --git a/fnc_declare.h b/fnc_declare.h
index acd686c..25d9a73 100644
--- a/fnc_declare.h
+++ b/fnc_declare.h
@@ -136,6 +136,11 @@ eaf_N Indicaties    ($x1);
 eaf_N pv_datum      ($x1, $x2, $x3);
 #endif

+#ifndef PV_INDICATIE
+#define PV_INDICATIE
+eaf_S pv_indicatie  ($x1);
+#endif
+
 #undef eaf_B
 #undef eaf_N
 #undef eaf_S
4gl/new 123 >

all the diffs are still showing as if they were against the folder they
were originally committed in. Is that correct? I would now have expecte=
d
something like

commit d971ec91a3dbc9f1f27a96e4f9b95366babd036c
Author: H.M. Brand <merijn@a5.(none)>
Date:   Tue Jul 29 16:45:43 2008 +0200

    Backward comp functie voor PV indicatie

diff --git a/include/fnc_declare.h b/include/fnc_declare.h
index acd686c..25d9a73 100644
--- a/include/fnc_declare.h
+++ b/include/fnc_declare.h
@@ -136,6 +136,11 @@ eaf_N Indicaties    ($x1);
 eaf_N pv_datum      ($x1, $x2, $x3);
 #endif

+#ifndef PV_INDICATIE
+#define PV_INDICATIE
+eaf_S pv_indicatie  ($x1);
+#endif
+
 #undef eaf_B
 #undef eaf_N
 #undef eaf_S

--=20
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org=
/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00=
,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin=
=2E
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org=
/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers=
/
