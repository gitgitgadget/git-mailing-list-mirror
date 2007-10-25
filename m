From: Nicolas Pitre <nico@cam.org>
Subject: Re: recent change in git.git/master broke my repos
Date: Thu, 25 Oct 2007 16:38:06 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710251637240.22100@xanadu.home>
References: <86oden6z97.fsf@blue.stonehenge.com>
 <20071025150107.GB31196@diana.vm.bytemark.co.uk>
 <alpine.LFD.0.9999.0710251344220.22100@xanadu.home> <4720FB4E.3030300@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: =?ISO-8859-15?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Oct 25 22:38:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Il9TO-0006QN-Ag
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 22:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbXJYUiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 16:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbXJYUiV
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 16:38:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12104 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbXJYUiU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2007 16:38:20 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQH00KCXINJPW91@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 25 Oct 2007 16:38:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4720FB4E.3030300@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62372>

On Thu, 25 Oct 2007, Andreas Ericsson wrote:

> Nicolas Pitre wrote:
> > Isn't that called a remote branch that gets updated with "git fetch' ?
> > You can even trick Git into not using the refs/remotes/ namespace for them
> > if you wish.
> > 
> 
> You'd lose the ability to do "git diff origin/master" while disconnected
> though. It's quite valuable.

I don't see how you'd lose anything.


Nicolas
