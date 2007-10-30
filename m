From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/2] add throughput to progress display
Date: Tue, 30 Oct 2007 09:54:45 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710300952520.21255@xanadu.home>
References: <alpine.LFD.0.9999.0710291904190.22100@xanadu.home>
 <7vr6jdm2eb.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.9999.0710300935330.21255@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 14:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImrYZ-0004yL-GJ
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 14:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbXJ3Nyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 09:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbXJ3Nyq
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 09:54:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55141 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbXJ3Nyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 09:54:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQQ009N29B9QR90@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 30 Oct 2007 09:54:45 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.9999.0710300935330.21255@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 30 Oct 2007, Nicolas Pitre wrote:

> On Tue, 30 Oct 2007, Junio C Hamano wrote:
> 
> > Very nice.
> > 
> > I however wonder why this breaks t1004 when applied on top of
> > lt/rename topic.
> 
> Well... sh*t happens.
> 
> Could you please simply amend [PATCH 1/2] with the patch below:

Well that isn't enough.  Please just scrap the whole thing as more 
fundamental changes are needed.  I'll send a new patch set when ready.


Nicolas
