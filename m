From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: GSOC 2011: git on Android
Date: Sun, 3 Apr 2011 20:31:12 +0530
Message-ID: <20110403150108.GA1480@kytes>
References: <AANLkTikHieyRYPntivWa51fUBxXCJNzuHGy_AvU++=PN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jgit-dev@eclipse.org
To: =?iso-8859-1?Q?Sebasti=E1n?= Ventura <lomegor@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 17:02:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6Oov-0007j0-9z
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 17:02:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab1DCPCX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 11:02:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51120 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab1DCPCW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 11:02:22 -0400
Received: by iyb14 with SMTP id 14so5137275iyb.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=tSjEA56YLQOal+rhO39e7gY5/qSbFgDOuJnifKAkOKw=;
        b=qhCawCB2jPceqjkVZuFCkkc9vAOgT+fc1Ckubp384M0z6Qd5OKFt1sWKAdu3EUc/Z5
         1aHSqMN2HqBLNNys8di/kqmdzhGoE9EPIkfIlDa1nB2x2QnQUe2BsLOJAcxslXbLNlB3
         TISlUzGbZbShJ2Hvjw9fCvGmQkzlTPKPco+Ck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=boGdgaXtdxb54qWFmk03xNmTHn0ZTnibsD13lbiknwhraCE9p4yXRoi6reVKRsj5kc
         DonQUf2uoGx/KDEoT/eiInqTLUdzNK9LHefg+NyXLAUsSepYgQNWXY0i8dgAcspEwGTo
         IqEuRpihVYI1XDh5cqk9vx65lk0dhv9Okb4mQ=
Received: by 10.42.220.65 with SMTP id hx1mr1859414icb.279.1301842941918;
        Sun, 03 Apr 2011 08:02:21 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id mv26sm3029388ibb.45.2011.04.03.08.02.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 08:02:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikHieyRYPntivWa51fUBxXCJNzuHGy_AvU++=PN@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170696>

Hi Sebasti=E1n,

Sebasti=E1n Ventura writes:
> My name is Sebasti=E1n Ventura and I would like to participate in
> porting git to Android for GSOC 2011. I'm a 22 year old Computer
> Sciences student from Uruguay, and I'd really like to start
> contributing to open source but don't know where to start, and I thin=
k
> helping in this project is something I am able (and willing) to do.
> Therefore I would like to ask the community how can I start helping
> now to better understand the code.  But firstly, do you think this is
> a problem belonging to JGit (for making a native app) or that is
> better suited for this mailing list?

Thanks for writing.  I don't know much about the project, but I hope
this small disucssion on IRC will point you in the right direction
[1].  You should also try asking Shawn and the JGit community about
this.

> Besides that, and even if I don't enter GSOC, I want to help in an
> Open Source project, so how can I help now? Is there any small proble=
m
> that you think I can resolve?

We don't have an official bug tracker, but there are plenty of small
tasks you can pick up from threads on the mailing list [2], or from
various distributions' bug trackers (like Debian BTS).  Idally, it
would be nice if you work on a feature/ bugfix that you'd personally
like to see.

-- Ram

[1]: http://colabti.org/irclogger/irclogger_log/git-devel?date=3D2011-0=
3-31#l323
[2]: http://article.gmane.org/gmane.comp.version-control.git/170670
