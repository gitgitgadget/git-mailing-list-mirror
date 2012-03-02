From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Update l10n guide
Date: Fri, 02 Mar 2012 06:56:12 -0800 (PST)
Message-ID: <m362enuk53.fsf@localhost.localdomain>
References: <CANYiYbGS_cFTHT1Pkafi9dmzedqezTq8k1tPkYur0b2St_c43Q@mail.gmail.com>
	<7v1upew6d0.fsf@alter.siamese.dyndns.org>
	<7vfwduujxw.fsf_-_@alter.siamese.dyndns.org>
	<CANYiYbE5rcnD_VGJyL2CjS-R5E0pyNSd5TetvH849W6wC5JiAA@mail.gmail.com>
	<7vk434q4eg.fsf@alter.siamese.dyndns.org>
	<CANYiYbE7bxz5=h9gaKf6+N6k5cn6mEKnuf_7KPFAnDrC31UL_w@mail.gmail.com>
	<4F50A55E.8040705@viscovery.net>
	<CANYiYbG-Gp0cELF7_CxT1veRod+ookBaucfjCpWZjK1kTC0sAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 15:56:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3Tu8-00043Q-MM
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 15:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757216Ab2CBO4P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Mar 2012 09:56:15 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59708 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755734Ab2CBO4O convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Mar 2012 09:56:14 -0500
Received: by eekc41 with SMTP id c41so644469eek.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 06:56:13 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.101.141 as permitted sender) client-ip=10.14.101.141;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.101.141 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.101.141])
        by 10.14.101.141 with SMTP id b13mr6149848eeg.92.1330700173586 (num_hops = 1);
        Fri, 02 Mar 2012 06:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=2zB++rCpZYHF2lEzCh8RNO9dzBD6VeXsRr2S7hLqtWE=;
        b=RiJQVgAqzTfyYiNQtyEIrYVwdAuzxIBrKo0oOewFFG2LFR1IKxtRrpY4udsssEgqto
         OjfHzcb4j7dZF6GvCH0CzyTJiLQ3WXFta+wulliOpcWinxbZfSNMvngLM+aQVFWNQylQ
         pqfW5eRaw4lhCE4aBjEImnl0X+mcM4GV+++ilZjr0sClLH43IbYN7pkClvTrW82dRdBR
         ut9P/54cW0gcLFHlhFF6KHWhVo3ezaS10BIa4J11j4lg9WNCeKU0+3kGVPak+ZEYvYKa
         UfyhYG8EOZGeUC548EXeYuMcLpgU7y1uyL94GrBHaZIsQK+ebtCo0QsvoVhZ3e8WYORm
         Kuhg==
Received: by 10.14.101.141 with SMTP id b13mr4719122eeg.92.1330700173349;
        Fri, 02 Mar 2012 06:56:13 -0800 (PST)
Received: from localhost.localdomain (abvt148.neoplus.adsl.tpnet.pl. [83.8.217.148])
        by mx.google.com with ESMTPS id y14sm21115345eef.10.2012.03.02.06.56.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 06:56:12 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q22EuAMU019299;
	Fri, 2 Mar 2012 15:56:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q22Eu90B019296;
	Fri, 2 Mar 2012 15:56:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CANYiYbG-Gp0cELF7_CxT1veRod+ookBaucfjCpWZjK1kTC0sAQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192048>

Jiang Xin <worldhello.net@gmail.com> writes:
> 2012/3/2 Johannes Sixt <j.sixt@viscovery.net>:

> > It does not convert, but it records which encoding the text has. If=
 you
> > don't specify anything, UTF-8 is assumed, and if your text is actua=
lly not
> > UTF-8, the result is necessarily garbage.
> >
> > Then you haven't set i18n.commitEncoding. Try this:
> >
> > =A0 git config i18n.commitEncoding CP936
>=20
> I know there are two config variables. i18n.commitEncoding will inser=
t
> a "encoding XX" line to the commit object, while i18n.logOutputEncodi=
ng
> will set the default output encoding.

Note that according to documentation 'git commit' issues a warning if
the commit log message given to it does not look like a valid UTF-8
string, unless you explicitly say your project uses a legacy encoding.
Modern git would also warn if you have NUL ("\0") character in your
commit message, e.g. when using UCS-2 / UTF-16 encoding.

> But this implementation seems like a workaround.
>=20
> * Tree objects do not have such implementation, so multibyte characte=
rs
>   can not be used as filenames.

And there is no place on pathnameEncoding in 'tree' object,
unfortunately.

One proposed solution was to convert filenames from filesystem
encoding to normal-form composed UTF-8 when creating tree objects, but
this would have to be optional.

Anyway at least for source code using characters outside US-ASCII is
really discouraged anyway.  Note also that sample 'pre-commit' hook
prevents adding files with non-ascii filenames.
=20
> * Commit object without "encoding" instruction will be used as it is.=
 So
>   people under the same non-utf8 locale may not notice that they
>   have not set the proper i18n.commitEncoding, until one day they
>   need accross platform development.

But see above.
=20
> * As raw commit log alway used as fallback, sometimes it is hard to f=
ind
>   commit objects with wrong encoding instructions.
>=20
> I think save commit object, tree object, packed-refs in UTF-8 is
> a better implementation.

Backward compatibiltiyt and performance.

--=20
Jakub Narebski
