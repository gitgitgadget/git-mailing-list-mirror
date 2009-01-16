From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
	state
Date: Fri, 16 Jan 2009 14:27:14 +0100
Message-ID: <20090116132714.GN9794@neumann>
References: <87ab9th0rh.fsf@cup.kalibalik.dk>
	<200901161050.13971.johan@herland.net>
	<49548.bFoQE3daRhY=.1232101666.squirrel@webmail.hotelhot.dk>
	<200901161158.06828.johan@herland.net>
	<20090116124239.GA28870@neumann>
	<alpine.DEB.1.00.0901161357230.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	Johan Herland <johan@herland.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 14:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNokl-00038T-CN
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 14:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbZAPN1R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Jan 2009 08:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759665AbZAPN1R
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 08:27:17 -0500
Received: from francis.fzi.de ([141.21.7.5]:36027 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754175AbZAPN1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 08:27:16 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 16 Jan 2009 14:27:14 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901161357230.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 16 Jan 2009 13:27:14.0268 (UTC) FILETIME=[24EC49C0:01C977DE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105958>

On Fri, Jan 16, 2009 at 01:57:57PM +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 16 Jan 2009, SZEDER G=E1bor wrote:
>=20
> > On Fri, Jan 16, 2009 at 11:58:06AM +0100, Johan Herland wrote:
> >=20
> > > "rephrase"?
> >=20
> > This is the first one that I found acceptable.
>=20
> I assume you missed=20
> http://article.gmane.org/gmane.comp.version-control.git/105783 in all=
 that=20
> bikeshedding?

Yes, I indeed missed that.  And still think that 'rephrase' is best
among all the suggestions for this "edit just the commit message"
thing.  ('editmsg' conflicts; 'amend', 'modify', and  'correct' are
not obvious enough (they don't clearly indicate what will be
modified); and I'm not sure about 'redact', but I don't really like it
because I had to look it up in the dictionary first).

Best,
G=E1bor
