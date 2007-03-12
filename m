From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/7] Fix t5510-fetch's use of sed
Date: Tue, 13 Mar 2007 00:06:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703130006370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070312225916.GA16840@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 00:07:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQtbZ-0001B4-1X
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 00:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbXCLXG6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 19:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbXCLXG6
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 19:06:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:35593 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752128AbXCLXG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 19:06:57 -0400
Received: (qmail invoked by alias); 12 Mar 2007 23:06:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 13 Mar 2007 00:06:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BPaNWLzQBnbFZj55nV8HNqKKLMkhoJThDm2m6jE
	/R9xY9DURKOJD/
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070312225916.GA16840@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42093>

Hi,

On Mon, 12 Mar 2007, Shawn O. Pearce wrote:

> POSIX says sed may add a trailing LF if there isn't already
> one there.  We shouldn't rely on it not adding that LF, as
> some systems (Mac OS X for example) will add it.
> 
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

ACK!

Ciao,
Dscho
