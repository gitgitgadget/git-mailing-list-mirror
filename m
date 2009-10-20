From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git fsck not identifying corrupted packs
Date: Tue, 20 Oct 2009 14:39:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910201437240.21460@xanadu.home>
References: <loom.20091019T094924-194@post.gmane.org>
 <4ADC2D45.3020803@viscovery.net>
 <alpine.DEB.1.00.0910191202020.4985@pacific.mpi-cbg.de>
 <7v7hur1a0h.fsf@alter.siamese.dyndns.org> <vpqy6n6shri.fsf@bauges.imag.fr>
 <7vfx9esgvt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:41:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LWX-0003ww-La
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbZJTUlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 16:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbZJTUlT
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:41:19 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13799 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469AbZJTUlR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 16:41:17 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KRT009TFT5FE6I0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 20 Oct 2009 14:39:16 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vfx9esgvt.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130843>

On Mon, 19 Oct 2009, Junio C Hamano wrote:

> Actually, I changed my mind.  I do not think this so big that we need to
> wait for a major version bump.  Why not shoot for 1.6.6?

Agreed.  With a prominent note in the release notes to point people at 
it when they don't read release notes and complain that fsck suddenly 
became very slow after they upgraded.


Nicolas
