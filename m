From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git gui: show diffs with a minimum of 1 context line
Date: Mon, 1 Sep 2008 12:33:59 -0700
Message-ID: <20080901193359.GG7482@spearce.org>
References: <20080830164527.GA25370@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 01 21:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaFBB-0000Ev-6h
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 21:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbYIATeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 15:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751545AbYIATeB
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 15:34:01 -0400
Received: from george.spearce.org ([209.20.77.23]:42755 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbYIATeA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 15:34:00 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EA0AB38375; Mon,  1 Sep 2008 19:33:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080830164527.GA25370@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94604>

Clemens Buchacher <drizzd@aon.at> wrote:
> git apply does not handle diffs without context correctly. Configuring git
> gui to show zero context lines therefore breaks staging.
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

Thanks, this is queued for 'maint'.
 
-- 
Shawn.
