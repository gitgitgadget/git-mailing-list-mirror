From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git is exploding
Date: Tue, 01 Nov 2011 19:39:51 +0100
Message-ID: <vpqty6n1ybs.fsf@bauges.imag.fr>
References: <CAA787r=jeBv9moineaJVY=urYzEX+d7n23ED-txAGhLS+OPbmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?iso-8859-1?Q?=D8yvind?= A. Holm" <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 19:40:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLJFj-00031o-RP
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 19:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754825Ab1KASj7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 14:39:59 -0400
Received: from mx1.imag.fr ([129.88.30.5]:34705 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260Ab1KASj6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 14:39:58 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id pA1Ia5MC024605
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Nov 2011 19:36:05 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RLJFX-00016w-Az; Tue, 01 Nov 2011 19:39:51 +0100
In-Reply-To: <CAA787r=jeBv9moineaJVY=urYzEX+d7n23ED-txAGhLS+OPbmg@mail.gmail.com>
	(=?iso-8859-1?Q?=22=D8yvind?= A. Holm"'s message of "Sat, 29 Oct 2011
 02:39:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 01 Nov 2011 19:36:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: pA1Ia5MC024605
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1320777369.96822@0jWAc2zLY1ZzuXl6zdQE0Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184580>

=D8yvind A. Holm <sunny@sunbase.org> writes:

> Found an interesting "Popularity Contest" graph on debian.org (via
> Thomas Bassetto on G+):
>
> http://bit.ly/rNxVN0

Here are a few other interesting metrics:

http://www.ohloh.net/repositories/compare
=3D> around 1/4 of the repositories found are Git repositories. Subvers=
ion
has a bit more than half, and the last 1/4 is essentially CVS.

http://www.ohloh.net/p/compare?project_0=3DGit&project_1=3DSubversion&p=
roject_2=3Dmercurial&submit_2=3DGo
=3D> Git has 2,659 users on ohloh, Subversion has 7,667 and Mercurial h=
as
795.

=46rom those numbers, centralized VCS are still dominant, but Git reall=
y
emerges among DVCS, and is not that far behind.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
