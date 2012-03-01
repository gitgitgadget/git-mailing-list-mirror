From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of Pull Requests
Date: Thu, 1 Mar 2012 12:29:31 +0100
Message-ID: <8762eoimp0.fsf@thomas.inf.ethz.ch>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
	<7vhay9tqs6.fsf@alter.siamese.dyndns.org>
	<20120229225304.GA9099@burratino>
	<CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	opticyclic <opticyclic@gmail.com>, <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 12:29:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S34Cb-0000cL-Bs
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 12:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758149Ab2CAL3f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 06:29:35 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:11387 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754046Ab2CAL3e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 06:29:34 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 12:29:30 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 12:29:31 +0100
In-Reply-To: <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
	(Andrew Ardill's message of "Thu, 1 Mar 2012 10:58:56 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191916>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> I have set up a JIRA instance using Atlassian's OnDemand service,
> available at https://git-scm.atlassian.net/
[...]
> As I see it (and Junio has mentioned before) we are going to need
> people who are able to manage the issues in this system

Note that you are not the first one to try.  The most elaborate plan an=
d
writeup that I know of sits at

  http://article.gmane.org/gmane.comp.version-control.git/136500  [1]

Jan "jast" Kr=C3=BCger also mentioned server issues today, so *.jk.gs i=
s
presumably down because of that, not because gitbugs.jk.gs is no longer
valid.

Nevertheless, AFAIK it has never been used for "real work", so you may
want to look into why that happened, and do something different.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
