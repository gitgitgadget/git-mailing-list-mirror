From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Making Git easy to use -- without RTFM, was Re: [PATCH] 
	Proof-of-concept patch to remember what the detached HEAD was
Date: Tue, 27 Oct 2009 13:58:21 -0400
Message-ID: <32541b130910271058u514c3356j84f98182b6b3ede9@mail.gmail.com>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org> 
	<20091015014737.GA9923@coredump.intra.peff.net> <alpine.LFD.2.00.0910142237010.20122@xanadu.home> 
	<alpine.DEB.1.00.0910160256180.4985@pacific.mpi-cbg.de> <alpine.LFD.2.00.0910152118360.20122@xanadu.home> 
	<alpine.DEB.1.00.0910160357370.4985@pacific.mpi-cbg.de> <BLU0-SMTP840FB343954FC20ACA699CAEC30@phx.gbl> 
	<alpine.DEB.1.00.0910262317430.4985@pacific.mpi-cbg.de> <20091027124156.6117@nanako3.lavabit.com> 
	<alpine.DEB.1.00.0910271118470.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 18:59:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2qK8-000324-Lp
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 18:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbZJ0R6h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 13:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbZJ0R6h
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 13:58:37 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:49320 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbZJ0R6g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 13:58:36 -0400
Received: by yxe17 with SMTP id 17so350451yxe.33
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NcUAUOrpEcRiyNA2+jTXuOs6PtVWiE1n47FKkxisAW4=;
        b=S3N70oN68BBpa28P2+xl4I0nQmTA+yUg5p+xSvApE2vplmhuXV2zkBCNDZ8EMADoZK
         BTIWbd6Cq2szaiHqBdX+0gxZpJZpiIwjOwSVKlDsZ6YSTYXpsKt9Df7Ag8d5fndg077m
         4pYR3WSLRi5vkjZhVmp/MRUTweaN4hCYBMti0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OWhpz5d8g4bED5IdDhuhTaTZaXI6PQaq+EiX5atiLmIKvY47MBXFc9yNDuDtMuQ9jZ
         ECLuf71MM99aGaTW4Por0TIY568S1x10nSjNto3VSXFAaMCzIiXD6JtAIL0rb4WxEZ8r
         Nmo73UUZ+sttTjk7XMdQgUDMnaub2fvdU+SJM=
Received: by 10.150.172.1 with SMTP id u1mr26966389ybe.300.1256666321070; Tue, 
	27 Oct 2009 10:58:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0910271118470.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131363>

On Tue, Oct 27, 2009 at 6:33 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Anyhow, here it is: one of my users refused to touch SCMs _at all_, f=
or
> decades. =A0There was only one choice: have a Git branch with a purel=
y
> linear history that contains the copy of the working tree at the end =
of
> the day, with whatever changes accumulated over the day, or no histor=
y at
> all.
[...]
> You know, when there is a hurdle half of the people you see cannot ge=
t
> over, there are some who make the hurdle half as high, and there are
> others who put more hurdles there and call it a sport.
>
> In this case, I would have preferred to make the hurdle half as high,=
 but
> I think I just have to wait a couple of years; reality will take care=
 of
> things.

In this case, what would you have preferred to change in order to make
the hurdle half as high?

Thanks,

Avery
