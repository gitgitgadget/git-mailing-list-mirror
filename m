From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Sat, 26 Jul 2008 04:09:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807260407170.11976@eeepc-johanness>
References: <7vej5kfs0w.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807231817460.8986@racer> <488772BC.80207@workspacewhiz.com> <32541b130807231133x37083278u1badd82b5c48e57b@mail.gmail.com> <alpine.DEB.1.00.0807231956280.8986@racer>
 <FB7ABDC5-8505-4FD1-8082-9BB5013E73C6@orakel.ntnu.no> <alpine.DEB.1.00.0807232041570.8986@racer> <3B9933A6-9637-41AE-9133-9B6EA9204E6B@orakel.ntnu.no> <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness> <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no>
 <20080725140142.GB2925@dpotapov.dyndns.org> <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Sat Jul 26 04:09:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMZEB-0003nd-4r
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 04:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbYGZCIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 22:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbYGZCIm
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 22:08:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:44420 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752026AbYGZCIl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 22:08:41 -0400
Received: (qmail invoked by alias); 26 Jul 2008 02:08:39 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp010) with SMTP; 26 Jul 2008 04:08:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Bojp1clpBKosk7CxFbGpzSwgNxNthLwbtqs/cyy
	rh7RFPyje+txUV
X-X-Sender: user@eeepc-johanness
In-Reply-To: <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90147>

Hi,

On Fri, 25 Jul 2008, Eyvind Bernhardsen wrote:

> That is an excellent argument for why setting "autocrlf=true" by default 
> on Windows was a bad idea.  Thanks! :)

Well, these days, I tend to give a flying nothing to opinions that are not 
backed up by any effort toward the project.

In other words, if you have not participated in the community process to 
find what is best for Git, you could just as well say that you want the 
moon to be green, and I could not care less (in both cases).

Ciao,
Dscho
