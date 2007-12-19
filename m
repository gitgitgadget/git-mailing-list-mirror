From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: kha/safe updated
Date: Wed, 19 Dec 2007 23:29:13 +0000
Message-ID: <b0943d9e0712191529u5e54eca4rd0ab4ecd73217a7e@mail.gmail.com>
References: <20071219221848.29455.50676.stgit@yoghurt>
	 <20071219221957.29455.27315.stgit@yoghurt>
	 <20071219224638.GB15119@diana.vm.bytemark.co.uk>
	 <b0943d9e0712191517r6154f6c2g98068c8070275cb3@mail.gmail.com>
	 <20071219232614.GA16246@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Dec 20 00:29:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J58M9-0004qw-Lq
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 00:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbXLSX3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 18:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753738AbXLSX3P
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 18:29:15 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:45044 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbXLSX3O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 18:29:14 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2812125rvb.1
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 15:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HpZljvLuf3I2BxAreLNWwkwPI2ojBxxXILS/OqrIp74=;
        b=WQ4V5sXg5lu/+PPfpDcz5Mz9AN2qnuA2s7XdMLdRM36S466skr//nEbsy3vzOmnSUnrBOmvYgxsyQ3akTNNWppiK2NVB7oY8ainPAQI6NFeD46uSLh9D3vIUv00Jd21iGdG/Y3Kqi1Q4cKOUoTLqobefC/+rbLlTYLOY+V7UUF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IiqV0IPdsfXqzVngKQm7v9ffpRKlQE6oyeaGP79CeaLYO4sG4XO0QIh62tRWE78EM1hqlSOh45qmruuxdKkg2GSJrjT5iprJiJ6Xi0qVqwrxQnCwCTUSScwZ2BxbNc+L7uS1hkAf6gSzf478HwtRAzSvqKj6VNzysIdju8291GY=
Received: by 10.141.4.3 with SMTP id g3mr6349812rvi.116.1198106953507;
        Wed, 19 Dec 2007 15:29:13 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Wed, 19 Dec 2007 15:29:13 -0800 (PST)
In-Reply-To: <20071219232614.GA16246@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68959>

On 19/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-12-19 23:17:42 +0000, Catalin Marinas wrote:
>
> > On 19/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >
> > > And with that, I don't see any reason to not recommend that you
> > > pull every patch I have. Which is:
> >
> > Please rebase again when you have time since I already merged most
> > of this branch and added some patches that might conflict with
> > yours.
>
> You hadn't pushed any of it out when I last checked about two hours
> ago ...

I just pushed the changes a few minutes ago.

> Will do, but not tonight. In fact, it may be a few days, I'm afraid.

No problem. Anyway, if I don't here from you in the meantime, have a
good Christmas :-).

--=20
Catalin
