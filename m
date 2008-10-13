From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add testcase to ensure merging an early part of a
	branch is done properly
Date: Mon, 13 Oct 2008 14:03:48 -0700
Message-ID: <20081013210348.GU4856@spearce.org>
References: <1217438608-28855-1-git-send-email-vmiklos@frugalware.org> <1223931265-8862-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:05:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpUb7-0007Iu-5y
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 23:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbYJMVDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 17:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755347AbYJMVDt
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 17:03:49 -0400
Received: from george.spearce.org ([209.20.77.23]:55507 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930AbYJMVDt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 17:03:49 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 86AE13835F; Mon, 13 Oct 2008 21:03:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1223931265-8862-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98145>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
> ---
> 
> [ Adding Shawn to CC as the interim maintainer. ]

In case you missed it, Junio has the pumpkin now.  (He's picked up
my topics, merged my tree, and has freed me from the time sink that
is known as maintainership.)
 
-- 
Shawn.
