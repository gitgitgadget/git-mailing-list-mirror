From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's cooking in git.git (Sep 2009, #01; Sat, 05)
Date: Sat, 05 Sep 2009 09:24:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909050919140.6044@xanadu.home>
References: <7vocpp3i2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 15:24:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjvG3-0006yd-IH
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 15:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbZIENYh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 09:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbZIENYh
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 09:24:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42261 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbZIENYg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 09:24:36 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KPI006K32KTBOB0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 05 Sep 2009 09:24:30 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vocpp3i2l.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127815>

On Sat, 5 Sep 2009, Junio C Hamano wrote:

> What's cooking in git.git (Sep 2009, #01; Sat, 05)
> --------------------------------------------------
> 
> Here are the topics that have been cooking.  Commits prefixed with '-' are
> only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
> marked with '.' do not appear in any of the integration branches, but I am
> still holding onto them.

Just to make sure you didn't miss the last 2 patches I posted:

Date: Thu, 03 Sep 2009 19:08:33 -0400 (EDT)
Subject: [PATCH] make shallow repository deepening more network efficient

Date: Thu, 03 Sep 2009 21:54:03 -0400 (EDT)
Subject: [PATCH] pack-objects: free preferred base memory after usage


Nicolas
