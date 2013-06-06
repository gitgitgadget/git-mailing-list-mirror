From: demerphq <demerphq@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 6 Jun 2013 09:26:02 +0200
Message-ID: <CANgJU+W1BLOB_TuMa_zRHtCW-8Ge8nu_kK=5qu2xDY=Km_kk4A@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<CAMP44s012ccmaArrTbfy_xNrqbnOjVGTnY+po9cE8JGh_U72Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 09:26:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkUaH-0005fW-3Q
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 09:26:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754584Ab3FFH0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 03:26:05 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33997 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898Ab3FFH0E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 03:26:04 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so335562pdj.26
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 00:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wAnZkVklxQ813dlgNUGMB9tYNgDYp53iDO6sxv7HEMw=;
        b=qmw4AuaNaJURDPUD+ewHQk769wfV9HbD6hXfH7fz4pTVgq92A9ACR/TDpSooO8OpkK
         Ou1skHf6th4IC3JlapxfausW8Shpl8HC5mPvbgDs5RQaDSRIe8x0O4FWKcxkdcVoi3hA
         1AvQS5EqQrN+YEOMDPQ69RHHYQ5n8pvwgF2cYxO5PGsdYzceqATR4jjjFIsj3voans5U
         6VPqLCCXiIj8NkxmlZD6laLuoKksuYEkdS9Z+73di7zetfyzTYsdVDT1Fd9xZbiQej6N
         VlpRJIjqevlevnlFfOPxZpR/NUVp0NwSrU7+CAXn1Qm/kG95H/6NkRz1cjIL4K63OC/u
         t2Tg==
X-Received: by 10.68.36.197 with SMTP id s5mr37481233pbj.23.1370503563022;
 Thu, 06 Jun 2013 00:26:03 -0700 (PDT)
Received: by 10.70.72.133 with HTTP; Thu, 6 Jun 2013 00:26:02 -0700 (PDT)
In-Reply-To: <CAMP44s012ccmaArrTbfy_xNrqbnOjVGTnY+po9cE8JGh_U72Gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226484>

On 5 June 2013 16:45, Felipe Contreras <felipe.contreras@gmail.com> wrote:
> On Tue, Jun 4, 2013 at 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> That might make sense for the shorter term, but in longer term I see
> Perl as declining in favor of other languages. It's only a matter of
> time before Ruby surpasses Perl in popularity, and soon enough new
> contributors to the Git project will have problems trying to improve
> Git because parts of it are written in a language they are not
> familiar with, and have trouble learning (isn't that already
> happening?).
>
> The Ruby vs. Python is another question altogether, I could go into
> detail about why I think Ruby is a better choice, but my point right
> now is that Perl is not a good choice for the future.

Good thing you are being objective and leaving out the Python 3.0
mess, the long legacy of backwards compatibility in the Perl
community, the active community behind it, its extensive portability
support, and fail to mention the lack of an equivalent to CPAN. We
wouldn't want facts to get in the way of a personal bias would we?

Just thought I'd push back on the FUD. People have been saying Perl is
going away for decades...

Yves
