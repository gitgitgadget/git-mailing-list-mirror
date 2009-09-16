From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: System wide gitattributes
Date: Wed, 16 Sep 2009 14:53:35 +0200
Message-ID: <vpqd45rm4og.fsf@bauges.imag.fr>
References: <4AB0D0EB.5080105@andrena.de>
	<f46c52560909160516w1d888a23yedd1fafae515bfbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?F=F6rster?= <david.foerster@andrena.de>,
	git@vger.kernel.org
To: Rustom Mody <rustompmody@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 14:56:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mnu47-0008CJ-9z
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 14:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758935AbZIPM4p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Sep 2009 08:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758386AbZIPM4p
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 08:56:45 -0400
Received: from imag.imag.fr ([129.88.30.1]:55662 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752891AbZIPM4o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 08:56:44 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n8GCrauE024821
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 16 Sep 2009 14:53:36 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Mnu0u-0004mm-0O; Wed, 16 Sep 2009 14:53:36 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Mnu0t-0005c4-VL; Wed, 16 Sep 2009 14:53:35 +0200
In-Reply-To: <f46c52560909160516w1d888a23yedd1fafae515bfbe@mail.gmail.com> (Rustom Mody's message of "Wed\, 16 Sep 2009 17\:46\:04 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 16 Sep 2009 14:53:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128649>

Rustom Mody <rustompmody@gmail.com> writes:

> 2009/9/16 David F=F6rster <david.foerster@andrena.de>:
>> Hi there,
>>
>> from the documentation I understand that things like external diff t=
ools can
>> be set up in a gitattributes file per repository (or subfolder).
>>
>> Why is there no support for a ~/.gitattributes file? This would be v=
ery
>> handy, for example to always get a textual diff of OpenDocument file=
s.
>>
>
> They are there; see
>
> http://www.kernel.org/pub/software/scm/git/docs/git-config.html#FILES

~/.gitconfig is there, but I don't see a ~/.gitattributes file
mentionned in this page ...

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
