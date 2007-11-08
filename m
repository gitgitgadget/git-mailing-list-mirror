From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: RE: GIT_DIR/--git-dir question
Date: Fri, 9 Nov 2007 00:24:52 +0100
Message-ID: <008701c8225e$90f38dd0$5267a8c0@Jocke>
References: <007c01c8223a$6af2e550$5267a8c0@Jocke> <7vfxzg1jpb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:01:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIF9-00047A-LL
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707AbXKHXdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 18:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757944AbXKHXdw
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 18:33:52 -0500
Received: from mail.transmode.se ([83.241.175.147]:54125 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756447AbXKHXdv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 18:33:51 -0500
Received: from Jocke ([84.217.6.238]) by tmnt04.transmode.se with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 9 Nov 2007 00:25:09 +0100
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <7vfxzg1jpb.fsf@gitster.siamese.dyndns.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.3198
Thread-Index: AcgiUs6qmgY6RXEiQpuPtd8N1jIaswAC1j1A
X-OriginalArrivalTime: 08 Nov 2007 23:25:09.0144 (UTC) FILETIME=[9A52B180:01C8225E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64088>

> From: Junio C Hamano [mailto:gitster@pobox.com] 
> Sent: den 8 november 2007 23:01
> To: Joakim Tjernlund
> Cc: git@vger.kernel.org
> Subject: Re: GIT_DIR/--git-dir question
> 
> "Joakim Tjernlund" <joakim.tjernlund@transmode.se> writes:
> 
> > I just started to look at having multiple work trees, each 
> working on a separate branch,
> > using the same git repo.
> 
> I suspect contrib/workdir is what you are looking for not
> GIT_DIR.

Yes, it does look like what I am looking for. But now I am 
a bit confused as to what GIT_DIR/--git-dir is supposed to be
used for.

 Jocke
