From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Thu, 25 Oct 2007 08:10:54 +0200
Message-ID: <20071025061054.GA23052@diana.vm.bytemark.co.uk>
References: <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> <Pine.LNX.4.64.0710221156540.25221@racer.site> <8fe92b430710231906l35606fe2j2b7c28ed6f4dd1a3@mail.gmail.com> <20071024102950.GA3908@diana.vm.bytemark.co.uk> <8fe92b430710240404u202521d4g2275bc4886956807@mail.gmail.com> <20071024113123.GB6459@diana.vm.bytemark.co.uk> <8fe92b430710241627v3ec51b20qf0b4e60356336363@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 08:11:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkvwC-0003T7-Nj
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 08:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852AbXJYGLL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Oct 2007 02:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753343AbXJYGLL
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 02:11:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2868 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbXJYGLK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 02:11:10 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ikvvi-00060l-00; Thu, 25 Oct 2007 07:10:54 +0100
Content-Disposition: inline
In-Reply-To: <8fe92b430710241627v3ec51b20qf0b4e60356336363@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62277>

On 2007-10-25 01:27:10 +0200, Jakub Narebski wrote:

> On 10/24/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2007-10-24 13:04:01 +0200, Jakub Narebski wrote:
> >
> > > By the way, there is SRPM for StGIT in
> > > http://homepage.ntlworld.com/cmarinas/stgit/ (I need it because
> > > I have Python 2.4), but it is not listed on downloads page...
> >
> > I'll leave the webpage question to Catalin, but I'm curious about
> > the Python version remark. What exactly is the problem?
>
> If I remember correctly the StGIT RPM requires python 2.5 (and is
> build using python 2.5, so install with --force doesn't work).

Hmm. That's overkill, considering that only 2.4 is actually required
(and until recently, we tried to be careful to only require 2.3).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
