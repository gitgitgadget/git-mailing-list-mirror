From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7 1/2] Documentation/remote-helpers: Rewrite description
Date: Tue, 6 Apr 2010 08:17:50 +0530
Message-ID: <k2mf3271551004051947h724aab5ai6da2e53336e1713@mail.gmail.com>
References: <f3271551003281103x68812b3cj806d6235965f0a32@mail.gmail.com> 
	<l2pf3271551004050705o20379311j9862bd9ab46cbb11@mail.gmail.com> 
	<7vtyrpmun7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 04:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyyps-0007gN-Sr
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 04:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757202Ab0DFCsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 22:48:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45848 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757102Ab0DFCsL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 22:48:11 -0400
Received: by gyg13 with SMTP id 13so2374294gyg.19
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 19:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=UQOEWVw6dkGGx9/ca0//jsqvyTEW36DECJvlZKg6eYo=;
        b=wQ3zB085eQqc7MVWH7i9XtBgcAVup0ZUdRocMw1NTHDHNWHemSalgk2eXFDMALyYHI
         ImMHVbo6viXxzEV5ZFaElXBuf99mTuPd6ejZ0CE+BgVUW6lwWLiLgGqc+zy0VYKtWzFp
         9QCsa+PgtkqNUTLo053pcTtZADZOAIPP9Dn9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=D93Si3djQNumgeJyvWVpbovkNPUF9PEfxyAzH6zVLxyX+cCHvgm4oQ2SZkReYllABd
         WbaN8hMmMKNEA3XkJQ9kw0zz0LQ4/Dg1CHFeDclLD3Ou8w/VgxiXlnI3G/Mn1N6dA44Z
         VD4UE9ggaOaT6Bmr+3/V2P/biCL0z42P6smWA=
Received: by 10.90.69.14 with HTTP; Mon, 5 Apr 2010 19:47:50 -0700 (PDT)
In-Reply-To: <7vtyrpmun7.fsf@alter.siamese.dyndns.org>
Received: by 10.90.3.29 with SMTP id 29mr1930354agc.42.1270522090291; Mon, 05 
	Apr 2010 19:48:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144088>

> I'll copy and paste this, but please make it a habit to sign off your
> patch when committing if you plan to be a regular contributor to the
> project.

Sorry about that. I'll auto sign-off and pay extra attention next time.

-- Ram
