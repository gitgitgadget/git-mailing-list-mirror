From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: using the same repo with different OS
Date: Sun, 25 Feb 2007 19:30:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702251929170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <906f26060702250913g41658be6mffea613f25f9a847@mail.gmail.com>
 <Pine.LNX.4.63.0702251829530.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v3b4ut7yq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stefano Spinucci <virgo977virgo@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 19:30:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLO8u-0004Pa-Um
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 19:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933702AbXBYSaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 13:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933701AbXBYSaX
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 13:30:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:40808 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933700AbXBYSaV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 13:30:21 -0500
Received: (qmail invoked by alias); 25 Feb 2007 18:30:20 -0000
X-Provags-ID: V01U2FsdGVkX19yHfQ6y1VyRYtmeZaIHOFQK8d6plZROGfa+GckSb
	/PCQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v3b4ut7yq.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40565>

Hi,

On Sun, 25 Feb 2007, Junio C Hamano wrote:

> So even though file format of the index may be designed and implemented 
> to be portable, it might not be practical to use the same physical 
> repository from different OSes, depending on the combination of things.

Yes.

However, in the case of a _bare_ repo, which is meant purely to transport 
(possibly huge) changes from A to B, a USB stick can be used _without_ 
problems. I do that myself quite often.

Ciao,
Dscho
