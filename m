From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Modern Git GUI
Date: Sun, 24 Jan 2010 10:50:19 +0100
Message-ID: <vpq636resro.fsf@bauges.imag.fr>
References: <e39c1dcf1001231340p67448584pfdbc453cc8fb9ca7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Andr=E9?= Harms <andre.harms@kuhlsolutions.de>
X-From: git-owner@vger.kernel.org Sun Jan 24 10:54:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYzAc-0006iB-4m
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 10:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab0AXJxq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Jan 2010 04:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169Ab0AXJxp
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 04:53:45 -0500
Received: from imag.imag.fr ([129.88.30.1]:35712 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554Ab0AXJxo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 04:53:44 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o0O9oJkx028557
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 24 Jan 2010 10:50:19 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NYz6p-0005Sy-J7; Sun, 24 Jan 2010 10:50:19 +0100
In-Reply-To: <e39c1dcf1001231340p67448584pfdbc453cc8fb9ca7@mail.gmail.com>
 (=?iso-8859-1?Q?=22Andr=E9?= Harms"'s message of "Sat\, 23 Jan 2010
 22\:40\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.90 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 24 Jan 2010 10:50:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137887>

Andr=E9 Harms <andre.harms@kuhlsolutions.de> writes:

> So I thought about developing a new kind of GUI for Git that looks
> modern and attractive

Every once in a while, someone comes and says "Git GUIs aren't as good
as I'd expect, I'll write my own". The result is that we have a myriad
of GUIs (see
http://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools#Graphi=
cal_Interfaces ),
many of them being half-finished and/or abandonned. I don't believe
adding yet-another-one is going to improve the situation, and
pick-one-and-improve-it is IMHO a much better approach.

> (you know... some eye-candy stuff) and that is easy to use.

I use mostly the command-line, so I couldn't make a detailed review of
the existing, but tools like git-cola and a few others sound "modern"
to me (Qt4 & co).

If you decide to go on with your project, either you want to carry it
out alone, or you'll have to convince other developers to join. In the
second case, a good starting point would be to explain why the other
GUI are not good enough, and why you can't just contribute to them.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
