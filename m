From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] git-gui: Allow "Stage Line" to stage adjacent
	changes independently
Date: Wed, 16 Jul 2008 00:35:03 +0000
Message-ID: <20080716003503.GA24339@spearce.org>
References: <1216156261-9687-1-git-send-email-johannes.sixt@telecom.at> <1216156261-9687-2-git-send-email-johannes.sixt@telecom.at> <7vy742zul7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Wed Jul 16 02:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIv01-0005UY-Ir
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 02:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbYGPAfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 20:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754026AbYGPAfF
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 20:35:05 -0400
Received: from george.spearce.org ([209.20.77.23]:56843 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbYGPAfE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 20:35:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A12C73836B; Wed, 16 Jul 2008 00:35:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vy742zul7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88615>

Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <johannes.sixt@telecom.at> writes:
> 
> > Consider this hunk:
> >
> >   @@ -10,4 +10,4 @@
> >    context before
> >   -old 1
> >   -old 2
> >   +new 1
> >   +new 2
> >    context after
> >
> > [Nomenclature: to "stage change 2" means to stage lines "-old 1" and
> > "+new 1", in any order; likewise for "unstage" and "change 2".]
> 
> You lost me.
...
> and try explaining what you are doing again, pretty please?

Me too.  I really appreciate the effort spent to improve this
feature, but I really didn't follow the commit message at all.  :-|

-- 
Shawn.
