From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH 4/4] Add support for 'namespace' history simplification
Date: Mon, 3 Nov 2008 23:28:48 +0100
Message-ID: <200811032328.48632.robin.rosenberg@dewire.com>
References: <200811031439.12111.brian.foster@innova-card.com> <alpine.LFD.2.00.0811031135410.3419@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811031139520.3419@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Foster <brian.foster@innova-card.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Nov 04 00:41:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx938-0001j9-IR
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 00:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756572AbYKCXjy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 18:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756508AbYKCXjy
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 18:39:54 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:55489 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753287AbYKCXjx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 18:39:53 -0500
X-Greylist: delayed 4193 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Nov 2008 18:39:53 EST
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB024985A7; Mon, 3 Nov 2008 23:28:52 +0100
User-Agent: KMail/1.10.1 (Linux/2.6.27-7-generic; KDE/4.1.2; i686; ; )
In-Reply-To: <alpine.LFD.2.00.0811031139520.3419@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100011>

m=E5ndag 03 november 2008 20:43:00 skrev Linus Torvalds:
>=20
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Mon, 3 Nov 2008 11:25:46 -0800
> Subject: [PATCH 4/4] Add support for 'namespace' history simplificati=
on
>=20
> Maybe this is mis-named, but what it does is to simplify history not =
by
> the contents of the tree, but whether a commit has been named (ie it'=
s
> referred to by some branch or tag) or not.

You could reuse the decoration term here, i.e. --simplify-decorated.

-- robin
