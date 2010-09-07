From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: diff problem
Date: Tue, 07 Sep 2010 13:06:22 +0200
Message-ID: <vpq62yhrexd.fsf@bauges.imag.fr>
References: <loom.20100907T124704-885@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Zolt=E1nF=FCzesi?= <zfuzesi@eaglet.hu>
X-From: git-owner@vger.kernel.org Tue Sep 07 13:09:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osw3j-0004nF-Ms
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 13:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753610Ab0IGLJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 07:09:46 -0400
Received: from imag.imag.fr ([129.88.30.1]:63171 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756447Ab0IGLJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 07:09:45 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o87B6MBO002175
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 7 Sep 2010 13:06:22 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Osw0M-0000wR-9c; Tue, 07 Sep 2010 13:06:22 +0200
In-Reply-To: <loom.20100907T124704-885@post.gmane.org> (=?iso-8859-1?Q?=22?=
 =?iso-8859-1?Q?Zolt=E1nF=FCzesi=22's?= message of "Tue\, 7 Sep 2010
 10\:54\:12 +0000 \(UTC\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Tue, 07 Sep 2010 13:06:22 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155697>

Zolt=E1nF=FCzesi <zfuzesi@eaglet.hu> writes:

> Hi, git 1.7.3.rc0 (64 bit on Windows 7) diff shows no difference betw=
een my=20
> rebased topic branch and the its original state. Earlier it did.

Are you sure the rebase actually based your branch on a different
commit? (i.e. does "git diff where-your-branch-used-to-start
where-it-now-starts" show something?)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
