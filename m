From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [RFC PATCH] Make the rebase edit mode really end up in an edit
	state
Date: Thu, 15 Jan 2009 13:44:33 +0100
Message-ID: <20090115124433.GA4484@chistera.yi.org>
References: <87ab9th0rh.fsf@cup.kalibalik.dk> <alpine.DEB.1.00.0901150149130.3586@pacific.mpi-cbg.de> <496EE74F.6000205@viscovery.net> <200901151101.53441.johan@herland.net> <bd6139dc0901150352t2d2fa388x3eb842bbc8c4baa6@mail.gmail.com> <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 13:46:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNRc0-0000Ye-EE
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 13:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361AbZAOMoh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Jan 2009 07:44:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754205AbZAOMoh
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 07:44:37 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:3515
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758066AbZAOMog (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 07:44:36 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 6C8F5801C0EA;
	Thu, 15 Jan 2009 13:44:34 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LNRaL-0001Ar-FN; Thu, 15 Jan 2009 13:44:33 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901151325310.3586@pacific.mpi-cbg.de>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105785>

* Johannes Schindelin [Thu, 15 Jan 2009 13:36:10 +0100]:

> However, for the same reason (is it intuitive?) I am not fully convin=
ced=20
> of 'amend' either.  Because --amend _can_ mean that you change the=20
> diff of the commit.

Right.

> Maybe 'correct', 'redact' or 'rephrase'?

editmsg?

--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
He who has not a good memory should never take upon himself the trade o=
f lying.
                -- Michel de Montaigne
