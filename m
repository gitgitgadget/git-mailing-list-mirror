From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Closing the merge window for 1.6.0
Date: Wed, 16 Jul 2008 00:45:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807160044480.2990@eeepc-johanness>
References: <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer>
 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org> <alpine.LFD.1.10.0807141351540.12484@xanadu.home> <7v3amcgujd.fsf@gitster.siamese.dyndns.org> <20080715092023.GO10151@machine.or.cz> <20080715150626.GA2925@dpotapov.dyndns.org>
 <alpine.DEB.1.00.0807151623120.8950@racer> <7v3amb0ymg.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807160005540.2990@eeepc-johanness> <7vd4lezske.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Nicolas Pitre <nico@cam.org>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 00:46:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KItHd-0003eG-HK
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 00:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662AbYGOWpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 18:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756252AbYGOWpI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 18:45:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:58697 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755262AbYGOWpH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 18:45:07 -0400
Received: (qmail invoked by alias); 15 Jul 2008 22:45:05 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp019) with SMTP; 16 Jul 2008 00:45:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19hHCwAxLthEMbJM66LNUtVbnYDI63ZBIsWcRkFvh
	4U/ts0efXlRCP9
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7vd4lezske.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88613>

Hi,

On Tue, 15 Jul 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Having said that, I do not have the resources to test and fix 
> > everything that may arise from Debian being seemingly unable to update 
> > to Git 1.5.
> 
> Heh, what happent to your earlier "a few minutes for Junio to change and 
> commit"?

That was meant for the integration of the patch that makes the 
backwards-incompatible patch.

Not for the necessary forward-compatible changes.

Ciao,
Dscho
