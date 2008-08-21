From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Typo in implementation of pack protocol
Date: Thu, 21 Aug 2008 07:50:12 -0700
Message-ID: <20080821145012.GN3483@spearce.org>
References: <1219314971-13445-1-git-send-email-mike@abacus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Marek Zawirski <marek.zawirski@gmail.com>
To: Mike Ralphson <mike@abacus.co.uk>
X-From: git-owner@vger.kernel.org Thu Aug 21 16:54:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWBVn-0007D4-Gc
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 16:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534AbYHUOuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 10:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752959AbYHUOuO
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 10:50:14 -0400
Received: from george.spearce.org ([209.20.77.23]:41739 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755694AbYHUOuM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 10:50:12 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1FD3338375; Thu, 21 Aug 2008 14:50:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219314971-13445-1-git-send-email-mike@abacus.co.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93160>

Mike Ralphson <mike@abacus.co.uk> wrote:
> cgit's receive-pack.c has never had the corresponding typo.
> Fix up method and member names to match.

Whoops.  Thanks.
 
> -				if (line.equals("capabilties^{}")) {
> +				if (line.equals("capabilities^{}")) {
>  					// special line from git-receive-pack to show
>  					// capabilities when there are no refs to advertise

-- 
Shawn.
