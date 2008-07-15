From: Nicolas Pitre <nico@cam.org>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 12:26:48 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0807151213000.12484@xanadu.home>
References: <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org>
 <7vabgqsc37.fsf@gitster.siamese.dyndns.org>
 <7vtzetjbif.fsf@gitster.siamese.dyndns.org>
 <7vzlokhpk7.fsf@gitster.siamese.dyndns.org>
 <20080714085555.GJ32184@machine.or.cz>
 <alpine.DEB.1.00.0807141256310.8950@racer>
 <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org>
 <alpine.LFD.1.10.0807141351540.12484@xanadu.home>
 <7v3amcgujd.fsf@gitster.siamese.dyndns.org>
 <20080715092023.GO10151@machine.or.cz>
 <20080715150626.GA2925@dpotapov.dyndns.org>
 <alpine.DEB.1.00.0807151623120.8950@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Dmitry Potapov <dpotapov@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 18:28:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KInOF-0002l5-1l
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 18:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbYGOQ1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 12:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753175AbYGOQ1b
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 12:27:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65238 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbYGOQ1b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 12:27:31 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K4200DWD30OCZ10@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 15 Jul 2008 12:26:48 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0807151623120.8950@racer>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88576>

On Tue, 15 Jul 2008, Johannes Schindelin wrote:

> And I absolutely agree with Pasky that this does _nothing_ in the vague 
> direction of wielding a reputation of being easy to use.

Staying with git versions prior 1.5 isn't either.  In fact, git had a 
much harder time with its usability reputation in those days.  In other 
words, if some user of Debian is rebutted by the upgrade path for a later 
git version, then the awkwardness of git 1.4.4 UI will be even worse.

Anyway this is all hand waving until someone can come with some evidence 
that git 1.4.4 is actually used by a significant amount of people, and 
that those people depend on dumb transfer protocols.


Nicolas
