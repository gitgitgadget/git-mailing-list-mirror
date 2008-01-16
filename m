From: Petko Manolov <petkan@nucleusys.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 16:21:44 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161615300.5260@bender.nucleusys.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <ee77f5c20801160254u53e07773qb4125ffd90cf7619@mail.gmail.com> <alpine.DEB.1.00.0801161517260.5260@bender.nucleusys.com> <alpine.LSU.1.00.0801161341430.17650@racer.site>
 <alpine.DEB.1.00.0801161549140.5260@bender.nucleusys.com> <alpine.LSU.1.00.0801161405330.17650@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:23:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF9Az-0003jQ-UU
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbYAPOXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 09:23:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753563AbYAPOXF
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 09:23:05 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:41685 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752880AbYAPOXD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 09:23:03 -0500
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JF9AM-0007QT-JQ; Wed, 16 Jan 2008 16:22:54 +0200
In-Reply-To: <alpine.LSU.1.00.0801161405330.17650@racer.site>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70679>

On Wed, 16 Jan 2008, Johannes Schindelin wrote:

> No, you _do_ miss the point here.  You might _think_ that they work 
> perfectly, but with revision control you want to have _exactly_ the same 
> setup.  You want to be able to go back to a certain _revision_ 
> (including the then-current firmware).

I _know_ older code will work with new binaries.  I know because i've done 
it many times and the application is the sort that is not going to forgive 
any frivolity.

Unfortunately this is very specific to what i'm doing and does not apply 
for 99.99% of what people usually need.

> And that's what you don't want.  So git is not for you.

I use git for SCV from day one.  It's great.  I was just thinking aloud 
about something i've stumbled upon.  ;-)


 		Petko
