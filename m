From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [ANNOUNCE] Guilt 0.16
Date: Sat, 6 Jan 2007 17:14:02 -0500
Message-ID: <20070106221402.GA22162@filer.fsl.cs.sunysb.edu>
References: <20070106184639.GC12543@filer.fsl.cs.sunysb.edu> <200701061957.l06JvVbP007499@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 23:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Jnv-0000YP-7D
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 23:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbXAFWOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 17:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbXAFWOM
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 17:14:12 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:33901 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932248AbXAFWOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 17:14:11 -0500
Received: from filer.fsl.cs.sunysb.edu (IDENT:Isl1KSXc/yaB5B/DtSA9rg5ZkfWaLOCY@localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l06ME3pE023079;
	Sat, 6 Jan 2007 17:14:03 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l06ME2G4023077;
	Sat, 6 Jan 2007 17:14:02 -0500
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Content-Disposition: inline
In-Reply-To: <200701061957.l06JvVbP007499@laptop13.inf.utfsm.cl>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36102>

On Sat, Jan 06, 2007 at 04:57:31PM -0300, Horst H. von Brand wrote:
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> > Guilt (Git Quilt) is a series of bash scripts which add a Mercurial
> > queues-like [1] functionality and interface to git.  The one distinguishing
> > feature from other quilt-like porcelains, is the format of the patches
> > directory. _All_ the information is stored as plain text - a series file and
> > the patches (one per file). This easily lends itself to versioning the
> > patches using any number of of SCMs.
> 
> A installation script/Makefile (or at least instructions) is missing...

Ah, good point. Just include the dir in your path. That's all.

/me goes to make a small makefile

Josef "Jeff" Sipek.

-- 
Humans were created by water to transport it upward.
