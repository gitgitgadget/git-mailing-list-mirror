From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Tue, 8 May 2007 08:40:27 -0400
Message-ID: <20070508124027.GA14366@fieldses.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705062344230.29485@reaper.quantumfyre.co.uk> <20070507063505.GA31269@diana.vm.bytemark.co.uk> <20070508014114.GC11311@spearce.org> <464023A1.6618BC0A@eudaptics.com> <20070508102836.GB27119@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 08 14:40:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlOzg-0004eD-3S
	for gcvg-git@gmane.org; Tue, 08 May 2007 14:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934533AbXEHMkg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 8 May 2007 08:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934535AbXEHMkg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 08:40:36 -0400
Received: from mail.fieldses.org ([66.93.2.214]:52406 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934533AbXEHMkf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 08:40:35 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HlOzT-0004Hb-CZ; Tue, 08 May 2007 08:40:27 -0400
Content-Disposition: inline
In-Reply-To: <20070508102836.GB27119@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46574>

On Tue, May 08, 2007 at 12:28:36PM +0200, Karl Hasselstr=F6m wrote:
> I think it would be worth introducing git-gui as a commit tool in the
> tutorial(s) and the manual. It gives a very nice graphical
> representation of the dirty state you're going to commit, and the
> dirty state you aren't going to commit because you haven't staged it
> yet. The only drawback is that it's a lot of work to make
> documentation with screenshots ...

You could put that on a web page someplace.

=46or the tutorial and user manual, could git-gui be treated similar gi=
tk,
with just a one- or two- line mention here and there?  I haven't used
it, so don't know where it would most logically fit in....

--b.
