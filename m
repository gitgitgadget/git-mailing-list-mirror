From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Wed, 12 Mar 2008 11:45:07 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803121143170.2947@xanadu.home>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
 <7vskywadum.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
 <7vbq5k77z0.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803121153160.1656@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 16:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZT9I-0007JC-Ij
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 16:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbYCLPpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 11:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbYCLPpK
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 11:45:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25267 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbYCLPpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 11:45:08 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JXM004LWJR72460@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 12 Mar 2008 11:45:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LSU.1.00.0803121153160.1656@racer.site>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76959>

On Wed, 12 Mar 2008, Johannes Schindelin wrote:

> The real question I asked was: is 2 weeks a sensible default?  As I said, 
> I was almost tempted to reduce it to 3 days.

3 days would make me nervous, even if it should be plenty safe.

2 weeks is OTOH maybe a bit too conservative.

What about one week instead?


Nicolas
