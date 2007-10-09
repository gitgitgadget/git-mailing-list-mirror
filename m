From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] mergetool: support absolute paths to tools by git config
 merge.<tool>path
Date: Tue, 9 Oct 2007 13:35:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091334390.4174@racer.site>
References: <11918785613855-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Ts'o <tytso@mit.edu>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 14:36:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEJa-00012y-Vo
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbXJIMft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbXJIMft
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:35:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:34077 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751983AbXJIMfs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:35:48 -0400
Received: (qmail invoked by alias); 09 Oct 2007 12:35:46 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp028) with SMTP; 09 Oct 2007 14:35:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+bWEMwaUubvG13I8d20mpvtKGae18TooKgshloup
	j3DSQUaLBqCkmq
X-X-Sender: gene099@racer.site
In-Reply-To: <11918785613855-git-send-email-prohaska@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60392>

Hi,

On Mon, 8 Oct 2007, Steffen Prohaska wrote:

> This commit adds a mechanism to provide absolute paths to the
> commands called by 'git mergetool'. A path can be specified
> in the configuation variable merge.<toolname>path.

Would it not be more in line with all other config variables if it was 
written merge.<toolname>.path?  (Indeed, I thought your subject line 
contained a typo when I read it first.)

Ciao,
Dscho
