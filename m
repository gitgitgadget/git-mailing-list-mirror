From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: editing description of patch
Date: Thu, 4 Oct 2007 10:26:24 +0200
Message-ID: <20071004082624.GA17778@diana.vm.bytemark.co.uk>
References: <9e4733910710031626kff59666y77ba9001c0fef907@mail.gmail.com> <9e4733910710031914r766efa88pad9f55f9495d127e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 10:26:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdM2i-0002V5-Uy
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 10:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbXJDI0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Oct 2007 04:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbXJDI0l
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 04:26:41 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3040 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbXJDI0k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 04:26:40 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IdM2K-0004eB-00; Thu, 04 Oct 2007 09:26:24 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910710031914r766efa88pad9f55f9495d127e@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59929>

On 2007-10-03 22:14:20 -0400, Jon Smirl wrote:

> On 10/3/07, Jon Smirl <jonsmirl@gmail.com> wrote:
>
> > What is the right procedure for editing the various attributes of
> > a stgit patch? patch name, description, etc.... I just emailed a
> > series to myself and the titles/comments are all messed up.
>
> Editing these is done with the stg refresh command.

This is "stg edit" in really new StGits.

> > On my box all of the patches have names -- stg series shows them.
> > But when I emailed them half of the patch didn't have the right
> > subjects.
>
> this is controled in the template files

Anything here you'd characterize as a bug?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
