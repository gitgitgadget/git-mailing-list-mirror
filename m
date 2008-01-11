From: "Julio Espinoza-Sokal" <julioes@gmail.com>
Subject: Re: [PATCH] gitk: make Ctrl "+" really increase the font size
Date: Fri, 11 Jan 2008 08:22:31 -0500
Message-ID: <1a61e4060801110522o67ab6c08y9e979abb2b7da102@mail.gmail.com>
References: <fm5oln$ahq$1@ger.gmane.org>
	 <alpine.LSU.1.00.0801111238150.31053@racer.site>
	 <47876823.1070800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Stephan Hennig" <public-mailing_list-KvP5wT2u2U0@lo.gmane.org>,
	public-paulus-eUNUBHrolfbYtjvyW6yDsg@lo.gmane.org,
	msysGit <msysgit@googlegroups.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 11 14:23:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDJqg-00042n-BJ
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 14:23:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758587AbYAKNWe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 08:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758617AbYAKNWd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 08:22:33 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:6121 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758479AbYAKNWc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 08:22:32 -0500
Received: by nz-out-0506.google.com with SMTP id s18so621571nze.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2008 05:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=33wZ+2ZBZxh1LImzaH8L/t++8NGMnrc/3ByHowsBPiE=;
        b=G+oBInDGbcZpH2Le/x626WdgmFgryEgscRKbGWRyYtJlO2QxVUx/bHFwwSiQnjTsPzLhjBCDe4UQG9jQSxyK882Np9jx4tR6j2LDirRmgmQT4MWN2jl49ikb0SkWzK9fRNF2o1LhMO2xVCeTgW0miadj8X/QNesZTsJzkR1Q2pY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NdYAE0ZwNTXEqtQaZfC3/2gdLQmKzT/TJg2TFz98kGvoIGGS1viLFXqxxmpC9WTw7nlpjZhgczdV3bw2TFgIhZMT7NPhKa10UhvLmPqaGzoat/FRd0lMnvRxm3MZ6zTZc6fRcjxBnFXF/Xh0P91i9eCrVCyQDpl3nV8IDHDs+G4=
Received: by 10.142.108.14 with SMTP id g14mr1604333wfc.52.1200057751087;
        Fri, 11 Jan 2008 05:22:31 -0800 (PST)
Received: by 10.142.203.5 with HTTP; Fri, 11 Jan 2008 05:22:31 -0800 (PST)
In-Reply-To: <47876823.1070800@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70159>

On Jan 11, 2008 7:59 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Johannes Schindelin schrieb:
> > Only Ctrl "=" was bound to increase the font size, probably because
> > English keyboards have the plus on the same key as the equal sign.
> > However, not the whole world is English, and at least with some
> > other keyboard layouts, Ctrl "+" did not work as documented.
> >
> > Noticed by Stephan Hennig.
> >
> > Signed-off-by: Johannes Schindelin <Johannes.Schindelin-Mmb7MZpHnFY@public.gmane.org>
>                                                          ^^^^^^^^^^^^^^...
> WTF is going on these days?
>
> [note: yours, git ML and msysgit ML adresses corrected manually]
>
> -- Hannes
>

I don't know if this is new, but it seems that's a feature of Gmane to
prevent spam.
http://gmane.org/tmda.php
