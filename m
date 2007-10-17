From: Nicolas Pitre <nico@cam.org>
Subject: Re: Deltifying? (was [PATCH 3/6] pack-objects: no delta possible...)
Date: Tue, 16 Oct 2007 22:28:56 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710162224590.19446@xanadu.home>
References: <1192586150-13743-1-git-send-email-nico@cam.org>
 <1192586150-13743-2-git-send-email-nico@cam.org>
 <1192586150-13743-3-git-send-email-nico@cam.org>
 <1192586150-13743-4-git-send-email-nico@cam.org>
 <20071017021555.GP13801@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 04:29:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihyei-0000OS-Nl
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 04:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995AbXJQC26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 22:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbXJQC26
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 22:28:58 -0400
Received: from relais.videotron.ca ([24.201.245.36]:40768 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbXJQC26 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 22:28:58 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQ100MMIAW866F1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 22:28:57 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071017021555.GP13801@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61319>

On Tue, 16 Oct 2007, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> >  			start_progress(&progress_state, "Deltifying objects",
> 
> Totally unrelated to this patch but yesterday a coworker called the
> Grammar Police on me because Git said "Deltifying objects" in their
> console window during a fetch or push operation.  I told them it was
> perfectly valid, they disagreed.  I got free coffee out of the deal.

Whatever is proper English I don't mind, as long as it is short, like a 
single word to describe the action + "objects".

> But still, it bothers some users that we use perhaps less than
> commonly accepted English in an important tool's output.  Seeing it
> in your context just reminded me of that discussion yesterday.

With Git's growing user base, this is becoming more and more common 
though.  ;-)


Nicolas
