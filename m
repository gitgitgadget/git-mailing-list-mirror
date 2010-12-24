From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bug reports & patches: git-svn, git-completion, git diff hunk headers for Pascal
Date: Fri, 24 Dec 2010 15:10:37 +0100
Message-ID: <vpq1v575kiq.fsf@bauges.imag.fr>
References: <6110634424.20101224154626@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0JrRgNC10LfQvtCy?= <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Fri Dec 24 15:13:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW8Oh-0000nt-8y
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 15:13:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab0LXON0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Dec 2010 09:13:26 -0500
Received: from imag.imag.fr ([129.88.30.1]:57647 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752161Ab0LXONZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Dec 2010 09:13:25 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id oBOEAbgT000567
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 24 Dec 2010 15:10:37 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PW8Lt-0005iN-Ee; Fri, 24 Dec 2010 15:10:37 +0100
In-Reply-To: <6110634424.20101224154626@mail.ru> (=?utf-8?B?ItCQ0LvQtdC6?=
 =?utf-8?B?0YHQtdC5INCa0YDQtdC30L7QsiIncw==?= message of "Fri\, 24 Dec 2010
 15\:46\:26 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 24 Dec 2010 15:10:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164160>

=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9 =D0=9A=D1=80=D0=B5=D0=B7=D0=BE=
=D0=B2 <zapped@mail.ru> writes:

> Hello!

Hi,

> I've found some bugs in Git:

Thanks for your interest and your patches, but please read
Documentation/SubmittingPatches in th git sources. In particular:

* Patches cannot be included without your signoff.

* Please send the patches inline, together with the commit message, so
  that review is easy, and that our maintener can easily apply it.
  Doing local commits, and using git send-email will make it easy.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
