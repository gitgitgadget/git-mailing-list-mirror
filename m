From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 00:15:06 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001300011290.1681@xanadu.home>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <7vaavwh6yh.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1001291833580.1681@xanadu.home>
 <7vy6jgcutb.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001291618m71f61209v4f26fb66c6ad99ae@mail.gmail.com>
 <7viqakcu56.fsf@alter.siamese.dyndns.org>
 <ca433831001291701m50b8c2b7p16bcc6fd4f3f3d55@mail.gmail.com>
 <alpine.LFD.2.00.1001292013150.1681@xanadu.home>
 <ron1-F006CF.18381129012010@news.gmane.org>
 <7vbpgc8fhb.fsf@alter.siamese.dyndns.org>
 <76718491001292052x7f46d479lfeff7b66121502c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_UKuMa3GYe0nQM/CJ3uXVFQ)"
Cc: Junio C Hamano <gitster@pobox.com>, Ron Garret <ron1@flownet.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 06:15:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb5fw-0004Vy-89
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 06:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965Ab0A3FPK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 00:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919Ab0A3FPI
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 00:15:08 -0500
Received: from relais.videotron.ca ([24.201.245.36]:65507 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab0A3FPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 00:15:07 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX100ID3NX6V500@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 30 Jan 2010 00:15:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <76718491001292052x7f46d479lfeff7b66121502c3@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138445>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_UKuMa3GYe0nQM/CJ3uXVFQ)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Fri, 29 Jan 2010, Jay Soffian wrote:

> > When HEAD points at a branch, making a commit advances _that_ branch.  And
> > we say you are "on that branch".  When HEAD is detached, because it is not
> > attached to anything, it advances no branch.  "detached HEAD" is detached
> > in the very real sense.  It is not attached to _any_ branch.
> 
> Let me try wording this slightly different, because I think I can see
> Ron's confusion.
[...]

Could you please take this really nice explanation and make it into a 
patch adding a "Detached HEAD" section in the git-checkout.txt manual 
page please?


Nicolas

--Boundary_(ID_UKuMa3GYe0nQM/CJ3uXVFQ)--
