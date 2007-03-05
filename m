From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: Can't clone guilt repo
Date: Mon, 5 Mar 2007 03:53:50 -0500
Message-ID: <20070305085350.GA6440@filer.fsl.cs.sunysb.edu>
References: <20070305071136.GL19828@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Mon Mar 05 09:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HO8xY-0005Se-Bk
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 09:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbXCEIyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 03:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752721AbXCEIyJ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 03:54:09 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:52496 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbXCEIyH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 03:54:07 -0500
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l258ro8r014594;
	Mon, 5 Mar 2007 03:53:50 -0500
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l258rofb014592;
	Mon, 5 Mar 2007 03:53:50 -0500
Content-Disposition: inline
In-Reply-To: <20070305071136.GL19828@mellanox.co.il>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41426>

On Mon, Mar 05, 2007 at 09:11:36AM +0200, Michael S. Tsirkin wrote:
> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git
> Initialized empty Git repository in /home/mst/scm/guilt/.git/
> fatal: protocol error: bad line length character
> fetch-pack from 'git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/guilt.git'
> failed.

I noticed that sometimes a pull/clone from git.kernel.org fails in an odd
way, but if I wait few seconds and retry everything is fine.

Josef "Jeff" Sipek.

-- 
Reality is merely an illusion, albeit a very persistent one.
		- Albert Einstein
