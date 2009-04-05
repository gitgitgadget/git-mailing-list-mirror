From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: add git-difftool
Date: Sun, 5 Apr 2009 12:43:23 -0700
Message-ID: <20090405194323.GM23521@spearce.org>
References: <1238671857-8811-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:59:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqYHA-00080V-5D
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757618AbZDETna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 15:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757613AbZDETna
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:43:30 -0400
Received: from george.spearce.org ([209.20.77.23]:60218 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757602AbZDETnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 15:43:25 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 61CB538211; Sun,  5 Apr 2009 19:43:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1238671857-8811-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115690>

David Aguilar <davvid@gmail.com> wrote:
> This adds completion for difftool's --tool flag.
> The known diff tool names were also consolidated into
> a single variable.

Looks good to me.  I see Junio has it slated in pu currently.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
 
-- 
Shawn.
