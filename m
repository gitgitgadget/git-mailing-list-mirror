From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 21:09:47 +0200
Message-ID: <fabb9a1e0908311209y4c83b60eg75ced6d3db615dff@mail.gmail.com>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net> 
	<vpqskf8z0rj.fsf@bauges.imag.fr> <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com> 
	<20090831164146.GA23245@coredump.intra.peff.net> <fabb9a1e0908311012q4cea2d51i2c2f0cbceac0cab@mail.gmail.com> 
	<20090831190827.GA4876@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:10:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiCGh-0006Aa-Jj
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 21:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbZHaTKH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2009 15:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753575AbZHaTKH
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 15:10:07 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:34756 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbZHaTKG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2009 15:10:06 -0400
Received: by ewy2 with SMTP id 2so616232ewy.17
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gQZ4n4MkJzpCWIu45uGPagQE9fprcKjaw2UAEltz6yc=;
        b=CVypzd3YQjdq/vK3ieezOiSlkQdnLVBYhe36mhOczKr7KmgAyhmGziH/zuMMIFEMvI
         KGagOamH3md+HtGuPf37GESnXox6vNSkbzhEtrv2T1etTTkzB3poXveJzuRJqJcQGw5d
         Z6FRxqYCMPWPMNcOiqlrXjwGa9eACIJMLgkxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=d6hdOB32e/rChSyf+GDFy63xr5PGOA3QOrfnNXuIf4d56pL0I5JU11GdLI2ooAulIk
         lA+BbpetTf3Bx+2ihXruK/6xQG5pZE2kAUYdkh00HrNDVcQYJd5Wn8F8UoDPp5pkf+9G
         xJDbeETdf9Mq10E+gCMmN6T1mrOLGDcu1fPNY=
Received: by 10.216.87.68 with SMTP id x46mr1337710wee.2.1251745807311; Mon, 
	31 Aug 2009 12:10:07 -0700 (PDT)
In-Reply-To: <20090831190827.GA4876@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127493>

Heya,

On Mon, Aug 31, 2009 at 21:08, Jeff King<peff@peff.net> wrote:
> I think the former. I thought it was discussed before, but the only
> reference I can find is this (see the end of the email):
>
> =A0http://article.gmane.org/gmane.comp.version-control.git/107626

Ah, yeup, I see.

> and I don't see any followup for that specific part of the mail.

I don't remember any follow up to that either, shame on me :(.

--=20
Cheers,

Sverre Rabbelier
