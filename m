From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Usability question
Date: Thu, 17 Sep 2009 15:09:25 +0200
Message-ID: <vpqiqfhbtve.fsf@bauges.imag.fr>
References: <513ca40e0909170301s2b09184akb27acde76975c09b@mail.gmail.com>
	<vpqy6odhn0d.fsf@bauges.imag.fr> <20090917121328.GA21837@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rob Barrett <barrettboy@gmail.com>, git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:09:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoGkC-0004yf-CK
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 15:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758658AbZIQNJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 09:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753532AbZIQNJk
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 09:09:40 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39072 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758562AbZIQNJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 09:09:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id n8HD6YMO010440
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 17 Sep 2009 15:06:34 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MoGjl-0004qq-7A; Thu, 17 Sep 2009 15:09:25 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MoGjl-0000d4-5i; Thu, 17 Sep 2009 15:09:25 +0200
In-Reply-To: <20090917121328.GA21837@neumann> ("SZEDER =?iso-8859-1?Q?G=E1?=
 =?iso-8859-1?Q?bor=22's?= message of "Thu\, 17 Sep 2009 14\:13\:28 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 17 Sep 2009 15:06:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: n8HD6YMO010440
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1253797595.28594@HVFoZxQxBJE0bfLP4DgUQA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128752>

SZEDER G=E1bor <szeder@ira.uka.de> writes:

> I tend to aggree, but what about 'git rebase --abort' vs. 'git rebase
> --continue'?  IMHO they are also doing something totally different.

If I were to rewrite it, I'd call them "git rebase abort" without
dashes. Not sure renaming them to subcommands is worth it though.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
