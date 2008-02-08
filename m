From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH (repost)] Improve bash prompt to detect merge / rebase
 in progress
Date: Fri, 8 Feb 2008 12:25:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802081224210.11591@racer.site>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com> <200802062314.39440.robin.rosenberg.lists@dewire.com> <7vodatu37m.fsf@gitster.siamese.dyndns.org> <200802070123.43109.robin.rosenberg.lists@dewire.com> <20080207063412.GQ24004@spearce.org>
 <F19A1227-3803-4C23-BEA2-26F23824ACF5@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Stephen Sinclair <radarsat1@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Feb 08 13:26:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNSIy-0008En-BO
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 13:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240AbYBHMZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 07:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbYBHMZe
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 07:25:34 -0500
Received: from mail.gmx.net ([213.165.64.20]:60074 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752772AbYBHMZd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 07:25:33 -0500
Received: (qmail invoked by alias); 08 Feb 2008 12:25:31 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp046) with SMTP; 08 Feb 2008 13:25:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18mEbZ5lvcmmeE/GsNTMxjuh937RIxjk0We68Ydgc
	FeS0ZmSeTgheBE
X-X-Sender: gene099@racer.site
In-Reply-To: <F19A1227-3803-4C23-BEA2-26F23824ACF5@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73084>

Hi,

On Fri, 8 Feb 2008, Steffen Prohaska wrote:

> This improved prompt is great.  I already miss it each time I switch 
> back from next to master.

Maybe we (as in msysgit) should install the git-completion.bash script 
into /share/git-core/?

Ciao,
Dscho
