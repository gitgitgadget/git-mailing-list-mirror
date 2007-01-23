From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Tue, 23 Jan 2007 21:22:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701232119360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net> <eovccc$usc$1@sea.gmane.org>
 <Pine.LNX.4.63.0701211207500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17846.20498.635623.173653@lisa.zopyra.com>
 <Pine.LNX.4.63.0701232012120.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <17846.27694.845530.663964@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 21:26:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9SE6-0004Dr-V5
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 21:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932968AbXAWU0k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 15:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933016AbXAWU0k
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 15:26:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:42215 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932968AbXAWU0j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 15:26:39 -0500
Received: (qmail invoked by alias); 23 Jan 2007 20:22:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 23 Jan 2007 21:22:40 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Bill Lear <rael@zopyra.com>
In-Reply-To: <17846.27694.845530.663964@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37566>

Hi,

On Tue, 23 Jan 2007, Bill Lear wrote:

> % less --version
> less 382

It works here, with 381 _and_ 376+iso254.

> If I set LESS to '-F' it fails.  If set to '-RS', output is seen but 
> then I see the screen blanked when there is no output from git diff.

This looks more like a broken terminal interaction to me.

Ciao,
Dscho
