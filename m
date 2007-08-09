From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: 'pu' branch for StGIT
Date: Thu, 9 Aug 2007 22:31:09 +0100
Message-ID: <b0943d9e0708091431k57ac095asa940cca73ad95b13@mail.gmail.com>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk>
	 <1186549433.2112.34.camel@dv>
	 <20070808092027.GB7860@diana.vm.bytemark.co.uk>
	 <20070808213917.GA22521@diana.vm.bytemark.co.uk>
	 <1186611514.7383.4.camel@dv>
	 <20070808232349.GA23172@diana.vm.bytemark.co.uk>
	 <20070808201003.nm90u2s5ny888wcc@webmailbeta.spamcop.net>
	 <20070809073801.GA31482@diana.vm.bytemark.co.uk>
	 <1186665883.28228.31.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git@vger.kernel.org, "Yann Dirson" <ydirson@altern.org>
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 23:31:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJFb9-0002PW-MM
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 23:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbXHIVbN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 17:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753887AbXHIVbN
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 17:31:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:3076 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752179AbXHIVbL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 17:31:11 -0400
Received: by ug-out-1314.google.com with SMTP id j3so410855ugf
        for <git@vger.kernel.org>; Thu, 09 Aug 2007 14:31:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e8kz7yjplSPz6yVfWeV4Yxq6mOHo9o7riCQbvD3PnJi9C6bcuuhhC16OK2InaVAKTg7AdOhe2+054kLcpr1DpEk+FHiWk43TD/vYjSJ1TTbB3x23V70EPnAFVYCMhYUnQfQcw1jQG6/nUo0seL5odbvnpaqvVOlLZvBt1OUZnJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Td4/B2z17ckdQmzaCqVfcXetblMS90VPkjOQrWv8O0dncOeB/TBgBGdDUyuOgNUlwlxx8p0iOousi+PGel6X0Pj2giatS+2gSwZxwACyxAUz2mbmGPgA3S3NqV8ggAnZheywmYIBoX1wIIUDICdF2sxGQ/M0kw7H4H/gnfaisiE=
Received: by 10.67.29.12 with SMTP id g12mr1350124ugj.1186695069950;
        Thu, 09 Aug 2007 14:31:09 -0700 (PDT)
Received: by 10.67.23.15 with HTTP; Thu, 9 Aug 2007 14:31:09 -0700 (PDT)
In-Reply-To: <1186665883.28228.31.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55476>

On 09/08/2007, Pavel Roskin <proski@gnu.org> wrote:
> On Thu, 2007-08-09 at 09:38 +0200, Karl Hasselstr=F6m wrote:
>
> > I take it this all means you're actually using my branch? What's yo=
ur
> > opinion on its usefulness?
>
> Well, I tried it, and then ran a script to update all local
> repositories.  It converted everything to "version 3", so I'm sort of
> stuck with it.  If the "version 3" code is not committed to the mainl=
ine
> StGIT, I'll have to convert my repositories back or even re-fetch the=
m.

I'll merge many of Karl's patches for the next stable release (which I
hope to be sooner than the current 0.13) but I'm still on holiday for
one more week and can't do much work (busy with DIY).

Thanks to Karl for setting up this experimental branch. BTW, what does
'pu' mean?

--=20
Catalin
