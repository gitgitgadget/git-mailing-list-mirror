From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 0/9] Repository change listeners
Date: Fri, 11 Jul 2008 05:26:02 +0000
Message-ID: <20080711052602.GA822@spearce.org>
References: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 07:27:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHB9r-0003y4-SV
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 07:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYGKF0F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 01:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbYGKF0E
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 01:26:04 -0400
Received: from george.spearce.org ([209.20.77.23]:49598 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbYGKF0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 01:26:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 47F9A38222; Fri, 11 Jul 2008 05:26:02 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1215729651-26781-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88082>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> We want to make the UI react on changes to the repo, but the parts
> of the code that makes the changes doesn't know who wants to react
> on them. This adds a publish-subcribe mechanism, including detection
> of externally made changes, e.g. by C Git.

Aside from the few patches I commented on, I like the overall series
(not just this one, but the others you sent today as well).  Its a
welcome improvement.
 
-- 
Shawn.
