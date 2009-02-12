From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 12 Feb 2009 11:51:21 +0100
Message-ID: <bd6139dc0902120251g6b1ee6d0i688c9f1a4b003a4e@mail.gmail.com>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
	 <20090129113735.GA6505@coredump.intra.peff.net>
	 <351A6988-32EB-473F-B6E5-8FBB38D91F88@ai.rug.nl>
	 <bd6139dc0901290345u4962f747gbe93c945ab35c9cb@mail.gmail.com>
	 <20090129115026.GB10792@coredump.intra.peff.net>
	 <bd6139dc0901290420x1216a399w656e4d1622178a06@mail.gmail.com>
	 <20090130045131.GB18655@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0901301415260.3586@pacific.mpi-cbg.de>
	 <7vr62j0wpc.fsf@gitster.siamese.dyndns.org>
	 <7v3aekqhpo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 11:53:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXZBo-00085M-9R
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 11:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758936AbZBLKv2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2009 05:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758924AbZBLKv0
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 05:51:26 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:48967 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758046AbZBLKvY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2009 05:51:24 -0500
Received: by fxm13 with SMTP id 13so1756884fxm.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 02:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=BmDt3l6mL3d5X523cA/oKZsKKpSC3vRqE+NHmahf1UE=;
        b=a63Tix1Lp3eazs8anCOoP9HOeZOzA3mLp3t78kH5QANdBJuiBSU1LmKfawtIzpGPc6
         vgDvNOQHiTe8LP+DhfMylSkTBK1zKSM18YonWB/T3R9MfodPJgk5KpsMOp2wt/5TVH7U
         jFTGd5Q8DamBfYCmDdDTrQQo3K849RXw70/co=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=eEXi6aRVp9IebR7yRYJkbUpvfDRzU+vMXJz9X697OGbPmO85pa2UtULRyxCw6D5eyd
         wlyCzkIYZT5yVQkoWrOkAXiUzm+gwW6G1B4Cpwlnya7lxoK65Se1QFux1dpJ5+qwlqno
         BAVMcQaTxNkLkNS9+OPfbsFB748CMgQQ8wiPc=
Received: by 10.86.95.20 with SMTP id s20mr1347480fgb.4.1234435881980; Thu, 12 
	Feb 2009 02:51:21 -0800 (PST)
In-Reply-To: <7v3aekqhpo.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: ef19ed8ce858a1ea
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109599>

Heya,

On Thu, Feb 12, 2009 at 07:42, Junio C Hamano <gitster@pobox.com> wrote=
:
> Exciting new features we can count on original submitters to stick to=
 them
> and push them forward whether we go into a release freeze, but the mo=
re
> boring kind of patches that we already know what we want to see by th=
e
> next release are actually the more important to the overall project;
> sadly, they tend to get lost somewhere in the crack. =A0I wonder if w=
e can
> do anything about it.

I'm sorry for not picking up on this, the deadline Melange being done
is getting closer (GSoC org applications are starting in less than a
month), that together with school having started again results in me
having little time left.

Thanks for following up on this!

--=20
Cheers,

Sverre Rabbelier
