From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Fri, 7 Jun 2013 14:10:12 -0500
Message-ID: <CAMP44s0UkmVc7kLo6vD2=Cn-SN+mFrGO_udJcbhC-h=0yx_pqQ@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
	<7va9n52zjc.fsf@alter.siamese.dyndns.org>
	<rmivc5rp9w2.fsf@fnord.ir.bbn.com>
	<alpine.DEB.1.00.1306061818191.28957@s15462909.onlinehome-server.info>
	<CALkWK0n2VsEP31jMB2kZ4x=wa90o8QPkR=ZWETfm=H5RC1kKcg@mail.gmail.com>
	<alpine.DEB.1.00.1306070518510.28957@s15462909.onlinehome-server.info>
	<CALkWK0nUoF2VX6Ns09vQHYo11520_4r9ikYmkZW108aQm1RpoQ@mail.gmail.com>
	<vpqhah9248u.fsf@anie.imag.fr>
	<CALkWK0mLVxKGvvYmREFyEkp6CgWuOEmML5V4ajF8R0SK62D4Gg@mail.gmail.com>
	<vpqip1pzs9d.fsf@anie.imag.fr>
	<CALkWK0=mthyNQz9o6vG0b_yEMVL3GsB-dppNt6xgWTdUQQ5Zqw@mail.gmail.com>
	<vpq8v2lycd1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Greg Troxel <gdt@ir.bbn.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	=?UTF-8?B?Tmd1ecKtbiBUaMOhaSBOZ8O3Yw==?= <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 07 21:10:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul23I-00078o-VZ
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 21:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757094Ab3FGTKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 15:10:15 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:62510 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177Ab3FGTKO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 15:10:14 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so4057340lab.1
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 12:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=95FtK2yLl86I8YNc/cjYNC9jQR0rxgKqI6EMQrU77cg=;
        b=mago/YEHx9XUiECe1Cgx9/8sHG4XcVsew+Ld2ikWzdjj3y4HWjRH3KuUCPeXTpzRXI
         15Y9WI6m3bU++AAUX6VJx94YjdLuXhG3vgDbbbVs9gTUi6F3LtLzn2MvSX3umxH7Ij72
         Z/G6z7hyQ7mOUcC9ckiDQGek1oQrvBubRf8TMqdvZjFJAqL8fGNvtXGt1Wz8hthK9HhA
         DoMvGIjkkDcMz3jIcfKV8pmzmRce9IA1kNzdjI0QjHRoXjJB9sn4637+Fzui5uZtJuD9
         eCPgkLccizTPUSYZDR6vyDyBCyMjjVuEK+5cH4eBv/l9sgNY2ax2+3dO1mcKYHE8K4cJ
         iHhA==
X-Received: by 10.152.26.225 with SMTP id o1mr33972lag.43.1370632212196; Fri,
 07 Jun 2013 12:10:12 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 12:10:12 -0700 (PDT)
In-Reply-To: <vpq8v2lycd1.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226675>

On Fri, Jun 7, 2013 at 2:00 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>>> Whether it's based on POSIX is an implementation detail for the user.
>>> The real question is more command-line Vs GUI than POSIX/Win32. Some
>>> Linux users like GUI, some windows users use command-line. I tried IDE
>>> integration with EGIT, and quite frankly I ended-up doing all the Git
>>> stuff in a terminal next to Eclipse.
>>
>> I see.  But isn't it possible to implement a CLI in libgit2 too, no?
>
> Yes (there have actually been several attempts at this like
> https://github.com/Romain-Geissler/git2 and
> https://github.com/vfr-nl/git2/), but there are a *lot* of stuff that
> are in git.git and not in libgit2.
>
> I'd love to see Git re-implemented on top of libgit2, but that's not
> going to happen tomorrow :-\.

Specially not if we *always* keep the status quo, and don't make
better use of C and scripting languages. One of the advantages of Ruby
is that it can be very easily extended from C. I have never seen an
easier way to write bindings than in Ruby. If we allowed Ruby to be in
the core, it would make sense to create official Ruby bindings, and
that would create an enormous motivation for libigit/libgit2 to be
complete.

But if we always keep the status quo, there will never be that much
motivation for such an effort.

-- 
Felipe Contreras
