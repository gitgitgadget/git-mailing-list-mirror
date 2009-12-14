From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: strange error while pushing
Date: Mon, 14 Dec 2009 12:33:28 +0100
Message-ID: <fabb9a1e0912140333m5b13f6beke5010eea9f77df84@mail.gmail.com>
References: <40aa078e0912131441i370d9c23r65c42fe1f46bd194@mail.gmail.com> 
	<20091213230214.GA27365@sigill.intra.peff.net> <40aa078e0912131508y79815bej6290c0848aa9f9cf@mail.gmail.com> 
	<fabb9a1e0912131601q71dcb4c4h2fafa03df14be3c1@mail.gmail.com> 
	<alpine.DEB.1.00.0912141235090.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 14 12:33:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NK9Ba-000687-Op
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 12:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbZLNLdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 06:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbZLNLdt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 06:33:49 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:37434 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793AbZLNLdt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 06:33:49 -0500
Received: by vws30 with SMTP id 30so599937vws.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 03:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Ziu+ui88v7T7cLpql2XU4e5LVKmj9qrSJuUs5CuuuYY=;
        b=k+5KfiC/kSAPGrmIB1abnThdrsqhThe98DH7MeV3C2J6Q/pMT3lDsJnIWo26ePmViS
         TjuC83wYpIkUJlcg7v3PXBcJ/i/JhXwG3SqkgbJnV1Y8P9zztnduTkzd8xHl0iKy78br
         02N66wTtiuRjj1F99sXk6vrxzAOAaUl9CPYhI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AONa6nFEm2OwnRkdUIipwY5AivMKTaN+flxqHqpGD9lopDnMZc6bhX3sgiNY0UgBK5
         fHO9DbXTT3Mhn7MVY0eao3EHQ+wtO+8vqOcpr1pCtk1AxvtwIXwVTjgrI15gmoEYkonh
         8xQpDIyviUL3CRBpCcmTU9F+y3MEwDSX20DRA=
Received: by 10.220.126.144 with SMTP id c16mr859258vcs.103.1260790428179; 
	Mon, 14 Dec 2009 03:33:48 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0912141235090.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135200>

Heya,

On Mon, Dec 14, 2009 at 12:35, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Try removing "." from the PATH on Windows... to spare you some cycles=
: it
> is in PATH _implicitly_. =A0You cannot remove it from ".", even if yo=
u try
> hard.

It's an amazing OS, it's quirks keep surprising me day after day :).

--=20
Cheers,

Sverre Rabbelier
