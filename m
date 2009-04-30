From: Nicolas Pitre <nico@cam.org>
Subject: Re: Weird growth in packfile during initial push
Date: Wed, 29 Apr 2009 22:52:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904292251250.6741@xanadu.home>
References: <20090415182754.GF23644@curie-int>
 <alpine.LFD.2.00.0904151443030.6741@xanadu.home>
 <7vy6tj109a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 04:53:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzMPK-0005Xo-NG
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 04:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbZD3Cwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 22:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbZD3Cwi
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 22:52:38 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31305 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbZD3Cwi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 22:52:38 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIW00MDS7ZHKSG0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Apr 2009 22:52:29 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vy6tj109a.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117987>

On Wed, 29 Apr 2009, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > And the code matches this theory as well.  Can you try this patch if you 
> > have a chance?
> 
> Is there any progress on this?

I'll try to find 5 min tomorrow to test the patch.


Nicolas
