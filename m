From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH 6/7] Add tags to the graphical history display.
Date: Fri, 14 Nov 2008 01:49:27 +0100
Message-ID: <200811140149.27414.robin.rosenberg@dewire.com>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-7-git-send-email-robin.rosenberg@dewire.com> <20081111182816.GQ2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 01:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0mta-0007DV-Q5
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 01:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752632AbYKNAtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 19:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbYKNAtb
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 19:49:31 -0500
Received: from mail.dewire.com ([83.140.172.130]:9227 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869AbYKNAta convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 19:49:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id D4D93147D0DD;
	Fri, 14 Nov 2008 01:49:28 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5QEV+B1vqKsT; Fri, 14 Nov 2008 01:49:28 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 5E7D38030C5;
	Fri, 14 Nov 2008 01:49:28 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081111182816.GQ2932@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100939>

tisdag 11 november 2008 19:28:16 skrev Shawn O. Pearce:
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > @@ -92,7 +104,64 @@ protected void drawText(final String msg, final int x, final int y) {
> >  		g.drawString(msg, cellX + x, cellY + texty, true);
> >  	}
> 
> My SWTPlotRenderer doesn't have this context line.  Am I missing
> a patch in the series?

>From the "Respect background when drawing history " patch sent to you after the first version
of this series.

-- robin
