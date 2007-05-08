From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Tue, 8 May 2007 12:28:36 +0200
Message-ID: <20070508102836.GB27119@diana.vm.bytemark.co.uk>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705062344230.29485@reaper.quantumfyre.co.uk> <20070507063505.GA31269@diana.vm.bytemark.co.uk> <20070508014114.GC11311@spearce.org> <464023A1.6618BC0A@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue May 08 12:30:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlMxV-0002t1-88
	for gcvg-git@gmane.org; Tue, 08 May 2007 12:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966442AbXEHK2o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 06:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966443AbXEHK2o
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 06:28:44 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2888 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966442AbXEHK2n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 06:28:43 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HlMvs-0007F7-00; Tue, 08 May 2007 11:28:36 +0100
Content-Disposition: inline
In-Reply-To: <464023A1.6618BC0A@eudaptics.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46562>

On 2007-05-08 09:15:45 +0200, Johannes Sixt wrote:

> "Shawn O. Pearce" wrote:
>
> > But I'm glad someone else finds the hunk feature useful in
> > git-gui. I use it far too often myself.
>
> It it among the most-wanted features here. We discovered it only
> because Karl mentioned it yesterday. ;)

See? Who said spamming doesn't work? :-)

I think it would be worth introducing git-gui as a commit tool in the
tutorial(s) and the manual. It gives a very nice graphical
representation of the dirty state you're going to commit, and the
dirty state you aren't going to commit because you haven't staged it
yet. The only drawback is that it's a lot of work to make
documentation with screenshots ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
