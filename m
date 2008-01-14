From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more
 user-friendly
Date: Mon, 14 Jan 2008 20:22:15 +0000 (GMT)
Message-ID: <alpine.DEB.1.00.0801142019360.23987@eeepc-johanness>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org> <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801141220001.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7v1w8kkxo7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 21:22:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEVpX-0005aD-2m
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 21:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbYANUWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 15:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbYANUWS
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 15:22:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:45188 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750868AbYANUWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 15:22:17 -0500
Received: (qmail invoked by alias); 14 Jan 2008 20:22:15 -0000
Received: from unknown (EHLO eeepc-johanness.st-andrews.ac.uk) [138.251.11.75]
  by mail.gmx.net (mp048) with SMTP; 14 Jan 2008 21:22:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184t5Z2AnQ4T+OtcGj9ELIRHbsET9rOxXHZzDIyK8
	vxYGTuDrU006js
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v1w8kkxo7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70473>

Hi,

On Mon, 14 Jan 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 13 Jan 2008, Junio C Hamano wrote:
> >
> >> The second one to add a couple of "goto cleanup" looked correct.  
> >> Acks, people?
> >
> > I haven't used http-push in ages, but there was a bug report with 
> > msysgit.  Hopefully that issue gets fixed by this patch.
> 
> Could you work with the reporter to see if this fixes the issue for him?

I wanted to try to reproduce first, but I had definitely not enough time 
for git today.

Will try to find some time tomorrow,
Dscho
