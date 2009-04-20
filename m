From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Oldest supported Perl version
Date: Tue, 21 Apr 2009 00:56:17 +0200
Message-ID: <20090421005617.0ded1ff4@pc09.procura.nl>
References: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
	<m3eivnp5p4.fsf@localhost.localdomain>
	<20090420231035.683a7e0f@pc09.procura.nl>
	<b4087cc50904201538w6a09d9e9wfdcd103737f04507@mail.gmail.com>
	<b4087cc50904201539m7ee6feb5vfb944e8ec50b1ddc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 00:58:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw2RK-0003oG-9X
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 00:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757422AbZDTW4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 18:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756425AbZDTW4V
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 18:56:21 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:3607 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757182AbZDTW4V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 18:56:21 -0400
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id n3KMuIDL039869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 21 Apr 2009 00:56:18 +0200 (CEST)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <b4087cc50904201539m7ee6feb5vfb944e8ec50b1ddc@mail.gmail.com>
X-Mailer: Claws Mail 3.7.1cvs44 (GTK+ 2.14.4; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117046>

On Mon, 20 Apr 2009 17:39:34 -0500, Michael Witten <mfwitten@gmail.com>
wrote:

> On Mon, Apr 20, 2009 at 17:38, Michael Witten <mfwitten@gmail.com> wrote:
> > On Mon, Apr 20, 2009 at 16:10, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> >> 5.8.1 is the worst distribution ever.
> >
> > But then you endorse 5.6.1?
> 
> That is:
> 
> But then you endorse 5.6.1 if 5.8.5 is not chosen.

5.6.1 and 5.6.2 are fine for non-Unicode environments.

When using Unicode (utf-8) and/or 64bit, I'd strongly advise not to go
below 5.8.5

-- 
H.Merijn Brand  http://tux.nl      Perl Monger  http://amsterdam.pm.org/
using & porting perl 5.6.2, 5.8.x, 5.10.x, 5.11.x on HP-UX 10.20, 11.00,
11.11, 11.23, and 11.31, OpenSuSE 10.3, 11.0, and 11.1, AIX 5.2 and 5.3.
http://mirrors.develooper.com/hpux/           http://www.test-smoke.org/
http://qa.perl.org      http://www.goldmark.org/jeff/stupid-disclaimers/
