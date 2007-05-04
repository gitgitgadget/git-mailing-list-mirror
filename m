From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support ent:relative_path
Date: Fri, 4 May 2007 21:00:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705042025130.4015@racer.site>
References: <463ADE51.2030108@gmail.com>  <56b7f5510705040022x2e4903d3hbe4ac1ee1a2e096f@mail.gmail.com>
  <7v7irpuhhr.fsf@assigned-by-dhcp.cox.net> 
 <81b0412b0705040147h1bab8f6ao3ce2c486637a0d4f@mail.gmail.com> 
 <56b7f5510705040153i65ba6260v9fbe7a90e040cab3@mail.gmail.com> 
 <81b0412b0705040217o54d1d028j6e768bdc3eb0bad0@mail.gmail.com> 
 <56b7f5510705040226o14d55b6euda7df1da7ad9b08a@mail.gmail.com> 
 <81b0412b0705040246r5a2726b8g4323cadeacee3aa7@mail.gmail.com> 
 <56b7f5510705040957v4580b6c1xbe767892ada3bcde@mail.gmail.com>
 <81b0412b0705041017l1ceb419j733e9cf3389e9709@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk326-0005UD-GP
	for gcvg-git@gmane.org; Fri, 04 May 2007 21:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161877AbXEDTBK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 15:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161903AbXEDTBJ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 15:01:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:47337 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161895AbXEDTBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 15:01:05 -0400
Received: (qmail invoked by alias); 04 May 2007 19:01:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 04 May 2007 21:01:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190jfY0JYJ08b3tJzRRpqKmTBe61xpWQfEbNOVEmg
	g/SxnsjEkfH+QV
X-X-Sender: gene099@racer.site
In-Reply-To: <81b0412b0705041017l1ceb419j733e9cf3389e9709@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46200>

Hi,

On Fri, 4 May 2007, Alex Riesen wrote:

> On 5/4/07, Dana How <danahow@gmail.com> wrote:
>
> > II. Make :/string a full path, and ://string match ^string .
> >    Is changing the current :/string to ://string less painful/dangerous?
> 
> Johannes?

Huh? Hello!

I did not follow this thread closely...

Having said that, I think ":./bla/blub" is the most intuitive, and the 
least breaking.

You _could_ change the current :/ notation, but _why_?

Ciao,
Dscho
