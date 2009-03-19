From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [RFC] Colorization of log --graph
Date: Thu, 19 Mar 2009 20:32:41 +0100
Message-ID: <200903192032.42117.markus.heidelberg@web.de>
References: <20090318100512.GA7932@linux.vnet> <adf1fd3d0903181004k2554ae90uc101aad64947be7@mail.gmail.com> <279b37b20903181029q7a526168y360874a48783d1dc@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>,
	Eric Raible <raible+git@gmail.com>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 20:35:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkO1H-0006um-MB
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 20:35:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757998AbZCSTcl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 15:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbZCSTcl
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 15:32:41 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:59673 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757152AbZCSTck convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 15:32:40 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id AF991F958065;
	Thu, 19 Mar 2009 20:32:37 +0100 (CET)
Received: from [89.59.125.56] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LkNyn-0003uR-00; Thu, 19 Mar 2009 20:32:37 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <279b37b20903181029q7a526168y360874a48783d1dc@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+0d3zo9PtQcm0xVJsLmFhSE8CZBLqNIAnYpthE
	rjmpmKKArnSV1eXZYXsWubQmTjSKtsJEvzjyTf/cNoE2+EWxCR
	9K8OSc3ivJ2NwWwTPmiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113811>

Eric Raible, 18.03.2009:
> On Wed, Mar 18, 2009 at 10:04 AM, Santi B=E9jar <santi@agolina.net> w=
rote:
> > Gitk paints lines of development (lineal history without merges nor
> > forks) with the same color.
> >
> > HTH,
> > Santi
>=20
> Thanks for the quick reply.  I suppose I realized that but it just
> doesn't seem that profound.
> Don't get me wrong - I like gitk and still prefer it to any of the al=
ternatives.
> But its of color seems more flashy than useful to me.

If scrolling through a history with many branches (so many parallel
lines) like git.git, colors help you to follow a particular line.

I don't find it easy to follow a line in a PCB, where you normally don'=
t
have colors :)

Markus
