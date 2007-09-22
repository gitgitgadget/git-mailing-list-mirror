From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: C++ *for Git*
Date: Sun, 23 Sep 2007 10:24:56 +1200
Message-ID: <46a038f90709221524yf4900camf09c7870c09f8467@mail.gmail.com>
References: <ABE0ABE82AE84593A2B71B0281F4C814@ntdev.corp.microsoft.com>
	 <46F5318A.4030103@krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: "Kyle Rose" <krose@krose.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 00:25:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZDPM-0000lV-Af
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 00:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbXIVWY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 18:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbXIVWY7
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 18:24:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:33865 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbXIVWY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2007 18:24:58 -0400
Received: by ug-out-1314.google.com with SMTP id z38so653144ugc
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7dyVjm4L+/e1biUwrPQdSwX0hiCZcveLPEAbO9RUCJw=;
        b=U12QTKtSOazCToThq4V4RZNzM95fEeRMntLJOv6wIcJPeMK2JlQ2EXZYSQIhmYVkycKqi0rky9DfsG3CKAdm5ab8MlVbtfTUWLqw0UenXDMiJPRWi/hcu0fMo4mWK+r13el3cvLTkrO5IwX7hT1LJAl0yA+l4Qgw4wzXBg6aVyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Eu/uBG/xl1G6TM1d56kziA6w8yvi739et0BdXHC/T3iBerWy5GXnawYj+8N+uXxKb+WroxLrpdBzioFsm//pSrNmhSBXOVCZCDV04X52KRp0vgMZAZbMGYVo1IeGOV0P58bnN2XI46lvOl9FsebGU8NBJctqV/NI8PSFQOhCuYs=
Received: by 10.67.22.2 with SMTP id z2mr6044942ugi.1190499896602;
        Sat, 22 Sep 2007 15:24:56 -0700 (PDT)
Received: by 10.67.23.15 with HTTP; Sat, 22 Sep 2007 15:24:56 -0700 (PDT)
In-Reply-To: <46F5318A.4030103@krose.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58944>

On 9/23/07, Kyle Rose <krose@krose.org> wrote:
> But that's irrelevant: git is written in C.  That's the way it is, and
> you should accept that or fork.

Or - as Marco's done - write complementary bits to git. I'm a
Perl-head, and I've ended up writing bits of Perl for git, some of
them have been reimplemented in C, some have stayed in Perl.

Arguing is a waste of time -- code! Help Marco, or write something new
and glorious. Make it useful for people who don't care what it's
written in, and beautiful so that the infidels are enlightened with
how elegant C++ can be.

Codefest > Flamefest

cheers,



m
