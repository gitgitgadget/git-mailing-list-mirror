From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/11] Miscellaneous MinGW port fallout
Date: Wed, 14 Nov 2007 20:45:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711142040400.4362@racer.site>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <7vir45hyyn.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711141441530.4362@racer.site>
 <7vzlxgfuwc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:46:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsP81-0000aL-6H
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbXKNUqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 15:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbXKNUqG
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:46:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:43017 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751741AbXKNUqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 15:46:05 -0500
Received: (qmail invoked by alias); 14 Nov 2007 20:46:01 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 14 Nov 2007 21:46:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PGrsgvJpPRsejNcpC7OBt/Dh5ztV7n7wXa896z4
	/gpnZOdrNCb7IO
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzlxgfuwc.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65013>

Hi,

On Wed, 14 Nov 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 14 Nov 2007, Junio C Hamano wrote:
> >
> >> Johannes Sixt <johannes.sixt@telecom.at> writes:
> >> 
> >> > This is a series of smallish, unrelated changes that were necessary
> >> > for the MinGW port.
> >> 
> >> I was _VERY_ afraid of reviewing this series.
> >
> > Why?  Because we get closer to MinGW integration into git.git for real? 
> > ;-)
> 
> I know you know me better than that.
> 
> Conversion from "Too UNIXy" stuff into another form that "claims to" run 
> on a different platform that I do not have a good way of testing myself?  
> I should feel scared, even if I can always punt and say "I'll only make 
> sure UNIX side does not regress, Windose, who cares" ;-).

Yes, I do know you better than that. But I guess git grows up, and there 
is no way that you can guarantee it to perform well everywhere.

But I know some people who will make sure that it works on Windows.  For 
them, at least. ;-)

Ciao,
Dscho
