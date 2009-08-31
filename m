From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: What IDEs are you using to develop git?
Date: Mon, 31 Aug 2009 17:06:51 +0530
Message-ID: <f46c52560908310436l7eb2794eq4f299fbb04c66f97@mail.gmail.com>
References: <000001ca257d$b60326c0$22097440$@com>
	 <43d8ce650908250547t17b76c95qb9931983e0a4b232@mail.gmail.com>
	 <1251655664.31273.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 31 13:37:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi5CP-0008AB-E2
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 13:37:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbZHaLgu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2009 07:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbZHaLgu
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 07:36:50 -0400
Received: from mail-px0-f189.google.com ([209.85.216.189]:45310 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbZHaLgt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2009 07:36:49 -0400
Received: by pxi27 with SMTP id 27so39057pxi.15
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 04:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=C/uhha2GFBhi4Pu/9CeEWNshLxjK6Th7UhAQd0yMQK0=;
        b=sL2g9SnwX2S0oY3j/FaPuYHnmIQOWvWb0msR9uu1tryB7+AuaakbMDBsTl2Jkgq5Ba
         p+9kq7mNbyhjNDa/zQRRwQRgitVB74yXVDQisJ64XlCeyyHuMlEH/AfOurzKAy9nDAMF
         esnOO8R3+s5gAAxExFrG/HfgCn1F3bTMkKP24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=d6eg50FxscJmaL0rwzpxaA5emOeLOq9dMSCrJoBOghBpVeb/zqmsRLSxbUCRmh9psX
         AXJUBUu99TXMzT9IZrpkE3lNWdGHiXi3Bm/mgkx8lyMTEty+P0Bh/CQlTJxPD3MTwOhz
         lKo3fxge7U6goLX2YX8SxX26H8vGNxVaiWmX8=
Received: by 10.115.101.1 with SMTP id d1mr2497845wam.40.1251718611716; Mon, 
	31 Aug 2009 04:36:51 -0700 (PDT)
In-Reply-To: <1251655664.31273.4.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127479>

On Sun, Aug 30, 2009 at 11:37 PM, Daniele Segato
<daniele.bilug@gmail.com> wrote:
>
> Il giorno mar, 25/08/2009 alle 13.47 +0100, John Tapsell ha scritto:
> > 2009/8/25 Frank M=FCnnich <git@frank-muennich.com>:
> > > One thing I would like to ask you: what, if any, IDEs are you wor=
king with?
> >
> > I think everyone just uses vim/emacs :-)
>
> I can't get how would one take vim or emacs instead of an IDE like
> Eclipse.
> That's probably because I'm mainingly a Java developer and i don't kn=
ow
> vim/emacs very much.
>
> What are the advantages of developing git with vim/emacs over an IDE?
>
> Cheers,
> Daniele

How much mouse do you use and how much keyboard?
And now read http://steve.yegge.googlepages.com/effective-emacs.
Note: vi is ergonomically superior to emacs (shortest keystrokes, no
mouse at all)  but emacs can do more than vi
