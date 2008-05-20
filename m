From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/4] Implement normalize_absolute_path
Date: Tue, 20 May 2008 13:22:41 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805201321300.30431@racer>
References: <48327456.1060202@facebook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Tue May 20 14:23:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyQsG-0004Id-9s
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 14:23:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbYETMWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 08:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbYETMWd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 08:22:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:46240 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751583AbYETMWc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 08:22:32 -0400
Received: (qmail invoked by alias); 20 May 2008 12:22:30 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp040) with SMTP; 20 May 2008 14:22:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18w+VlonRgw9QcsRrLBVhvErYaPsRbPG5tCPTpmjv
	0UEAI4r4I3uoIy
X-X-Sender: gene099@racer
In-Reply-To: <48327456.1060202@facebook.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82479>

Hi,

On Mon, 19 May 2008, David Reiss wrote:

> normalize_absolute_path removes several oddities form absolute paths, 
> giving nice clean paths like "/dir/sub1/sub2".  Also add a test case for 
> this utility, based on a new test program (in the style of test-sha1).

I wonder why my advice to look at setup.c (I think I did not mention the 
function name "sanitary_path_copy()" in particular, because I figured you 
would spot it right away) went unheeded.

So I think I will not even bother to look at your patches either.

Ciao,
Dscho
