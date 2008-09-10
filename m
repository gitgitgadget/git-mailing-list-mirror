From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 16:55:19 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809101654020.23787@xanadu.home>
References: <20080909132212.GA25476@cuci.nl>
 <20080910203249.GX4829@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 22:57:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdWkF-0008If-Nd
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 22:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbYIJUz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 16:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbYIJUz1
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 16:55:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48761 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYIJUz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 16:55:26 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K6Z004R2ZG7RT50@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 Sep 2008 16:55:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080910203249.GX4829@genesis.frugalware.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95555>

On Wed, 10 Sep 2008, Miklos Vajna wrote:

> So, git revert already includes the "origin" of the commit in the commit
> message, and I think that is fine for most people.
> 
> What about adding an option to cherry-pick to add a similar
> "commit 7b27718bdb1b70166383dec91391df5534d449ee upstream" or similar
> string to the commit message?

It's already there: -x

Nicolas
