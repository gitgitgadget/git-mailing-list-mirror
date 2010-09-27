From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 09/12] gitweb: group styling
Date: Mon, 27 Sep 2010 09:27:10 +0200
Message-ID: <AANLkTikg8ya7WNS0-Tep2s+D57Qkxo-GfuiZmq7YOJgm@mail.gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1285344167-8518-10-git-send-email-giuseppe.bilotta@gmail.com> <201009270010.45142.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 09:27:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P087d-0006sp-A2
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 09:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758861Ab0I0H1d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 03:27:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41146 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab0I0H1c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 03:27:32 -0400
Received: by iwn5 with SMTP id 5so4552788iwn.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=diydA6SAbjbUP8dVcYnjA522y9KEJex/1iKGDvP1lAc=;
        b=vzyZt0w5C+AfLGwvALQBT26YJVaUKJyleSN5NCmGumDeBeFdTCx0wdJSkKZ2cIGsYA
         H1b0spaf3FFA0nUTcOziDE+KC1WPbnfAbvQ9BRIrp58lFvKkcQ1KyP2UK64qY/gceOAq
         TB1vIY+asPGnqBAwBRGmpd4aeL1QnJyLzCdsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Pq6NDPD7DLNyv7Z7t3/FuiOobK8W9Tv3L79dKOQRximSBytv/ovyPl7ktLk1qKvyjv
         EAmeoKB3AgC3IZTWxK980AFgYsvjTu2s2oZViDoCUo/Lyeohp2XU0S9sZKjBrPRgv1IL
         hOZy0lGvymTCW4pB/mGArExxnq7qKrEJSZCP8=
Received: by 10.231.33.76 with SMTP id g12mr8504168ibd.174.1285572452047; Mon,
 27 Sep 2010 00:27:32 -0700 (PDT)
Received: by 10.231.166.145 with HTTP; Mon, 27 Sep 2010 00:27:10 -0700 (PDT)
In-Reply-To: <201009270010.45142.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157312>

2010/9/27 Jakub Narebski <jnareb@gmail.com>:
> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>
>> +div.group {
>> + =A0 =A0 margin: .5em;
>> + =A0 =A0 border: 1px solid #d9d8d1;
>> + =A0 =A0 display: inline-block;
>> +}
>
> As I currently at this moment don't use web browser which supports
> 'display: inline-block;', I can't say much about this patch. =A0But
> it does degrade nicely.

Would you think it's sensible to squash this with the previous patch, b=
tw?

--=20
Giuseppe "Oblomov" Bilotta
