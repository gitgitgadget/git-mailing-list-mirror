From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] tutorial.txt renamed
Date: Wed, 7 Jan 2009 07:07:35 +0100
Message-ID: <200901070707.36263.chriscool@tuxfamily.org>
References: <20090107042337.GA24735@gnu.kitenet.net> <200901070628.38019.chriscool@tuxfamily.org> <DA6E1A83-FFBA-46BC-9BCF-ED8A2D8F12E7@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 07:09:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKRaQ-0005uL-SZ
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 07:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752822AbZAGGGv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jan 2009 01:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752757AbZAGGGv
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 01:06:51 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:32843 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbZAGGGu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 01:06:50 -0500
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 9C5D64C80C0;
	Wed,  7 Jan 2009 07:06:43 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id B7BC54C8027;
	Wed,  7 Jan 2009 07:06:40 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <DA6E1A83-FFBA-46BC-9BCF-ED8A2D8F12E7@silverinsanity.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104760>

Le mercredi 7 janvier 2009, Brian Gernhardt a =E9crit :
> On Jan 7, 2009, at 12:28 AM, Christian Couder wrote:
> > Le mercredi 7 janvier 2009, Joey Hess a =E9crit :
> >> diff --git a/README b/README
> >> index 548142c..5fa41b7 100644
> >> --- a/README
> >> +++ b/README
> >> @@ -24,7 +24,7 @@ It was originally written by Linus Torvalds with
> >> help
> >> of a group of hackers around the net. It is currently maintained b=
y
> >> Junio
> >> C Hamano.
> >>
> >> Please read the file INSTALL for installation instructions.
> >> -See Documentation/tutorial.txt to get started, then see
> >> +See Documentation/gittutorial.txt to get started,
> >
> > "man gittutorial" and "git help tutorial" should work to display th=
e
> > tutorial, so perhaps we should advise to use them instead of the
> > source,
> > since we are advising to use "man git-commandname" below to get hel=
p
> > on
> > each command.
>
> This is the README file for the project, so it should advise looking
> at the Documentation directory as neither the man pages or git comman=
d
> are likely installed at this point.

Well, this is debatable, because we first ask the user to read the INST=
ALL=20
file, and a tutorial for git may not be very usefull if you don't have =
it=20
installed to try out the tutorial commands.

Regards,
Christian.
