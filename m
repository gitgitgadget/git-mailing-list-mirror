From: Petko Manolov <petkan@nucleusys.com>
Subject: Re: git and binary files
Date: Wed, 16 Jan 2008 15:58:14 +0200 (EET)
Message-ID: <alpine.DEB.1.00.0801161549140.5260@bender.nucleusys.com>
References: <alpine.DEB.1.00.0801161222150.3889@bender.nucleusys.com> <ee77f5c20801160254u53e07773qb4125ffd90cf7619@mail.gmail.com> <alpine.DEB.1.00.0801161517260.5260@bender.nucleusys.com> <alpine.LSU.1.00.0801161341430.17650@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 16 15:00:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF8oD-0001Yq-BI
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 15:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbYAPN7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 08:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753141AbYAPN7c
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 08:59:32 -0500
Received: from n152-u15.cabletel.bg ([89.253.152.15]:45614 "EHLO
	zztop.nucleusys.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752844AbYAPN7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 08:59:32 -0500
Received: from bender.nucleusys.com ([192.168.234.2])
	by zztop.nucleusys.com with esmtp (Exim 4.63)
	(envelope-from <petkan@nucleusys.com>)
	id 1JF8nc-0007Mt-Qt; Wed, 16 Jan 2008 15:59:24 +0200
In-Reply-To: <alpine.LSU.1.00.0801161341430.17650@racer.site>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70673>

On Wed, 16 Jan 2008, Johannes Schindelin wrote:

> I think that you're missing the point of version control.  It's not only 
> about having an up-to-date source tree, but also about being able to go 
> back to a certain revision.

No contradiction here.  In my case old source code will work perfectly 
with new binaries/firmware.  That's why i don't _need_ the history, only 
the latest stuff in order to save space.

I do realize that what i am talking about is statistically microscopic 
scenario, but it does exist.  If there's no such feature then i don't have 
much choice, but stick with my current way of doing things.

> What you want is most likely covered by "rsync -au".

Yeah, just like in the old days when "git pull" didn't do everything for 
you.


thanks,
Petko
