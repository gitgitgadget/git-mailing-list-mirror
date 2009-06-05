From: "Kelly F. Hickel" <kfh@mqsoftware.com>
Subject: RE: Best way to merge two repos with same content, different history
Date: Fri, 5 Jun 2009 12:10:30 -0500
Message-ID: <63BEA5E623E09F4D92233FB12A9F794303117DC1@emailmn.mqsoftware.com>
References: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com> <286817520906050953n1afed29cn6c85f219a0c9b8b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Rostislav Svoboda" <rostislav.svoboda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 19:10:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCcwD-00083V-IU
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 19:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbZFERKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 13:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbZFERKa
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 13:10:30 -0400
Received: from mail.de.mqsoftware.com ([66.192.70.108]:20487 "EHLO
	emailmn.mqsoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbZFERKa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 13:10:30 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <286817520906050953n1afed29cn6c85f219a0c9b8b5@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Best way to merge two repos with same content, different history
Thread-Index: Acnl/jfNSb9CgHQqTn2NanVoDVglBgAAhbdg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120812>


> -----Original Message-----
> From: Rostislav Svoboda [mailto:rostislav.svoboda@gmail.com]
> Sent: Friday, June 05, 2009 11:54 AM
> To: Kelly F. Hickel
> Cc: git@vger.kernel.org
> Subject: Re: Best way to merge two repos with same content, different
> history
>=20
> On Fri, Jun 5, 2009 at 18:30, Kelly F. Hickel<kfh@mqsoftware.com>
> wrote:
> > =A0 =A0 =A0 =A0We're converting out of CVS after 10 years... The cv=
s2git
> > conversion takes around 4-5 days, and there doesn't seem to be any
> way
> > to speed that up.
>=20
> try google:
> "cvs2git migration - cloning CVS repository"
>=20
> Bost

Bost,=20
	Thanks, but I'm already working with a local copy of the CVS repo.  I'=
ve corresponded with Michael Haggerty about the time this takes, and th=
ere just doesn't seem to be any way to improve the speed, without makin=
g some fairly drastic changes to cvs2git.

Thanks,
Kelly
