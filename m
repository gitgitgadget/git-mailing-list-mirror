From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: 1.6.0: where is git-gui?
Date: Thu, 21 Aug 2008 12:41:23 -0700
Message-ID: <20080821194123.GX3483@spearce.org>
References: <20080820172038.GD10819@cs-wsok.swansea.ac.uk> <7v3akzpeer.fsf@gitster.siamese.dyndns.org> <86r68i3ct6.fsf@lola.quinscape.zz> <20080821193915.GK10819@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
X-From: git-owner@vger.kernel.org Thu Aug 21 21:43:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWG3j-00064K-E9
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 21:43:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760626AbYHUTl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 15:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756593AbYHUTlZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 15:41:25 -0400
Received: from george.spearce.org ([209.20.77.23]:51833 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760626AbYHUTlY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 15:41:24 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A55FF38375; Thu, 21 Aug 2008 19:41:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080821193915.GK10819@cs-wsok.swansea.ac.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93191>

Oliver Kullmann <O.Kullmann@swansea.ac.uk> wrote:
> I've read the release notes, but it didn't occur
> to me that "git-gui" is part of "git" --- I assumed
> it would be, like "gitk", a different program (which
> just be chance is using the same naming convention
> like "git-clone" etc.).

Well, it really is a separate program, just like gitk is.

But its name being "git-gui" and not "gitgui" is not by
accident.  I chose it to fit into the "git foo" naming
scheme used by the core tools, so it fit better into the
overall user experience.  Ditto with "git citool".

-- 
Shawn.
