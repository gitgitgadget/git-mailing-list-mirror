From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v3] completion: remote set-* <name> and <branch>
Date: Wed, 22 Feb 2012 10:52:43 +0100
Message-ID: <87vcmz2o0k.fsf@thomas.inf.ethz.ch>
References: <20120222001737.GB2228@goldbirke>
	<1329901093-24106-1-git-send-email-philip@foolip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Philip =?utf-8?Q?J=C3=A4genstedt?= <philip@foolip.org>
X-From: git-owner@vger.kernel.org Wed Feb 22 10:53:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S08sW-0004rw-Pl
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 10:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab2BVJws convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 04:52:48 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:40091 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613Ab2BVJwr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 04:52:47 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 22 Feb
 2012 10:52:43 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 22 Feb
 2012 10:52:44 +0100
In-Reply-To: <1329901093-24106-1-git-send-email-philip@foolip.org> ("Philip
	=?utf-8?Q?J=C3=A4genstedt=22's?= message of "Wed, 22 Feb 2012 09:58:09
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191242>

Philip J=C3=A4genstedt <philip@foolip.org> writes:

> Hope this works better. Is it possible to use format-patch or send-em=
ail=20
> to get subjects like [PATCH 1/4 v3], as opposed to what I am sending?

'git format-patch --subject-prefix=3D"PATCH v3"' gives you [PATCH v3 1/=
4]
which I think is what everyone does around here...

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
