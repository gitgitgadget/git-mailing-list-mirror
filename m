From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git and Scmbug integration
Date: Wed, 14 Nov 2007 00:47:22 +0100
Message-ID: <20071113234722.GK3268@steel.home>
References: <1194980792.4106.6.camel@localhost>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: Kristis Makris <kristis.makris@asu.edu>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:48:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is5UM-0005gR-9t
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762448AbXKMXr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759612AbXKMXr0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:47:26 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:63197 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762351AbXKMXrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:47:25 -0500
Received: from tigra.home (Faa9a.f.strato-dslnet.de [195.4.170.154])
	by post.webmailer.de (mrclete mo58) (RZmta 14.0)
	with ESMTP id p0276ajADHuX20 ; Wed, 14 Nov 2007 00:47:23 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D8B4D277AE;
	Wed, 14 Nov 2007 00:47:22 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 7980256D22; Wed, 14 Nov 2007 00:47:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1194980792.4106.6.camel@localhost>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolA10Q=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64910>

Kristis Makris, Tue, Nov 13, 2007 20:06:32 +0100:
> http://bugzilla.mkgnu.net/show_bug.cgi?id=991
> 
> There's no hook that will trigger when a tag is applied.

what for?

> http://bugzilla.mkgnu.net/show_bug.cgi?id=992
> 
> Git does not offer metadata describing a change on the commit trigger
> 
> The commit trigger seems to be "post-commit" but it supplies no arguments.

HEAD?
