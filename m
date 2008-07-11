From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/1] jgit: create a tag command
Date: Fri, 11 Jul 2008 02:05:07 +0000
Message-ID: <20080711020507.GD31862@spearce.org>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com> <200807070116.39892.robin.rosenberg.lists@dewire.com> <e2b179460807100831g5d62a0a8nc7e7bf2715f0b9f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 04:06:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH81y-0005fJ-Tv
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 04:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753777AbYGKCFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 22:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYGKCFJ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 22:05:09 -0400
Received: from george.spearce.org ([209.20.77.23]:58224 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbYGKCFI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 22:05:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9F76E38222; Fri, 11 Jul 2008 02:05:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <e2b179460807100831g5d62a0a8nc7e7bf2715f0b9f1@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88073>

Mike Ralphson <mike.ralphson@gmail.com> wrote:
> 
> Loving the make_jgit stuff.

So making jgit a single stand-alone, portable shell script for
command line usage was a good idea?  ;-)

I think we are at the point where we need to either write a
#@!*(!@(! command line option parser, import one, or stop writing
command line programs.  I would certainly appreciate any opinion
you might have on the matter.

-- 
Shawn.
