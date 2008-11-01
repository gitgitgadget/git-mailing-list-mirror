From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Sat, 1 Nov 2008 15:57:14 -0700
Message-ID: <20081101225714.GD15463@spearce.org>
References: <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <7viqr873x7.fsf@gitster.siamese.dyndns.org> <20081031234115.GD14786@spearce.org> <alpine.DEB.1.10.0810311738100.5851@asgard.lang.hm> <20081101010011.GG14786@spearce.org> <alpine.DEB.1.10.0810311802360.5851@asgard.lang.hm> <20081101010824.GE29036@artemis.corp> <alpine.LFD.2.00.0810312121000.13034@xanadu.home> <20081101014336.GI14786@spearce.org> <alpine.LFD.2.00.0810312150200.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, david@lang.hm,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 23:58:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwPQM-00022k-Tf
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 23:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbYKAW5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 18:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751619AbYKAW5Q
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 18:57:16 -0400
Received: from george.spearce.org ([209.20.77.23]:56258 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbYKAW5P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 18:57:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C855B3835F; Sat,  1 Nov 2008 22:57:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810312150200.13034@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99786>

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 31 Oct 2008, Shawn O. Pearce wrote:
> 
> > My take on the consensus for the license part of the discussion is
> > that libgit2 should be under the "GPL gcc library" license.
> > 
> > BTW, I can't actually find a copy of that license; the only thing
> > I can locate in the GCC SVN tree is a copy of the LGPL.
> 
> The exception is usually found at the top of files constituting 
> libgcc.a.  One example is gcc/config/arm/ieee754-df.S.  ;-)

Headers updated.  Its now GPL+gcc library exception.

Not that the 5 lines of useful code there really needs copyright,
but hey, whatever.

-- 
Shawn.
