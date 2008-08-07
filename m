From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH] Documentation: clarify that git-commit only works with
 tracked files
Date: Wed, 6 Aug 2008 20:14:52 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0808062012260.26972@harper.uchicago.edu>
References: <Pine.GSO.4.62.0808061603340.18817@harper.uchicago.edu>
 <20080806214747.GY32057@genesis.frugalware.org>
 <Pine.GSO.4.62.0808061725450.21683@harper.uchicago.edu>
 <Pine.GSO.4.62.0808061906490.24977@harper.uchicago.edu>
 <alpine.DEB.1.00.0808070239120.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Aug 07 03:16:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQu6w-0005lW-Eo
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 03:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754252AbYHGBPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 21:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753591AbYHGBPK
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 21:15:10 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:39910 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbYHGBPI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 21:15:08 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m771Eqsd004840;
	Wed, 6 Aug 2008 20:14:52 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m771EqFY027060;
	Wed, 6 Aug 2008 20:14:52 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <alpine.DEB.1.00.0808070239120.9611@pacific.mpi-cbg.de.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91556>

Hi,

On Thu, 7 Aug 2008, Johannes Schindelin wrote:

> On Wed, 6 Aug 2008, Jonathan Nieder wrote:
> 
> > A user unfamiliar with CVS might not realize that a git-add is
> > needed before commiting new files.
> 
> Funny.  I haven't used CVS for a while now, but I seem to remember that 
> "cvs commit newfile.c" without a prior "cvs add newfile.c" is not allowed.

Yes, this is a closely related statement: a user familiar with CVS should
already know to add. :)

Jonathan
