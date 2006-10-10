From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Tue, 10 Oct 2006 15:18:53 -0700 (PDT)
Message-ID: <20061010221853.98520.qmail@web31807.mail.mud.yahoo.com>
References: <200610102313.48170.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 00:19:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXPwW-0007aR-Pt
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 00:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbWJJWS4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 10 Oct 2006 18:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030595AbWJJWS4
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 18:18:56 -0400
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:31339 "HELO
	web31807.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030590AbWJJWSy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 18:18:54 -0400
Received: (qmail 98522 invoked by uid 60001); 10 Oct 2006 22:18:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FLUblHpVkL6e14Q2jqFuEF88GjS8D0NsJr0dEY6SdjPeFx6j/HVY6ExSryGrTOFWzOH9saFd/2aVh9NyM3nPVsKb7OQuP6fmaIFtP2TgTJ7mMGwtaeV6INeYXHPFZd33JdXsCCDi76RD/VRHa/jogKZC72YOFNEVRsfQYUmJd64=  ;
Received: from [64.215.88.90] by web31807.mail.mud.yahoo.com via HTTP; Tue, 10 Oct 2006 15:18:53 PDT
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610102313.48170.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28679>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Dnia wtorek 10. pa=EF=BF=BDdziernika 2006 23:02, Luben Tuikov napisa=EF=
=BF=BD:
> > > > Isn't that a simple "labelling" question? =EF=BF=BDI do not thi=
nk
> > > > anybody minds to show clickable string "contents" (instead of
> > > > "blob" or "tree") at the places you mention above and if we did
> > > > so everybody would be happy, right?
> > >=20
> > > Not, IMHO it is not a good idea. Clicking on file name leads to i=
t
> > > contents, but it is not obvoius what kind of view is it. "blob" l=
ink
> >=20
> > It is pretty obvious to me: the contents of the object, whether it =
be
> > "blob" or "tree". =EF=BF=BDThe contents of "blob" and the contents =
of "tree"
> > as shown by gitweb.
>=20
> It's pretty obvous to you, because there is only one basic view of tr=
ee,=20
> and one basic view of blob. It is not the case for example for commit=
s=20
> in shortlog view, where we have commit and commitdiff views. It is=20
> possible that either blobs or trees acquire another views.

Excuse me, weren't we talking about "blob" and "tree"?

How come you all of a sudden introduce commits?  Let's keep on topic:
"blob" and "tree".

   Luben
