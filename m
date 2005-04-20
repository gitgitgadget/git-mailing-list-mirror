From: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Subject: Re: Git hangs while executing commit-tree
Date: Wed, 20 Apr 2005 22:38:21 +0100
Message-ID: <200504202238.21763.rhys@rhyshardwick.co.uk>
Reply-To: rhys@rhyshardwick.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Apr 20 23:35:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOMpt-0001NS-3X
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 23:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVDTVib convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 20 Apr 2005 17:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbVDTVib
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 17:38:31 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:31652 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261821AbVDTViY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 17:38:24 -0400
Received: from unknown (HELO mail.rhyshardwick.co.uk) (rhys?hardwick@81.103.65.153 with plain)
  by smtp001.mail.ukl.yahoo.com with SMTP; 20 Apr 2005 21:38:23 -0000
Received: from [192.168.1.40] (helo=metatron.rhyshardwick.co.uk)
	by mail.rhyshardwick.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1DOMtq-0006zl-4h
	for git@vger.kernel.org; Wed, 20 Apr 2005 22:38:22 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Cheers for the help!

Rhys

On Wednesday 20 Apr 2005 22:35, Petr Baudis wrote:
> Dear diary, on Wed, Apr 20, 2005 at 11:28:35PM CEST, I got a letter
> where Rhys Hardwick <rhys@rhyshardwick.co.uk> told me that...
>
> > Hey,
>
> Hi,
>
> > rhys@metatron:~/repo/tmp.repo$ commit-tree
> > c80156fafbac377ab35beb076090c8320f874f91
> > Committing initial tree c80156fafbac377ab35beb076090c8320f874f91
> >
> >
> >
> > At this point, the command seems to be just waiting. =A0I have had =
it
> > waiting for around 2 hours now! =A0I have tried removing ~/repo/tmp=
=2Erepo
> > and starting over, with exactly the same results.
>
> just type in your commit message and press ctrl-D now. ;-)
>
> If you can't get along by peeking at the source when you get stuck, e=
tc,
> you might prefer using git-pasky (http://pasky.or.cz/~pasky/dev/git/)=
,
> which will guide you nicely.
=0D
