From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merging .gitignore
Date: Mon, 1 Oct 2007 14:57:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710011457120.28395@racer.site>
References: <20071001130314.GA5932@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Mon Oct 01 15:59:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcLno-0006Ki-GD
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 15:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345AbXJAN7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 09:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbXJAN7H
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 09:59:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:57001 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751082AbXJAN7G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 09:59:06 -0400
Received: (qmail invoked by alias); 01 Oct 2007 13:59:03 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 01 Oct 2007 15:59:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+q7HA7csiqsHP6nlVnrYOu0RSB3W3omI1FRnpnDO
	tz9FZwtTpMYhqP
X-X-Sender: gene099@racer.site
In-Reply-To: <20071001130314.GA5932@lapse.madduck.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59617>

Hi,

On Mon, 1 Oct 2007, martin f krafft wrote:

> Feature branch A has a .gitignore file, and it's been merged into
> master for a while. Today, feature branch B failed to merge into
> master because it also provides a .gitignore file.

You might be interested in writing a merge driver.  See 
Documentation/gitattributes.txt.

Hth,
Dscho
