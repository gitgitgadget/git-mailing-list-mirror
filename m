From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Closing the merge window for 1.6.0
Date: Wed, 16 Jul 2008 00:10:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807160005540.2990@eeepc-johanness>
References: <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer>
 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org> <alpine.LFD.1.10.0807141351540.12484@xanadu.home> <7v3amcgujd.fsf@gitster.siamese.dyndns.org> <20080715092023.GO10151@machine.or.cz> <20080715150626.GA2925@dpotapov.dyndns.org>
 <alpine.DEB.1.00.0807151623120.8950@racer> <7v3amb0ymg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Nicolas Pitre <nico@cam.org>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 00:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIsjk-0001VA-BA
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 00:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755990AbYGOWKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 18:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755959AbYGOWKI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 18:10:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:50246 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755787AbYGOWKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 18:10:06 -0400
Received: (qmail invoked by alias); 15 Jul 2008 22:10:05 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp051) with SMTP; 16 Jul 2008 00:10:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xtHQUAL/xCHJ0qQ+qubzC0kovZSTaiJFZKpCgEj
	GW1gPNPV7Sov+N
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v3amb0ymg.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88609>

Hi,

On Tue, 15 Jul 2008, Junio C Hamano wrote:

> What troubles me the most is that you seem to be forgetting that we are 
> using git to manage our codebase.

I don't.  I have vivid memories of updating an ancient git repository of 
Git itself, which had some almost forgotten changes in it.  That was in 
the bad old days, when the version number did not even have a "1" in it.

It could not even fetch the current git.git.

I do _not_ want that to happen to anybody else, _even if_ we leave 1.4.4.4 
Behind as if it was an American Child.

Having said that, I do not have the resources to test and fix everything 
that may arise from Debian being seemingly unable to update to Git 1.5.  
So I agree completely that the ball is in Debian's half, and if they let 
it rot, it is sad, but I cannot help it.

Ciao,
Dscho
