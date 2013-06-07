From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 23:54:03 +0530
Message-ID: <CALkWK0mLVxKGvvYmREFyEkp6CgWuOEmML5V4ajF8R0SK62D4Gg@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org>
 <rmivc5rp9w2.fsf@fnord.ir.bbn.com> <alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
 <CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
 <alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
 <CALkWK0nUoF2VX6Ns09vQHYo11520_4r9ikYmkZW108aQm1RpoQ@mail.gmail.com> <vpqhah9248u.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:25:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1LR-0008UH-Dk
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756282Ab3FGSYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 14:24:45 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:48184 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031Ab3FGSYo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 14:24:44 -0400
Received: by mail-ie0-f177.google.com with SMTP id u16so11390144iet.22
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9rrMhJaoJ4VL8dMe3T5aLnwYEV1XA2bk73REA5EANNM=;
        b=dbJnSeGFVwhPf8Xw5K55LhdkR0GXjwCqrfYcJBv+VtIxADFq2KDIDeXsh96yp+xSSw
         qfIJT2/Ipjnfzxj3+dBoqxajMM850WUG7noHOiR9VDMffDqnaMVcucYam96qFZSJyXe6
         34uGr8cI/1n1h9N/7RURGoX1RdPbxpuNdQzQFAeLkLmQOdpoLD3o8SZ7dUv+6KuS0YJk
         mX8j8OHSApS03coKZx+gyg2j7uWuT4ZHqQsd/EIIMTEa1DeyuX+51qcxnIPSpfnuYy8W
         7IhykeortlYAYFrlfqmbW8MgN9oKtWs5YIbBNXMo4dJAxAADoeYrD64+YV+YFxYa/CPw
         AM7w==
X-Received: by 10.42.31.69 with SMTP id y5mr19464658icc.44.1370629484189; Fri,
 07 Jun 2013 11:24:44 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Fri, 7 Jun 2013 11:24:03 -0700 (PDT)
In-Reply-To: <vpqhah9248u.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226659>

Matthieu Moy wrote:
> I think it should be "the Git for Windows community", and my feeling is
> that the community developing Git for POSIX systems is far more active
> than the one making it work for Windows (although we may now have more
> windows users than unix users).

If I can be excused for being frank, and saying something potentially
blasphemous:

I think he way forward on Windows is an implementation like libgit2 or
git# with some sort of gui/ide integration.  I never understood why
users on Windows want to use something as POSIX'y as git.git.
Wouldn't they prefer some visual-studio integration thing? *scratches
head*
