From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] remote-helpers: return successfully if everything
	up-to-date
Date: Tue, 27 Oct 2009 17:11:25 -0700
Message-ID: <20091028001125.GM10505@spearce.org>
References: <1256472380-924-1-git-send-email-drizzd@aon.at> <1256472380-924-2-git-send-email-drizzd@aon.at> <1256472380-924-3-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Oct 28 01:11:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2w8X-0006t4-1b
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 01:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914AbZJ1ALV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 20:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756897AbZJ1ALV
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 20:11:21 -0400
Received: from george.spearce.org ([209.20.77.23]:48614 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbZJ1ALU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2009 20:11:20 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 77EE6381D3; Wed, 28 Oct 2009 00:11:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1256472380-924-3-git-send-email-drizzd@aon.at>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131394>

Clemens Buchacher <drizzd@aon.at> wrote:
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

>  t/t5540-http-push.sh |    2 +-
>  transport-helper.c   |    2 ++
>  2 files changed, 3 insertions(+), 1 deletions(-)

-- 
Shawn.
