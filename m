From: Yann Dirson <ydirson@altern.org>
Subject: Re: [ANNOUNCE] qgit4 aka qgit ported to Windows
Date: Tue, 9 Jan 2007 23:47:23 +0100
Message-ID: <20070109224723.GG17093@nan92-1-81-57-214-146.fbx.proxad.net>
References: <e5bfff550701091314k71e282e8x125db65d5c287a94@mail.gmail.com> <200701092255.17091.Josef.Weidendorfer@gmx.de> <e5bfff550701091430r759c083bse99bd79046f3205f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	GIT list <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jan 09 23:47:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Pkj-00088m-RW
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 23:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbXAIWrb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 17:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbXAIWrb
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 17:47:31 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:57243 "EHLO smtp5-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932478AbXAIWra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 17:47:30 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 767E327A67;
	Tue,  9 Jan 2007 23:47:29 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 41B121F0A3; Tue,  9 Jan 2007 23:47:23 +0100 (CET)
To: Marco Costalba <mcostalba@gmail.com>
Content-Disposition: inline
In-Reply-To: <e5bfff550701091430r759c083bse99bd79046f3205f@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36418>

On Tue, Jan 09, 2007 at 11:30:34PM +0100, Marco Costalba wrote:
> Being not mergeable they lose the main motivation to be in the same
> repository IMHO.

Well, this also means you lose the history trail of you project.  Just
suppose one day you'll face a piece of your code which you don't
understand any more (face it, we all have that strange "did *I* write
that ?" feeling some day ;).  Being able to hunt it down is nice - and
grafting the qt3-based repo will only be useful it you know precisely
where to put the graft...

Best regards,
-- 
Yann.
