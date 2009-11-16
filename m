From: Brian Collins <bricollins@gmail.com>
Subject: Re: [PATCH] RFC Allow case insensitive search flag with git-grep for 
	fixed-strings
Date: Mon, 16 Nov 2009 08:58:26 -0800
Message-ID: <d1c0fbfa0911160858k2cdd35bfvf27df2a5c97348ad@mail.gmail.com>
References: <B7C4E16C-B15D-4A7B-873A-B6BD0FDAD8C8@gmail.com>
	 <20091116195050.6117@nanako3.lavabit.com>
	 <20091116162533.GA30737@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 17:58:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA4uZ-0005KU-8Z
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 17:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbZKPQ6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 11:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752890AbZKPQ6V
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 11:58:21 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:45195 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbZKPQ6V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 11:58:21 -0500
Received: by pwi3 with SMTP id 3so3371790pwi.21
        for <git@vger.kernel.org>; Mon, 16 Nov 2009 08:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=yD3ljWxnCSm9JiBWTRY85n4rDFAD6X0vRewdUYDj8zA=;
        b=txAr01m7rLZkIOnzxX4XpTM1G8VUDS4UUYI/kauwMCC9j2cYj1wjQTsFgh8EzOpyTf
         gmTGvM3DWn4Ud3PP7sEUV7qAIzKT1xQJVV9hiEg/Udl+sbLD0jD7O91fG3AdJTDseEI3
         xMenNYGkDa8BZZz1Q6gfZp4X+CkvoV/GMSaxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SgCAopCUABB1FeEwwSnBfdzqVtLGflf0l0SVFCtmSovIqXs0QoS5/anh+inLaNlL1D
         n+o1pPqdFHcl6MKb/ZY2N3Fd3xCDXvCzalX6DAhmvgrPTZj6DYTb66lUKJLaAmpKqQbn
         RqtdGPpH/TRHYtOWBS8cc+njy/2I+RbMVF2ws=
Received: by 10.114.214.28 with SMTP id m28mr7538251wag.44.1258390706389; Mon, 
	16 Nov 2009 08:58:26 -0800 (PST)
In-Reply-To: <20091116162533.GA30737@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133017>

>  1. The patch was line-wrapped; I had to de-munge it manually to apply.

Ugh, does gmail do this? Sorry

>  3. No signed-off-by. Brian, can you please acknowledge the DCO with a
>     signoff?

Signed-off-by: Brian Collins <bricollins@gmail.com>

>  4. The patch introduced some stray trailing whitespace.
>
>  5. There were a few style fixups, like omitting braces for a
>     single-line conditional.

Again sorry, thought the opposite was in the style guide.

--
Brian Collins
