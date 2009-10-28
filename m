From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: difftool accepts the same options as
	diff
Date: Wed, 28 Oct 2009 07:32:54 -0700
Message-ID: <20091028143254.GQ10505@spearce.org>
References: <1256723138-1480-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 28 15:33:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N39a9-0005JK-R2
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 15:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbZJ1Ocu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 10:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbZJ1Ocu
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 10:32:50 -0400
Received: from george.spearce.org ([209.20.77.23]:38091 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbZJ1Ocu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 10:32:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E652A381D3; Wed, 28 Oct 2009 14:32:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1256723138-1480-1-git-send-email-markus.heidelberg@web.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131465>

Markus Heidelberg <markus.heidelberg@web.de> wrote:
> So complete refs, files after the doubledash and some diff options that
> make sense for difftool.
> 
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

>  contrib/completion/git-completion.bash |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)

-- 
Shawn.
