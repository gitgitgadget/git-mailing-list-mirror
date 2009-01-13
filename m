From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH 3/3] Adds a #!bash to the top of bash completions so
	that editors can recognize, it as a bash script. Also adds a few
	simple comments above commands that, take arguments. The comments
	are meant to remind editors of potential, problems that can occur
	when the script is sourced on systems with "set, -u."
Date: Tue, 13 Jan 2009 21:10:24 +0100
Message-ID: <20090113201024.GA20129@chistera.yi.org>
References: <496CBD17.3000207@tedpavlic.com> <20090113164518.GS10179@spearce.org> <200901131403.16012.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Ted Pavlic <ted@tedpavlic.com>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 21:12:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMpcD-0002jy-0u
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 21:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857AbZAMUKg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 15:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757813AbZAMUKe
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 15:10:34 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:2371
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757570AbZAMUKd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 15:10:33 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 90EEE801C015;
	Tue, 13 Jan 2009 21:10:28 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LMpai-0005FM-MU; Tue, 13 Jan 2009 21:10:24 +0100
Content-Disposition: inline
In-Reply-To: <200901131403.16012.bss@iguanasuicide.net>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105527>

* Boyd Stephen Smith Jr. [Tue, 13 Jan 2009 14:03:11 -0600]:

> On Tuesday 2009 January 13 10:45:18 Shawn O. Pearce wrote:
> >See [...] how the subject is a niceshort, one
> >line summary of the module impacted and the change?

> My rule for this is absolutely no more than 80 characters.

My rule for *all* of the commit message is "absolutely no more than 76
characters". With more than 76, `git log` wraps in a 80-column terminal=
=2E

Just my 2=C2=A2,

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
La m=C3=BAsica es de los que la quieren escuchar y de nadie m=C3=A1s.
                -- Andr=C3=A9s Calamaro
