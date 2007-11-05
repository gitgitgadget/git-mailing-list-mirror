From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [StGit PATCH] Cogito is deprecated, so don't point to it
Date: Mon, 05 Nov 2007 10:57:17 +0100
Message-ID: <vpqejf510ci.fsf@bauges.imag.fr>
References: <20071105030608.6033.35208.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 10:58:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoyjA-0001PJ-Jc
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 10:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbXKEJ6V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 04:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbXKEJ6V
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 04:58:21 -0500
Received: from imag.imag.fr ([129.88.30.1]:40895 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbXKEJ6U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 04:58:20 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lA59vcpR016229
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 5 Nov 2007 10:57:38 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ioyhp-0002n2-F2; Mon, 05 Nov 2007 10:57:17 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Ioyhp-0004oO-CW; Mon, 05 Nov 2007 10:57:17 +0100
In-Reply-To: <20071105030608.6033.35208.stgit@yoghurt> ("Karl
 =?iso-8859-1?Q?Hasselstr=F6m=22's?= message of "Mon\, 05 Nov 2007
 04\:07\:57 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 05 Nov 2007 10:57:39 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63492>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> -directly). For standard SCM operations, either use plain GIT command=
s
> -or the Cogito tool but it is not recommended to mix them with the
> -StGIT commands.
> +directly). For standard SCM operations, use plain GIT commands.

Doesn't the "but it is not recommended to mix them with the StGIT
commands." part still hold?

--=20
Matthieu
