From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 22:33:49 +0100
Message-ID: <vpq63zxq5s2.fsf@bauges.imag.fr>
References: <1195477504.8093.15.camel@localhost>
	<8c5c35580711190845s71a4880ek4ab28170d277e0e6@mail.gmail.com>
	<E983072E-E9FD-499E-A418-B630A275C4F3@lrde.epita.fr>
	<8c5c35580711190904v5975e81k3d515dc44fee9c21@mail.gmail.com>
	<25CF3422-A236-46CE-B243-3F01117B7743@lrde.epita.fr>
	<vpqtznirtlk.fsf@bauges.imag.fr>
	<60891A14-1D6E-4114-ACEF-4C981D326CFA@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	"Jonas Juselius" <jonas.juselius@chem.uit.no>, git@vger.kernel.org
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Nov 19 22:34:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuEGV-0005x3-3X
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 22:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbXKSVe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 16:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbXKSVe2
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 16:34:28 -0500
Received: from imag.imag.fr ([129.88.30.1]:43741 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbXKSVe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 16:34:27 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lAJLXpom006849
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 19 Nov 2007 22:33:51 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IuEFZ-0003ac-Jc; Mon, 19 Nov 2007 22:33:49 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IuEFZ-0005Na-HC; Mon, 19 Nov 2007 22:33:49 +0100
In-Reply-To: <60891A14-1D6E-4114-ACEF-4C981D326CFA@lrde.epita.fr> (Benoit Sigoure's message of "Mon\, 19 Nov 2007 22\:15\:21 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 19 Nov 2007 22:33:51 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65503>

Benoit Sigoure <tsuna@lrde.epita.fr> writes:

> No please stop adding links from on man page to another.  If you read
> man git-reflog, you surely want to learn the HEAD@{N} syntax and see
> practical uses cases.

I don't understand your point.

Yes, if I read man git-reflog, I do surely want to learn HEAD@{N}
syntax, but that is _precisely_ what my patch does.

-- 
Matthieu
