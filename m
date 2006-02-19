From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/2] Add 'stg uncommit' command
Date: Sun, 19 Feb 2006 14:45:58 +0100
Message-ID: <20060219134558.GA4784@diana.vm.bytemark.co.uk>
References: <20060217042728.14175.39928.stgit@backpacker.hemma.treskal.com> <20060217043128.14175.60168.stgit@backpacker.hemma.treskal.com> <43F84D9A.2010905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 19 14:46:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAotM-00034l-Nx
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 14:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbWBSNqD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 19 Feb 2006 08:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932436AbWBSNqD
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 08:46:03 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:26632 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932435AbWBSNqC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 08:46:02 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FAosw-0001Fr-00; Sun, 19 Feb 2006 13:45:58 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <43F84D9A.2010905@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16437>

On 2006-02-19 10:51:06 +0000, Catalin Marinas wrote:

> Karl Hasselstr=F6m wrote:
>
> > diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.p=
y
> > new file mode 100644
> > index 0000000..4ac0dfb
> > --- /dev/null
> > +++ b/stgit/commands/uncommit.py
> > @@ -0,0 +1,80 @@
> > +__copyright__ =3D """
> > +Copyright (C) 2006, Catalin Marinas <catalin.marinas@gmail.com>
>
> I added your name on the copyright since this is a new file.

I did that too at first, but then I changed it back since I reckoned
more than 50% of the file was copy-pasted from elsewhere. But thanks.
:-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
