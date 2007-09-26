From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] User Manual: document import-tars.perl
Date: Wed, 26 Sep 2007 16:37:36 -0400
Message-ID: <20070926203736.GC26099@fieldses.org>
References: <20070925201306.GW30845@fieldses.org> <1190759824-18896-1-git-send-email-vmiklos@frugalware.org> <20070926181451.GA20976@fieldses.org> <20070926182204.GB14959@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 22:38:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaddz-0004hj-UH
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 22:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbXIZUh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 16:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810AbXIZUh4
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 16:37:56 -0400
Received: from mail.fieldses.org ([66.93.2.214]:53484 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbXIZUh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 16:37:56 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IaddY-00005z-R1; Wed, 26 Sep 2007 16:37:36 -0400
Content-Disposition: inline
In-Reply-To: <20070926182204.GB14959@genesis.frugalware.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59246>

On Wed, Sep 26, 2007 at 08:22:04PM +0200, Miklos Vajna wrote:
> On Wed, Sep 26, 2007 at 02:14:51PM -0400, "J. Bruce Fields" <bfields@fieldses.org> wrote:
> > Neat-o, I'd missed (or forgotten about) import-tars.perl.
> > 
> > But I'd prefer to keep this first explanation of how to initialize and
> > commit to a new project pretty streamlined, and I don't think this is
> > really necessary here.  So let's save this up until we have enough
> > material for a separate chapter or section on interacting with other
> > scm's.
> 
> okay, now it's saved by gmane :)

Also in my git tree--I took yours and Johannes' suggestions, put them in
a blender, and added a brief skeleton of a new chapter at:

	git://linux-nfs.org/~bfields/git.git docwork-foreign-scms

--b.
