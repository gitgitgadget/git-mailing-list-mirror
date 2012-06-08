From: Leila <muhtasib@gmail.com>
Subject: Re: gitbook link broken in spanish
Date: Fri, 8 Jun 2012 10:07:11 -0400
Message-ID: <CAA3EhH+g4A8RXvmr_SVi74SzGOqXktz3U6=V1KUEUD6ZAEm9XQ@mail.gmail.com>
References: <4FD1F214.8020306@gmail.com> <20120608130554.GA12627@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Mart=EDn_Ochoa?= <mmochoa@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 16:07:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sczqk-0007Tm-9v
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 16:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757372Ab2FHOHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Jun 2012 10:07:34 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:45135 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757180Ab2FHOHc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2012 10:07:32 -0400
Received: by vbbff1 with SMTP id ff1so1091473vbb.19
        for <git@vger.kernel.org>; Fri, 08 Jun 2012 07:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=iGMpGCNKrhXdwNu7smG9bIZvm/wD/mp5WoBJ2TbPhds=;
        b=X9xA5ZLTILgGjOEvjU8Q2mp9D93y7YBKETpFTFBGxTuSPJqP9a749v84i+OdnCUzpH
         fb3u1HLVI6j2LqqUkXNqcghmVhAUtm5bC9EGeixiAIFqWd2oo7wCr0E+Rs8BegQ0As2A
         lkIiZCUzqKgN60WAAjk913s+/1Z/4SR1/6Ve5aefVaqSoG/BGUq1Pq+jZoqp0kOe0n7q
         EZ98kN0otq4bBRRRRpfHdEUEcYBKLodZWFDimYc6fKfRAoPumJvyHWJoInDetMbmU62U
         xC9NHPQSiwtMsopaLNas+l2ChQ/fyF+e1wo3jgVoBGlapwwxwT4rEZTahCwPS2VfLqRH
         1pqg==
Received: by 10.52.97.41 with SMTP id dx9mr5397425vdb.89.1339164452056; Fri,
 08 Jun 2012 07:07:32 -0700 (PDT)
Received: by 10.52.37.233 with HTTP; Fri, 8 Jun 2012 07:07:11 -0700 (PDT)
In-Reply-To: <20120608130554.GA12627@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199490>

The first external link 'Introductory reference and tutorial' is also b=
roken:
http://gitref.org/

On the page:
http://git-scm.com/doc/ext

I'll open an issue if it lets me.

Thanks,
Leila

On Fri, Jun 8, 2012 at 9:05 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 08, 2012 at 09:37:40AM -0300, Mart=EDn Ochoa wrote:
>
>> I found a link broken in
>> [...]
>> http://git-scm.com/book/es/Ramificaciones-en-Git-%C2%BFQu%C3%A9-es-u=
na-rama?
>
> Yeah, it definitely appears broken. git-scm.com bugs are tracked at i=
ts
> GitHub repo. I've opened an issue for you:
>
> =A0https://github.com/github/gitscm-next/issues/142
>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
