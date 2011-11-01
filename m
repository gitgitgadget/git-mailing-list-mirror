From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git is exploding
Date: Tue, 01 Nov 2011 11:08:49 +0100
Message-ID: <vpqfwi8tary.fsf@bauges.imag.fr>
References: <CAA787r=jeBv9moineaJVY=urYzEX+d7n23ED-txAGhLS+OPbmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?iso-8859-1?Q?=D8yvind?= A. Holm" <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Tue Nov 01 11:09:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLBHM-0002PX-DS
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 11:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab1KAKIz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 06:08:55 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40194 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752952Ab1KAKIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 06:08:54 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id pA1A4luq002584
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Nov 2011 11:04:47 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1RLBGz-00027E-8Y; Tue, 01 Nov 2011 11:08:49 +0100
In-Reply-To: <CAA787r=jeBv9moineaJVY=urYzEX+d7n23ED-txAGhLS+OPbmg@mail.gmail.com>
	(=?iso-8859-1?Q?=22=D8yvind?= A. Holm"'s message of "Sat, 29 Oct 2011
 02:39:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 01 Nov 2011 11:04:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: pA1A4luq002584
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1320746689.8767@8Jp08UpebCGhpGnsFwTR5g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184564>

=D8yvind A. Holm <sunny@sunbase.org> writes:

> Found an interesting "Popularity Contest" graph on debian.org (via
> Thomas Bassetto on G+):
>
> http://bit.ly/rNxVN0
>
> Very cool indeed.

The recent rise is essentially due to the git-core package renamed to
git, and people doing updates:

http://qa.debian.org/popcon-graph.php?packages=3Dgit%2C+git-core&show_v=
ote=3Don&want_legend=3Don&want_ticks=3Don&from_date=3D&to_date=3D&hlght=
_date=3D&date_fmt=3D%25Y-%25m&beenhere=3D1

Still, Git is now more popular than SVN for Debian users accepting the
popcon data gathering.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
