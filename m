From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Git in nutshell Inbox
Date: Tue, 9 Jul 2013 19:02:39 +0200
Message-ID: <20130709170239.GC7038@paksenarrion.iveqy.com>
References: <CABpATRsi-Akyv_d4xHsa0AdOdw4_P5VBpoWgx=ViWpA2Q0itPw@mail.gmail.com>
 <vpq4nc3g5l5.fsf@anie.imag.fr>
 <CABpATRt1wffDN7tC3fQpqLcHgf1M6NdhANjx+jxLhN2oa2xEZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Muhammad Bashir Al-Noimi <mbnoimi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 19:02:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwbIf-0007Fq-HC
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 19:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab3GIRB5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 13:01:57 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:57982 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab3GIRB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 13:01:57 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so4901604lbj.14
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 10:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Jx5QpuvqSZcXMdJkPdIbHm++xtRkJVsmIyLu184GfoU=;
        b=cxOvmp/zBmTzauFoYrrpxeNVfP1YOQRT1zfSRYvCkOpylphkubSCAwJnk2YtweEmZa
         5o+IgZkH1yuo1xy6UrBe4TUUnv6JlYsmEe/Tt0Cql1PAmgoSTTaAPN/172p1T14WGB3Z
         1Ai2LWHZi0BvvaBDnSWawiSHKjz2z6dtslOaECFndLyHKwIyGhoSZuqm370aw1oKucFB
         eoiSjKR7Xk5u2gmVC+nEZshUxbtnc7KdAB1OsXpQCXWKEDAv0f53n1QsTIyZMEIcOD9f
         NGILS6Y7dqHeZnNOuvlTr7vASAB7qEYjE26KCSHLeHpldkt7rcHmdTBl4pa3bUUglEfH
         Fn/Q==
X-Received: by 10.152.37.138 with SMTP id y10mr13046322laj.40.1373389315329;
        Tue, 09 Jul 2013 10:01:55 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id rx1sm9376887lbb.0.2013.07.09.10.01.54
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 10:01:54 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UwbJH-0006Ei-3l; Tue, 09 Jul 2013 19:02:39 +0200
Content-Disposition: inline
In-Reply-To: <CABpATRt1wffDN7tC3fQpqLcHgf1M6NdhANjx+jxLhN2oa2xEZQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229968>

On Tue, Jul 09, 2013 at 04:50:20PM +0200, Muhammad Bashir Al-Noimi wrot=
e:
> I tried to use git-cola and found it complicated and not user friendl=
y
> (maybe because I came from Bazaar Explorer) I noticed that it needs
> terminal to be able to work (ex. it can't create new repository). I
> can't even ask for merge modifications (I'm still know nothing in
> git)! so do you know better GUI utility?

You don't need the terminal to create a new repository. When starting
git-cola from a non-git directory you get a menu where you can open an
existing git-repository, clone an existing git-repository or create a n=
ew one.

However I agree with Matthieu that it's easier to understand git from
the command line. Git is developed and mostly used from the command
line. It's the commandline that will give you most controll and most
functionality.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
