From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH resend] git-pull: fix fetch-options.txt to not document  --quiet and --verbose twice in git-pull.txt
Date: Tue, 08 Sep 2009 08:26:14 +0200
Message-ID: <vpqd462kl4p.fsf@bauges.imag.fr>
References: <9f50533b0909070534q2375a793mf5d676b519eae69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 08:27:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkuAW-00030v-TE
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 08:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753467AbZIHG0T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Sep 2009 02:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbZIHG0T
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 02:26:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:49588 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753299AbZIHG0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 02:26:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n886NpIw008669
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 8 Sep 2009 08:23:51 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mku9e-0004Ul-S9; Tue, 08 Sep 2009 08:26:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mku9e-00079i-Qq; Tue, 08 Sep 2009 08:26:14 +0200
In-Reply-To: <9f50533b0909070534q2375a793mf5d676b519eae69@mail.gmail.com> (Emmanuel Trillaud's message of "Mon\, 7 Sep 2009 14\:34\:35 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 08 Sep 2009 08:23:51 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n886NpIw008669
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1252995833.30302@LSpEz+NVAXIKrKQaCY41Tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127971>

Emmanuel Trillaud <etrillaud@gmail.com> writes:

> Hello all,
> In git-pull(1) we can read :

[...]

> Best regard

I guess this part of your message is not meant to appear in the commit
message. If you leave it here, Junio will have to edit it manually,
whereas if you put it where Documentation/SubmitingPatches suggests,
i.e.

> ---

here (between --- and diffstat), it's done automatically. Be nice to
our maintainer, and our mainainer will be nice to you ;-).

> Documentation/fetch-options.txt | =A0 =A02 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
