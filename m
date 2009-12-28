From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Allow git to use any HTTP authentication method.
Date: Mon, 28 Dec 2009 13:37:40 +0100
Message-ID: <vpqeimf9svf.fsf@bauges.imag.fr>
References: <200912281154.09442.lenaic@lhuard.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?L=E9na=EFc?= Huard <lenaic@lhuard.fr.eu.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 13:38:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPErG-0007ur-Bt
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 13:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbZL1Mhy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Dec 2009 07:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbZL1Mhy
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 07:37:54 -0500
Received: from mx2.imag.fr ([129.88.30.17]:37131 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbZL1Mhx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 07:37:53 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id nBSCalIl018873
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Dec 2009 13:36:47 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NPEqy-0004uI-D3; Mon, 28 Dec 2009 13:37:40 +0100
In-Reply-To: <200912281154.09442.lenaic@lhuard.fr.eu.org>
 (=?iso-8859-1?Q?=22L=E9na=EFc?= Huard"'s message of "Mon\, 28 Dec 2009
 11\:54\:06 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 28 Dec 2009 13:36:47 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: nBSCalIl018873
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1262608608.03244@bRDDAIJ3R/IMSd5i9YCp8g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135738>

L=E9na=EFc Huard <lenaic@lhuard.fr.eu.org> writes:

> The attached patch makes git configure libcurl to negotiate the most =
suitable=20
> HTTP authentication method.

Thanks for your contribution.

Read other people's reply about the need for this patch.

Other than that, please read git/Documentation/SubmittingPatches in
Git's source code. In short: inline patches, don't attach them, and
use Signed-Off-By to acknowledge that your patch can be legally
included in Git's official version.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
