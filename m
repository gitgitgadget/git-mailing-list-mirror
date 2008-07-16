From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase-i: keep old parents when preserving merges
Date: Wed, 16 Jul 2008 12:24:05 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807161223210.8503@eeepc-johanness>
References: <1216173109-11155-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0807160432480.2841@eeepc-johanness> <20080716094301.GA25087@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jul 16 12:24:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ4BU-0005Gr-2R
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 12:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbYGPKXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 06:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbYGPKXc
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 06:23:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:50280 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753900AbYGPKXb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 06:23:31 -0400
Received: (qmail invoked by alias); 16 Jul 2008 10:23:30 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness) [88.107.142.10]
  by mail.gmx.net (mp039) with SMTP; 16 Jul 2008 12:23:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194Fudg6XN49puGH5O38Q4u6AKDco97cqCidCNLat
	OzDovj5ZUi9ehe
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080716094301.GA25087@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88656>

Hi,

On Wed, 16 Jul 2008, Stephan Beyer wrote:

> Johannes Schindelin wrote:
> 
> > On Wed, 16 Jul 2008, Stephan Beyer wrote:
> > 
> > > This patch fixes two issues for rebase -i with preserving merges of 
> > > unrelated branches.
> > 
> > Two?  What's the second?
> 
> Oh, eh, well ;)
> It's only one bug, but it results in two different behaviors...

Ah, okay.  Worthwhile clarifying in the commit message.

Thanks for the patch,
Dscho
