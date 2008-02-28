From: Nicolas Pitre <nico@cam.org>
Subject: Re: 'git gc' always run, on old kernel repo?
Date: Thu, 28 Feb 2008 15:36:33 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802281533190.4911@xanadu.home>
References: <47C71233.4050705@garzik.org> <47C715EB.3060303@garzik.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 21:37:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUpVK-0005UK-6L
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbYB1Ugl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbYB1Ugl
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:36:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:47877 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932454AbYB1Ugj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:36:39 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JWY003JSUKORY10@VL-MO-MR005.ip.videotron.ca>; Thu,
 28 Feb 2008 15:36:24 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <47C715EB.3060303@garzik.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75446>

On Thu, 28 Feb 2008, Jeff Garzik wrote:

> > warning: There are too many unreachable loose objects; run 'git prune' to
> > remove them.
> 
> Will the 'git gc' never end???

What happens if you try to run "git prune"?


Nicolas
