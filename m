From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Show binary file size change in diff --stat
Date: Wed, 28 Feb 2007 20:42:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702282042000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702281303.11951.andyparkins@gmail.com> <45E5D0D7.5070305@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Rogan Dawes <discard@dawes.za.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 20:43:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMUhZ-00007f-Jt
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 20:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbXB1Tmq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 14:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbXB1Tmq
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 14:42:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:54359 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751709AbXB1Tmp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 14:42:45 -0500
Received: (qmail invoked by alias); 28 Feb 2007 19:42:44 -0000
X-Provags-ID: V01U2FsdGVkX1/mow8eo1Pm56QycA+pbLJbP2YVy6cG0+FzLddiwH
	d9Ww==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E5D0D7.5070305@dawes.za.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40998>

Hi,

On Wed, 28 Feb 2007, Rogan Dawes wrote:

> How about showing the size of the changes between the 2 files via the 
> libxdiff binary patch function?

I briefly considered this, too. But what would it tell you in the case of 
a jpg? I think it has more disadvantages than advantages...

Ciao,
Dscho
