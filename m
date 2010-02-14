From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Global reflog?
Date: Sun, 14 Feb 2010 16:56:38 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002141655450.1946@xanadu.home>
References: <2729632a1002141349s6c9a31b7u6784d89d132547ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sun Feb 14 22:56:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgmSM-0000Lr-3k
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 22:56:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462Ab0BNV4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 16:56:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46726 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738Ab0BNV4k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 16:56:40 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KXU00METQAE2120@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 14 Feb 2010 16:56:39 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <2729632a1002141349s6c9a31b7u6784d89d132547ac@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139946>

On Sun, 14 Feb 2010, skillzero@gmail.com wrote:

> Is there a way to have git maintain a single reflog across all
> branches (and stashes)? I switch between branches, create and delete
> branches, stash save and pop, etc. frequently and it would be great
> for me if there was a way to have a global reflog that showed every
> operation, independent of a particular branch. Is there some way to
> enable this?

You have it already.  It is the "HEAD" reflog.


Nicolas
