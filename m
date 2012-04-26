From: Scott Chacon <schacon@gmail.com>
Subject: Re: Bad Man Page URLs
Date: Thu, 26 Apr 2012 15:25:11 -0700
Message-ID: <CAP2yMaKiAT-YJeqmxzZeVuNhEnN-LaJ2h3fSuzZbonKyxCKCCw@mail.gmail.com>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net> <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino> <20120406054637.GA25301@sigill.intra.peff.net>
 <7vzkap1gck.fsf@alter.siamese.dyndns.org> <BCD7B631-8C73-4F3F-AB37-9B5CF02655D5@justatheory.com>
 <20120426201921.GA15026@burratino> <20120426210251.GA31589@sigill.intra.peff.net>
 <CAP2yMa+mjvFmVwXjrB7FRaD2=iMCCPENWAOoCG5TCsqFdsCDxQ@mail.gmail.com> <xmqqehra6swg.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	"David E. Wheeler" <david@justatheory.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:25:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNX85-0005u3-RZ
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759324Ab2DZWZd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Apr 2012 18:25:33 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:63115 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398Ab2DZWZc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 18:25:32 -0400
Received: by qatm19 with SMTP id m19so10810qat.19
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 15:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Fj91I/koeB2n7sUoMfZcpdi64Tasn4gLIbUw3/XTm30=;
        b=gc7kdrNAeOFmxMgRMtetzXqflrdqPojsqTyC00LLArnpOSXj+rAkyliatKNQTdCNwE
         cjv+Ox+xhuPXDkSahrWe4GwD9Td6FyaTXimK7dRaYaFn4/29Sr7fpQH/CltrUKRmnIT3
         BjVFRFDJTnz2gASupNw0Yep/fruqI2jSxj00QCR+gvS5tyZtMp5ax6Qdqc8mnKVdcMQT
         dHQw4rpixnB9sBnnPwbiv8uByBBSzVPLee7waYFT89kNm/Bf23+Vw1QvSEvwVVTBaqst
         E94LaZYRRWM8Lmn65rCqeRlVpzS7+KwZ+cvjdV74UUPS882j26R5x31rHRRtFPH0y0/P
         VJbA==
Received: by 10.224.190.68 with SMTP id dh4mr6908631qab.5.1335479132056; Thu,
 26 Apr 2012 15:25:32 -0700 (PDT)
Received: by 10.229.163.210 with HTTP; Thu, 26 Apr 2012 15:25:11 -0700 (PDT)
In-Reply-To: <xmqqehra6swg.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196422>

On Thu, Apr 26, 2012 at 3:16 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Is it possible to have a link to Release Notes (not manual pages, whi=
ch
> you already have links to) for each release from "http://site/docs/gi=
t"
> like we used to have at k.org site? =C2=A0It is not a big deal, but t=
hat is
> one thing I miss the most.

Yes, this is pretty easy to do - just about everything in
Documentation/ will eventually be rendered - including the user-manual
that is currently missing and the release notes.

Scott
