From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] Let git-svnimport's author file use same syntax as git-cvsimport's
Date: Thu, 2 Mar 2006 10:20:11 +0100
Message-ID: <20060302092011.GA25041@diana.vm.bytemark.co.uk>
References: <440195D4.7080905@op5.se> <20060227230814.12298.63006.stgit@backpacker.hemma.treskal.com> <1141247993.12729.42.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 02 10:20:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEjyx-0003CQ-Iq
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 10:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWCBJUP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 2 Mar 2006 04:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWCBJUP
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 04:20:15 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:16908 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932092AbWCBJUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 04:20:13 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FEjyl-0006XZ-00; Thu, 02 Mar 2006 09:20:11 +0000
To: Jon Loeliger <jdl@freescale.com>
Content-Disposition: inline
In-Reply-To: <1141247993.12729.42.camel@cashmere.sps.mot.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17059>

On 2006-03-01 15:19:53 -0600, Jon Loeliger wrote:

> On Mon, 2006-02-27 at 17:08, Karl Hasselstr=F6m wrote:
>
> >  	Read a file with lines on the form
> >
> > -	  username User's Full Name <email@addres.org>
> > +	  username =3D User's Full Name <email@addr.es>
> >
> > -	and use "User's Full Name <email@addres.org>" as the GIT
> > +	and use "User's Full Name <email@addr.es>" as the GIT
> >  	author and committer for Subversion commits made by
> >  	"username". If encountering a commit made by a user not in the
> >  	list, abort.
>
> Actually, I believe that "example.com" was reserved specifically for
> instances such as this.

Yes, I know. But email.address@example.com is much longer then
email@addr.es, and not half as funny. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
