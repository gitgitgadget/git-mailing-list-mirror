From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] Allow fancy globs in git-svn init branches
Date: Wed, 19 Sep 2012 01:52:38 +0000
Message-ID: <20120919015238.GA32008@dcvr.yhbt.net>
References: <1347925598-23907-1-git-send-email-ammon.riley@gmail.com>
 <20120918204654.GA22856@dcvr.yhbt.net>
 <CAMvPOPuCW-oCfV8pyN3OMU3barFsSX2pHgr4K4Og7GOnFiU-7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, marcin@owsiany.pl, schwern@pobox.com
To: Ammon Riley <ammon.riley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 03:52:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE9T7-00021d-Se
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 03:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753653Ab2ISBwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 21:52:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48880 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067Ab2ISBwi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 21:52:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B871F546;
	Wed, 19 Sep 2012 01:52:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAMvPOPuCW-oCfV8pyN3OMU3barFsSX2pHgr4K4Og7GOnFiU-7Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205899>

Ammon Riley <ammon.riley@gmail.com> wrote:
> I confess that I'd completely forgot about the {} expansion in bash.
> Perhaps a note in the CAVEATS section of the documentation would
> be sufficient?

I think so, yes.  Can you send a patch for that instead?  Thanks.
