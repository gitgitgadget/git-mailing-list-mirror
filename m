From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Patchdiff
Date: Tue, 26 Jan 2010 20:40:03 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001262038130.1681@xanadu.home>
References: <fabb9a1e1001261606i4f706387vaf5647436e454fb4@mail.gmail.com>
 <alpine.LFD.2.00.1001262014250.1681@xanadu.home>
 <7vzl40wcz2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 02:40:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZwtC-0000gf-8M
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 02:40:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046Ab0A0BkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 20:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644Ab0A0BkH
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 20:40:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:62326 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab0A0BkE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 20:40:04 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KWV00H7XTYREO60@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 26 Jan 2010 20:40:03 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vzl40wcz2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138102>

On Tue, 26 Jan 2010, Junio C Hamano wrote:

> When showing a merge, there is one end result (the merged version), so it
> fits the model that is a natural extension of two-way diff.  In the "two
> patches walked in a bar, modified the same version and produced two
> different results" case, the common thing is the preimage, not postimage.
> I couldn't come up with a combined output format that visually makes sense
> for that mode of operation.

Hmmmmmm yeah.  I didn't think it through all the way.  Too bad.


Nicolas
