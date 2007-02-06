From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-fast-import
Date: Tue, 06 Feb 2007 16:42:48 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702061641040.13009@xanadu.home>
References: <20070206023111.GB9222@spearce.org>
 <Pine.LNX.4.64.0702052248070.19212@xanadu.home>
 <20070206054808.GA10508@spearce.org>
 <Pine.LNX.4.64.0702060829310.8424@woody.linux-foundation.org>
 <20070206165630.GB4949@spearce.org>
 <Pine.LNX.4.64.0702060913220.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702061329090.19212@xanadu.home>
 <20070206200924.GA5352@spearce.org>
 <Pine.LNX.4.64.0702061559160.13009@xanadu.home>
 <20070206211547.GB5820@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 22:42:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEY5V-0002vr-Pg
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 22:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965524AbXBFVmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 16:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933305AbXBFVmu
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 16:42:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8829 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933300AbXBFVmt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 16:42:49 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JD200EAM9NCA870@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Feb 2007 16:42:48 -0500 (EST)
In-reply-to: <20070206211547.GB5820@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38876>

On Tue, 6 Feb 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > I think you should call it something else than rfc2822.  Because 
> > parse_date() accepts much more than just rfc2822.  What about "cooked"?
> 
> It does accept a lot more than that, but straying away from rfc2822
> gets into the grey areas of parse_date().

OK that makes sense.


Nicolas
