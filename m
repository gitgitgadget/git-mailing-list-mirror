From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: How is git used as other than the project's version control?
Date: Tue, 28 Apr 2009 00:25:28 +0100
Message-ID: <18071eea0904271625w5757c869x33b4b00a766fc90@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3EC48@EXCHANGE.trad.tradestation.com>
	 <18071eea0904271606t4757a01di40e7b0cf6c558bea@mail.gmail.com>
	 <450196A1AAAE4B42A00A8B27A59278E70AE3EC4B@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 01:25:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyaCf-0001Cg-Vo
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 01:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbZD0XZa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Apr 2009 19:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753322AbZD0XZ3
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 19:25:29 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:35589 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbZD0XZ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Apr 2009 19:25:29 -0400
Received: by ewy24 with SMTP id 24so241449ewy.37
        for <git@vger.kernel.org>; Mon, 27 Apr 2009 16:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0qyZ9rW/lf28pQAjS93BKkkxi0qekCUN6NgA6OToZnI=;
        b=ikbTdCysgNf6mWDyyVyiS1ewJKXw13tUJUEhykdbLIVsTDJGqIiaHdldtDib/lXqAH
         BN7LaGFPD3cTNQHtPl7um1DLgUgX+hpWERorIi0C8jH0e/oM9cIHWs9KM7YfD40wwZYr
         760vKPWGEQVAbvth9cmioIuKnfhHJ3Ces1m24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jmjJTWqhy2xa0oC/aYKgM3czqfT/vHJTGkK1kTHtsVblh6BQfIMBpX937U9NDx88XC
         Zg5g0eu7C/tksjrziYNk3qXuutgvzaR7taPzpskaFnERo6t6DEXo7f4406Z2d6MwZWqQ
         Zn6Ows24KEFN6wXTjPcCAgnjQE+ujsuAuuyoY=
Received: by 10.210.133.2 with SMTP id g2mr4431067ebd.2.1240874728194; Mon, 27 
	Apr 2009 16:25:28 -0700 (PDT)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70AE3EC4B@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117738>

2009/4/28 John Dlugosz <JDlugosz@tradestation.com>:
>> What is it you're really asking here?
>
> When putting together a presentation on git, I created a simple-looki=
ng
> slide claiming that "developers will use git anyway" as a
> general-purpose tool. =A0I find lots of web chatter about using it as=
 a
> lighter-weight front-end to an Enterprise VCS, or as part of a techni=
que
> for working away from your desk in such a system. =A0But it got me
> thinking about how it might be more like a text editor in the sense i=
f
> being more generally useful than just that specific thing it's "for".
> But I don't have any concrete examples, just a vague notion.

Well, still you skirt around the main issue,  I use git in numerous sce=
narios:

*)  As a front end to a CVS and/or SVN repository.
*)  To manage files in my $HOME directory.

In the case of the first point, I have people using CVS/SVN directly
without them ever knowing I used git to commit my changes therein,

Is this what you're asking?   It's certainly possible and not too diffi=
cult.

-- Thomas Adam
