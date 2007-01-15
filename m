From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 11:43:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701151137430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701151000.58609.andyparkins@gmail.com> <20070115101529.GB12257@spearce.org>
 <20070115102727.GC12257@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:58:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vi5-0006dM-0M
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:29 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V9e-0003eK-GF
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbXAOKnr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 05:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbXAOKnr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 05:43:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:59931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932197AbXAOKnr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 05:43:47 -0500
Received: (qmail invoked by alias); 15 Jan 2007 10:43:45 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp017) with SMTP; 15 Jan 2007 11:43:45 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070115102727.GC12257@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36854>

Hi,

On Mon, 15 Jan 2007, Shawn O. Pearce wrote:

> I've never met anyone on this mailing list in person, but the quality 
> (or lack thereof sometimes) is evident in my work, and since its all 
> peer-reviewed anyway Junio finds little risk in incorporating the good 
> stuff into git.git.  No certificate required.

Exactly. I think it is one of the reasons monotone is so unpopular (at 
least as far as I am concerned): it makes the start really cumbersome. And 
in the end you gain nothing.

And you see what the result is when looking into corporate projects. More 
often than not, bureaucratic procedures (e.g. tracking time, meetings, 
specifications) supersede quality-assuring procedures (e.g. permanent 
updates on the TODO list, code review, discussion on implementation 
details), and quite often, the code just sucks.

My favourite example is when I found 34 different (!) implementations of a 
tree structure in the same project.

So, if you start relying on the validity of code just because somebody 
signed it, you will reap trouble.

Ciao,
Dscho
