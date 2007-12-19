From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git with custom diff for commits
Date: Wed, 19 Dec 2007 12:09:41 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712191209140.23902@racer.site>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
 <Pine.LNX.4.64.0712172300510.9446@racer.site> <vpq1w9kaphg.fsf@bauges.imag.fr>
 <Pine.LNX.4.64.0712172310090.9446@racer.site> <7vbq8o6gxw.fsf@gitster.siamese.dyndns.org>
 <vpqk5ncz8fn.fsf@bauges.imag.fr> <7vodco1him.fsf@gitster.siamese.dyndns.org>
 <000001c841b5$89fcef00$762a14ac@na.acco.com> <7vzlw7ybx7.fsf@gitster.siamese.dyndns.org>
 <000101c841b7$5f1d1060$762a14ac@na.acco.com> <vpqsl1zfz8r.fsf@bauges.imag.fr>
 <000d01c841c5$386f7350$762a14ac@na.acco.com> <Pine.LNX.4.64.0712182246230.23902@racer.site>
 <vpqtzmfvz1d.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Gerald Gutierrez <ggmlfs@gmail.com>,
	'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Dec 19 13:10:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4xkl-0004ZZ-Rp
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 13:10:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752887AbXLSMKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 07:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbXLSMKA
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 07:10:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:55720 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752673AbXLSMJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 07:09:59 -0500
Received: (qmail invoked by alias); 19 Dec 2007 12:09:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 19 Dec 2007 13:09:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wL5UguLTws2JHGmv/1zbg0415XtqdMTS1TZVeNy
	ygXXleEhQjzwki
X-X-Sender: gene099@racer.site
In-Reply-To: <vpqtzmfvz1d.fsf@bauges.imag.fr>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68899>

Hi,

On Wed, 19 Dec 2007, Matthieu Moy wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Here's what the git-commit manpage on kernel.org says: "git-commit - 
> >> Record changes to the repository".
> >
> > Yes.  Changes, as in "take this _file_ instead".  Not "edit this file, 
> > remove those lines, add these here, etc.".
> 
> That said, I think the wording of the man page could be better.
> Perhaps "Record new snapshot to the repository" or "Record current
> state of the working tree to the repository".

How about "record a new revision"?

Ciao,
Dscho
