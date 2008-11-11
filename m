From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Install issues
Date: Wed, 12 Nov 2008 00:53:03 +0100
Message-ID: <20081112005303.5ab54c0e@pc09.procura.nl>
References: <20081110121739.15f77a01@pc09.procura.nl>
	<20081110113924.GR24201@genesis.frugalware.org>
	<20081110173101.3d76613b@pc09.procura.nl>
	<20081110175123.GV24201@genesis.frugalware.org>
	<7vhc6e17fv.fsf@gitster.siamese.dyndns.org>
	<20081111190243.7044d6cb@pc09.procura.nl>
	<alpine.LNX.2.00.0811111554530.19159@suse104.zenez.com>
	<20081112003547.38081e09@pc09.procura.nl>
	<7vzlk5x21p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Boyd Lynn Gerber <gerberb@zenez.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 00:54:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L034C-0008Pd-UI
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 00:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007AbYKKXx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 18:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYKKXx0
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 18:53:26 -0500
Received: from smtp-vbr13.xs4all.nl ([194.109.24.33]:1959 "EHLO
	smtp-vbr13.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbYKKXxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 18:53:25 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr13.xs4all.nl (8.13.8/8.13.8) with ESMTP id mABNr4cY024731
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 12 Nov 2008 00:53:05 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7vzlk5x21p.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.6.1cvs12 (GTK+ 2.12.0; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100697>

On Tue, 11 Nov 2008 15:42:26 -0800, Junio C Hamano <gitster@pobox.com>
wrote:

> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 
> > On Tue, 11 Nov 2008 16:03:50 -0700, Boyd Lynn Gerber <gerberb@zenez.com> wrote:
> >
> >> Here is a check list I use to make sure my patches are OK.
> >> 
> >> http://repo.or.cz/w/git.git?a=blob_plain;f=Documentation/SubmittingPatches;hb=HEAD
> >> ...
> >> > I'm by now way offended or scared away if you reject these kind of
> >              ^
> > /me meant "no" where he wrote "now" :( :(
> > I can imagine people interpreting that sentence very very wrong.
> 
> That is not even "interpretation".  You _literally_ wrote the exact
> opposite of what you meant ;-).

I'm really really sorry. That must have sounded harsh.

-- 
H.Merijn Brand          Amsterdam Perl Mongers  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, SuSE 10.1, 10.2, and 10.3, AIX 5.2, and Cygwin.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
