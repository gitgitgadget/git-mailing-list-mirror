From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Git Books
Date: Sat, 6 Dec 2008 13:56:08 +0100
Message-ID: <4d8e3fd30812060456i43d2301clcf4e4724e1962939@mail.gmail.com>
References: <d411cc4a0812060358ub640ea3kd04072c5640eef68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git list" <git@vger.kernel.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 13:57:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8wiw-0004wz-LP
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 13:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655AbYLFM4L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2008 07:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755574AbYLFM4L
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 07:56:11 -0500
Received: from rv-out-0506.google.com ([209.85.198.225]:29684 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755522AbYLFM4K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2008 07:56:10 -0500
Received: by rv-out-0506.google.com with SMTP id k40so415551rvb.1
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 04:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=VQP/gN7DBwlCXExLIGmzACbN9T4GLCh29WThvZRSQHY=;
        b=AGbtVmq4J8yscOzBrhJFVkhwnoCm7/vTmuhAR4NIJht7D4dBMp93rMDrWHlzIgZ5DK
         r4Rkc51mOWO5qvAGhdaXpfb6NZ5NnGhLgpmMw2sqAiqLt6YeQNVMMLv5z04CQXJI7Uuh
         qk1J6+icQMrTeOc1Wkw2+2stnDeNQiKKL5GN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=iu7o8Vq8eMKsvonfXEnMM7cQZQhXncsJWyOi9rAL9AdEdquJ3s91iNvN6oI0kGND+j
         Hxs2UUQ7FFpNGS+JYiJA/UFigeNgwDN+7Cv7EYxToUjigF2BN8SC4qPYh9LBbYpjtfbg
         HaxFMJzL/keheTRNFGXXeYyRrtYcsumy2qVQM=
Received: by 10.143.2.19 with SMTP id e19mr506526wfi.96.1228568168956;
        Sat, 06 Dec 2008 04:56:08 -0800 (PST)
Received: by 10.142.153.14 with HTTP; Sat, 6 Dec 2008 04:56:08 -0800 (PST)
In-Reply-To: <d411cc4a0812060358ub640ea3kd04072c5640eef68@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102451>

On 12/6/08, Scott Chacon <schacon@gmail.com> wrote:
> Hey all,
>
> I have been talked into helping write a real, paper-based book on Git
> for a publisher big enough that you may even see it in your local

> Borders or whatnot.  (And, it appears that Junio has been as well:
> http://gitster.livejournal.com/21616.html)
>
> So, since I'm near the beginning of this process, I was wondering if
> the group had any feedback as to what might be super helpful to
> include.  I mean, I have a pretty good layout and all, but if you
> wanted to point me to some threads that tend to crop up in the mailin=
g
> list and IRC channel from relative newcomers that I might be able to
> nip in the bud, I would like to.  I'm addressing the stuff that _I_
> hear a lot, and I'm scanning the IRC logs and list for topics, but I
> figured many of you must answer the same questions all the time, too.

Please spend lot of words about fetch and pull. These are the most
hard to =F9nderstand commands for people that are used to cvs and svn.

Btw, i would love to see a git in a nutshell book in my native
language (italian).
I'm willing to help writing and translating.


Ciao,
--=20
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
