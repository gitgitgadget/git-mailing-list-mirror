From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 15:43:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021541520.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site>
 <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>
 <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Thu Aug 02 16:44:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGbuD-0003Xm-Sv
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 16:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbXHBOn6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 10:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753107AbXHBOn6
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 10:43:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:60773 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752871AbXHBOn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 10:43:57 -0400
Received: (qmail invoked by alias); 02 Aug 2007 14:43:56 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp050) with SMTP; 02 Aug 2007 16:43:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Xokpze4JXWhNMRVEJpLWIIuX/rEaiC3AsyXRfY6
	1qMQZ7xiayBet4
X-X-Sender: gene099@racer.site
In-Reply-To: <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54554>

Hi,

[please do not top-post.  Either comment on what you quote, or delete it.]

On Thu, 2 Aug 2007, Jean-Fran?ois Veillette wrote:

> Admin it, git porcelain still has some work to be done.

No need to argue there, I admit it.

> We can't expect new users to know the git internals workflow before they 
> can use git effectively.

This use case has not much to do with new users.  A new user _has_ to know 
that updating all files, even if their content does not change, is not 
right.

At least we do not commit empty changes like CVS did all too happily.

Ciao,
Dscho
