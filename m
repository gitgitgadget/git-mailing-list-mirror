From: Bryan Donlan <bdonlan@fushizen.net>
Subject: Re: [PATCH 1/8] git-rebase.sh: Fix --merge --abort failures when
	path contains whitespace
Date: Wed, 9 Apr 2008 11:02:46 -0400
Message-ID: <20080409150246.GE24402@shion.is.fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <47FC6863.8070704@viscovery.net> <20080409143702.GD24402@shion.is.fushizen.net> <47FCD7E8.40004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 17:03:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjbpq-0001zc-8q
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 17:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754012AbYDIPCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 11:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753956AbYDIPCr
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 11:02:47 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:40193 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753959AbYDIPCr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 11:02:47 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1Jjbp0-0001Mj-CD; Wed, 09 Apr 2008 15:02:46 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1Jjbp0-0007sI-Oz; Wed, 09 Apr 2008 11:02:46 -0400
Content-Disposition: inline
In-Reply-To: <47FCD7E8.40004@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79115>

On Wed, Apr 09, 2008 at 04:51:20PM +0200, Johannes Sixt wrote:
> Bryan Donlan schrieb:
> 
> > If you like I can add a change to the trash directory to the next rev of
> > the patchset.
> 
> Yes, why not?

How exotic ought it be? I'm not entirely sure which characters are
allowed on windows or any other non-unixes that git supports (are there
any?)

Thanks,

Bryan
