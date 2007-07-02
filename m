From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fetch will leave a ref pointing to a tag
Date: Tue, 3 Jul 2007 00:29:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707030028280.4071@racer.site>
References: <20070702194437.19202.qmail@science.horizon.com>
 <Pine.LNX.4.64.0707022207420.4071@racer.site> <7v4pkmwgda.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux@horizon.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 01:29:15 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5VKU-0002OJ-NR
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 01:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756144AbXGBX3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 19:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755793AbXGBX3M
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 19:29:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:38110 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755496AbXGBX3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 19:29:11 -0400
Received: (qmail invoked by alias); 02 Jul 2007 23:29:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 03 Jul 2007 01:29:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8/14NXVP8C3m2yrkDGkRDYlRBXeQs9Rz9X9Hx2Q
	Xir1NR/AMADgXo
X-X-Sender: gene099@racer.site
In-Reply-To: <7v4pkmwgda.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51431>

Hi,

On Mon, 2 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Mon, 2 Jul 2007, linux@horizon.com wrote:
> >
> >> $ git branch temp tags/v2.6.22-rc6
> >> $ git fetch . tags/v2.6.22-rc7:temp
> > ...
> > No. It is perfectly sane to fetch a tag, and to store it.
> 
> Yes, but not to a branch.

Ooops. I forgot to write that (as the "No" at the beginning suggests...).

Thank you,
Dscho
