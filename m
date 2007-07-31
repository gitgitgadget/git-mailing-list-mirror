From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH v2 0/5] Add guards to guilt
Date: Mon, 30 Jul 2007 23:42:08 -0400
Message-ID: <20070731034208.GB12918@filer.fsl.cs.sunysb.edu>
References: <1185851481190-git-send-email-eclesh@ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Tue Jul 31 05:42:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFicp-0006uJ-BK
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 05:42:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933767AbXGaDmS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 23:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933560AbXGaDmS
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 23:42:18 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:41541 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932946AbXGaDmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 23:42:17 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6V3g96D013464;
	Mon, 30 Jul 2007 23:42:09 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6V3g8jN013462;
	Mon, 30 Jul 2007 23:42:08 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <1185851481190-git-send-email-eclesh@ucla.edu>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54315>

On Mon, Jul 30, 2007 at 08:11:16PM -0700, Eric Lesh wrote:
...
> I did everything (maybe?) you suggested except implement a
> safe_sed wrapper and a validate_guards function.  The sed stuff is
> maybe better for a later patch that covers most sed usage in guilt,

Agreed.

> and the validate_guards isn't really necessary given the small number
> of times it's called.  If you would prefer either of those to get
> done, let me know.

I'll look at the patches and complain there if it seems like something
that should be done. :)

Josef 'Jeff' Sipek.

-- 
I already backed up the [server] once, I can do it again.
