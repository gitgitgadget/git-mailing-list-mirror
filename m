From: Kay Sievers <kay.sievers@suse.de>
Subject: Re: [PATCH] gitweb: Remove gitweb/test/ directory
Date: Sun, 01 Jun 2008 11:42:41 +0200
Message-ID: <1212313361.2446.21.camel@linux.site>
References: <28EDBE43-6E55-4EC9-97C6-8AC8D949E82D@zib.de>
	 <5DBABAFE-C447-4E5D-A7E8-0C16B4D1D960@wincent.com>
	 <alpine.DEB.1.00.0806010018300.13507@racer.site.net>
	 <200806010219.16773.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>, git@vger.kernel.org,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 11:43:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2k6C-0003pE-TR
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 11:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbYFAJmn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Jun 2008 05:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbYFAJmn
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 05:42:43 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:36095 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752865AbYFAJmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 05:42:42 -0400
Received: from [192.168.178.24] ([149.44.162.75])
	by emea5-mh.id5.novell.com with ESMTP (TLS encrypted); Sun, 01 Jun 2008 11:42:39 +0200
In-Reply-To: <200806010219.16773.jnareb@gmail.com>
X-Mailer: Evolution 2.22.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83442>

On Sun, 2008-06-01 at 02:19 +0200, Jakub Narebski wrote:
> On Sun, 1 Jan 2008, Johannes Schindelin wrote:
> > On Sat, 31 May 2008, Wincent Colaiuta wrote:
> >> El 31/5/2008, a las 20:28, Jakub Narebski escribi=C3=B3:
> >>=20
> >>> Testing if gitweb handles filenames with spaces, filenames with p=
lus=20
> >>> sign ('+') which encodes spaces in CGI parameters (in URLs), and=20
> >>> filenames with Unicode characters should be handled by gitweb tes=
ts.
> >>>
> >>> Those files are remainder of the time when gitweb was project on =
its=20
> >>> own, not a part of git (with its testsuite).
> >>>
> >>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> >>=20
> >> Ack.
> >=20
> > And I thought "Ack" was reserved for the people who are considered =
the=20
> > primary authors of the patched code...
>=20
> Unfortunately, as far as I know, primary and only author of those
> lines of code, maintainer of gitweb when it was separate project,
> Kay Sievers, is no longer active in git development.

Sure, feel free to do whatever makes sense, there is no reason to get m=
y
ACK, as I'm not actively working on it anymore. I'm glad, you guys take
care of gitweb these days, and it has improved a lot since then.

Thanks,
Kay
