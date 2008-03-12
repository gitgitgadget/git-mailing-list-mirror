From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Wed, 12 Mar 2008 17:05:51 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803121705330.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <7vbq5k77z0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803121153160.1656@racer.site>
 <alpine.LFD.1.00.0803121143170.2947@xanadu.home> <FE263BF7-9948-463C-B9B2-833B068EB10B@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Mar 12 17:07:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZTTF-0007iR-82
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 17:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293AbYCLQFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 12:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbYCLQFq
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 12:05:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:55247 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751098AbYCLQFp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 12:05:45 -0400
Received: (qmail invoked by alias); 12 Mar 2008 16:05:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp025) with SMTP; 12 Mar 2008 17:05:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6c+gwYpS6P2+vjJuZC1KU+3clQm7jcz4mytrZA+
	dYpa+BV+vJX7+J
X-X-Sender: gene099@racer.site
In-Reply-To: <FE263BF7-9948-463C-B9B2-833B068EB10B@ai.rug.nl>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76962>

Hi,

On Wed, 12 Mar 2008, Pieter de Bie wrote:

> On Mar 12, 2008, at 4:45 PM, Nicolas Pitre wrote:
> 
> > 2 weeks is OTOH maybe a bit too conservative.
> >
> > What about one week instead?
> 
> I'd really like it to be at least 2 weeks

Could you back that up with an explanation, as to why?

Thanks,
Dscho
