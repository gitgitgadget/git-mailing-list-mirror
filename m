From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Make gc a builtin.
Date: Mon, 12 Mar 2007 12:23:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703121222350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
 <20070312025736.GA28505@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 12 12:24:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQidt-0007pZ-M8
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 12:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965652AbXCLLYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 07:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965672AbXCLLYA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 07:24:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:52413 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965652AbXCLLXn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 07:23:43 -0400
Received: (qmail invoked by alias); 12 Mar 2007 11:23:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 12 Mar 2007 12:23:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4BAJotXP4qGQTbeAEJ9sCqobE+A3koILoRMrdLQ
	A3A9748k0AELr8
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070312025736.GA28505@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42018>

Hi,

On Sun, 11 Mar 2007, Theodore Tso wrote:

> On Sun, Mar 11, 2007 at 06:06:56PM -0400, James Bowes wrote:
> > The following two patches make git-gc a builtin command.
> 
> What's the advantage in making git-gc a builtin command?

Portability. Plus, James wanted to get involved in Git development, and 
building in gc really was the shortest path into that.

Ciao,
Dscho
