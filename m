From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH 1/1] jgit: create a tag command
Date: Fri, 11 Jul 2008 10:28:32 +0200
Message-ID: <200807111028.32973.robin.rosenberg.lists@dewire.com>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com> <e2b179460807100831g5d62a0a8nc7e7bf2715f0b9f1@mail.gmail.com> <20080711020507.GD31862@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 10:34:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHE5V-0007TS-BQ
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 10:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753833AbYGKIdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 04:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbYGKIdp
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 04:33:45 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14890 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbYGKIdo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 04:33:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 878808027F7;
	Fri, 11 Jul 2008 10:33:42 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YM47ol5Lck7d; Fri, 11 Jul 2008 10:33:42 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 172E3800691;
	Fri, 11 Jul 2008 10:33:42 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <20080711020507.GD31862@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88096>

fredagen den 11 juli 2008 04.05.07 skrev Shawn O. Pearce:
> Mike Ralphson <mike.ralphson@gmail.com> wrote:
> > 
> > Loving the make_jgit stuff.
> 
> So making jgit a single stand-alone, portable shell script for
> command line usage was a good idea?  ;-)
> 
> I think we are at the point where we need to either write a
> #@!*(!@(! command line option parser, import one, or stop writing
> command line programs.  I would certainly appreciate any opinion
> you might have on the matter.

I've come to that conclusion too, but not yet to the code :)

-- robin
