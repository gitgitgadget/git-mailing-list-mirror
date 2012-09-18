From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Can git pull from a mercurial repository?
Date: Tue, 18 Sep 2012 14:40:13 +0200
Message-ID: <000901cd959a$c0fcaf20$42f60d60$@schmitz-digital.de>
References: <k39lir$gpm$1@ger.gmane.org> <505863B2.9020805@unixsol.org>	<000801cd9596$885ad6a0$991083e0$@schmitz-digital.de> <m2txuvik7g.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Georgi Chorbadzhiyski'" <gf@unixsol.org>, <git@vger.kernel.org>
To: "'Andreas Schwab'" <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 14:41:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDx6w-0001m5-57
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 14:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627Ab2IRMkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 08:40:35 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:52061 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932091Ab2IRMke (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 08:40:34 -0400
Received: from DualCore (dsdf-4d0a151d.pool.mediaWays.net [77.10.21.29])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0MVWV0-1T06vi1X4A-00Z8XS; Tue, 18 Sep 2012 14:40:29 +0200
In-Reply-To: <m2txuvik7g.fsf@igel.home>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGhEpNGyEwugTaQMUDb1fc5WliObQMi60yrASfiBRYCd5UCv5ey/GvQ
Content-Language: de
X-Provags-ID: V02:K0:hNEroEIeyXSmfPeV8omCv5+iB2JNk52cSiy3zbYvsxv
 2BcPwVdRfxaOB1Z3JIxa66wb2/OKeRDvdIXJfUTQ0rWWZV1YHv
 VcoaK4gXpqCag5bouQyA18ZFfU6wiNqfmC/w4J8pj1ks5Jm6nP
 uXT5naYvZ0WqUWJ01P5obZqnMWMn4UpFgTokkvzOt823N1izLU
 ERFdyT+iqNmvEpish2z+niEscF4UIFKieymxVIoqKo2k2RW0nW
 FMrgMFVpDKE9zLilx7xGlIt1+N/2ngD0NT3Dj3LJNzKe8jmnZ8
 0EFp0m/q1v0E5PDxekMKXkCBTtrznoTxqbh8A9daFcqx6VQ9HF
 QbOOvL1W2fXAj4CfJsCuXkVdXJdPFsSrAYbx+MLVWRNrklNL/e
 yARSt2fOAh9jQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205828>

> From: Andreas Schwab [mailto:schwab@linux-m68k.org]
> Sent: Tuesday, September 18, 2012 2:34 PM
> To: Joachim Schmitz
> Cc: 'Georgi Chorbadzhiyski'; git@vger.kernel.org
> Subject: Re: Can git pull from a mercurial repository?
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > Thanks, but that requires Mercurial to be available, installed and in PATH.
> > I want to use git exactly because I don't have Mercurial (yet?)
> 
> That doesn't make sense.  If one wants to access a mercurial repository
> the best way to do that is to use the facilities provided by mercurial.

Not if you don't have Mercurial to begin with.
Git can access cvs and svn repos, right? And without having cvs/scv on the machine...
