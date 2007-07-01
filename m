From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH 0/6] New and improved DAG appliedness series
Date: Sun, 1 Jul 2007 16:35:50 +0200
Message-ID: <20070701143550.GA23196@diana.vm.bytemark.co.uk>
References: <20070518063015.GA13516@diana.vm.bytemark.co.uk> <20070610094322.12000.56284.stgit@bill> <20070630195451.GL7730@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Jul 01 16:36:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I50X4-0004n1-Ad
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 16:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001AbXGAOgI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 1 Jul 2007 10:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754908AbXGAOgH
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 10:36:07 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3773 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001AbXGAOgG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 10:36:06 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1I50Wk-00063y-00; Sun, 01 Jul 2007 15:35:50 +0100
Content-Disposition: inline
In-Reply-To: <20070630195451.GL7730@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51300>

On 2007-06-30 21:54:51 +0200, Yann Dirson wrote:

> On Sun, Jun 10, 2007 at 02:54:47AM -0700, Karl Hasselstr=F6m wrote:
>
> > This took a while, but here it is. (Actually, I finished this
> > about a week ago, but had no Internet connection so I couldn't
> > send it.)
>
> Is this the latest version of the DAG patches, or is there maybe a
> public repo where you push your work ?

This is the latest version, and no, I don't yet have a public repo
that I push this stuff to.

I've been travelling a lot the last few weeks, and I'm not quite done
yet, so I haven't had time to even follow the mailing list properly,
but after that I plan to start a pu-ish (rebasing) integration branch
for the patches that I, you, and others post to the list.

> It happens that my refactorings touches virtually everything,

I noticed. :-)

> so there will be conflicts,

:-)

> and the best thing to do is probably that I rebase my work on yours.

Thanks for the vote of confidence. Please go ahead; as I said, you
already have the latest version of my series, and it may be a while
yet before I have much time to burn on StGIT.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
