From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: a few remaining issues...
Date: Tue, 9 Jan 2007 12:21:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701091218080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701051453520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070105193306.GB8753@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 12:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4F3X-00051z-LY
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 12:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbXAILVz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 06:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbXAILVz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 06:21:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:48964 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751250AbXAILVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 06:21:54 -0500
Received: (qmail invoked by alias); 09 Jan 2007 11:21:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 09 Jan 2007 12:21:52 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070105193306.GB8753@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36353>

Hi,

On Fri, 5 Jan 2007, Shawn O. Pearce wrote:

> I myself am also severly lacking in time right now.

Did you have any chance to look at the patch I posted? It adds 
"--walk-reflogs" option to the revision walker, and as long as there is 
reflog information, traverses the commits in that order. It also shows the 
reflog data just below the "commit" line.

Ciao,
Dscho
