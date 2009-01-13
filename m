From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stg coalesce -> squash?
Date: Tue, 13 Jan 2009 21:19:55 +0000
Message-ID: <b0943d9e0901131319j753b4766y9bce865f1a610273@mail.gmail.com>
References: <20090113164157.GA20143@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 22:21:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMqhR-0008U1-UY
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 22:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbZAMVT7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jan 2009 16:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbZAMVT6
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 16:19:58 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:62048 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbZAMVT5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2009 16:19:57 -0500
Received: by bwz14 with SMTP id 14so748798bwz.13
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 13:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=rgUPkLMhCvpLs7NKuKgGBYjlHYDZZchquVqpLAyDNX4=;
        b=qDpyFVuIAB0YILuEUe+061H8P4coDct2mGZ/jGqr7stfq/2z0nCoifFf+C1Ka2hpN5
         Uikg1UnJooujOyTeQwDeHa3TBvvm0UDPYMOQxGV1Gq9XGlkBK8Z28f8knGATADK0YuIk
         MJtxR1id8xqp1u/Au1SRnqYWGksOieFWS0NxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qfjpORuv4s40klzJmrYodQO5lrTCay47dNEkCV/R3dg6tG9v0WUu5AYn0b8P48Xrrh
         GezvPcCQvL9GcrPYz3YY5vUxdpWC0aJcW5LUL8LR+H/QYKe+oMuFPoWkGtzitGWqOKSU
         LoH1IDBImv/DIYkTSzB7z8vY9wD3iUw8OaZLc=
Received: by 10.223.105.140 with SMTP id t12mr23171584fao.12.1231881595480;
        Tue, 13 Jan 2009 13:19:55 -0800 (PST)
Received: by 10.223.115.148 with HTTP; Tue, 13 Jan 2009 13:19:55 -0800 (PST)
In-Reply-To: <20090113164157.GA20143@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105536>

2009/1/13 Karl Hasselstr=F6m <kha@treskal.com>:
> Would it be a good idea to rename "stg coalesce" to "stg squash"?
> That's the term git uses, and it's shorter, easier to spell, and
> easier to say.

Yes, that's a good change. I always wondered how to pronounce "coalesce=
" :-).

--=20
Catalin
