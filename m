From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] create a skeleton for the command git rebase --status
Date: Thu, 28 May 2015 15:06:34 +0200
Message-ID: <vpqlhg8onqd.fsf@anie.imag.fr>
References: <1432814891-4717-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Guillaume =?iso-8859-1?Q?Pag=E8s?= 
	<guillaume.pages@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 15:06:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxxWH-0006bV-0g
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 15:06:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbbE1NGk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2015 09:06:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56406 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753675AbbE1NGj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 09:06:39 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SD6Wlm028929
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 15:06:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SD6Y8w010029;
	Thu, 28 May 2015 15:06:34 +0200
In-Reply-To: <1432814891-4717-1-git-send-email-guillaume.pages@ensimag.grenoble-inp.fr>
	("Guillaume \=\?iso-8859-1\?Q\?Pag\=E8s\=22's\?\= message of "Thu, 28 May 2015
 14:08:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 May 2015 15:06:33 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SD6Wlm028929
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433423194.20156@n37lpTUfv6oreH/9i76d+g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270146>

Guillaume Pag=E8s <guillaume.pages@ensimag.grenoble-inp.fr> writes:

> It is an almost empty code I send to validate the global architecture
> of this command.

One more note: I know what "git rebase --status" is about because I'm
the one who suggested it and I read your previous message, but not
everybody is me, and most people would appreciate a brief explanation o=
f
what "git rebase --status" is before knowing how you're starting the
work.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
