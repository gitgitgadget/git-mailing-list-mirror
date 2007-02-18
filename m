From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff --check: use colour
Date: Sun, 18 Feb 2007 01:47:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180146260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0701241505260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vejpi63py.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0701262214420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy94qplg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 01:47:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIaDR-0005if-2P
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 01:47:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965484AbXBRArm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 19:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965477AbXBRArm
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 19:47:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:51127 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965484AbXBRArl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 19:47:41 -0500
Received: (qmail invoked by alias); 18 Feb 2007 00:47:40 -0000
X-Provags-ID: V01U2FsdGVkX18O0xIk+yAOk6Cny9rxkrXIfXg9o3NZFawE4xU5CH
	0qzQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vfy94qplg.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40041>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> I wonder what happened to this patch...

I think it is still the same. At least I did not use another patch in my 
private tree, and it works fine.

I _thought_ I could clean it up a little more, but then realized a thinko 
on my part: I misread a NUL for a NULL.

Should I resend?

Ciao,
Dscho
