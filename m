From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Many things pushed out to 'master'
Date: Mon, 3 Dec 2007 18:39:14 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712031838450.27959@racer.site>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
 <ee77f5c20712021539r3075fc57ld6a4cec737e6043d@mail.gmail.com>
 <7vabosse23.fsf@gitster.siamese.dyndns.org> <7vbq98jdy5.fsf_-_@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712031109380.27959@racer.site> <7v1wa3iquj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 19:40:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzGD4-0007V5-96
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 19:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbXLCSji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 13:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbXLCSji
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 13:39:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:33068 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752648AbXLCSjh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 13:39:37 -0500
Received: (qmail invoked by alias); 03 Dec 2007 18:39:36 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 03 Dec 2007 19:39:36 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18/Qq9OZ0I/yqHf674FGBPBTtqUroLVy333nK697B
	4c0QbsYz6pkA/b
X-X-Sender: gene099@racer.site
In-Reply-To: <7v1wa3iquj.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66945>

Hi,

On Mon, 3 Dec 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > But I remembered that you requested a mode for signed tags where they 
> > would just be copied.  I just realised while implementing "verbatim" 
> > that "ignore" does just that.  Maybe we should rename this mode to 
> > "verbatim"?
> >
> > And maybe you want to make it the default (even if I think that this 
> > will result in more surprise moments than the current mode which 
> > aborts).
> 
> I did not hear others agreeing with me, so let's respect the original 
> author's thinking.

But the original author already admitted that the original naming was 
stupid...

Ciao,
Dscho
