From: Tim Mazid <timmazid@hotmail.com>
Subject: RE: git & patterns
Date: Thu, 19 May 2011 16:54:04 +1000
Message-ID: <SNT124-W262001D726480B1E78D059C48E0@phx.gbl>
References: <4DD3A402.3040802@hupie.com>,<7vsjsbbx7h.fsf@alter.siamese.dyndns.org>,<4DD4B772.2050404@hupie.com>,<SNT124-w95A0758AAE98C128DB9A2C48E0@phx.gbl>
 <SNT124-W45CEA4AD8A3564C9F78071C48E0@phx.gbl>,<4DD4BCB2.5080309@hupie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <gitster@pobox.com>, Git Mailing List <git@vger.kernel.org>
To: <mailings@hupie.com>
X-From: git-owner@vger.kernel.org Thu May 19 08:54:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMx7b-000622-VK
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 08:54:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760Ab1ESGyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 02:54:06 -0400
Received: from snt0-omc2-s9.snt0.hotmail.com ([65.55.90.84]:65471 "EHLO
	snt0-omc2-s9.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932304Ab1ESGyF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 02:54:05 -0400
Received: from SNT124-W26 ([65.55.90.71]) by snt0-omc2-s9.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Wed, 18 May 2011 23:54:04 -0700
X-Originating-IP: [27.32.25.138]
Importance: Normal
In-Reply-To: <4DD4BCB2.5080309@hupie.com>
X-OriginalArrivalTime: 19 May 2011 06:54:04.0291 (UTC) FILETIME=[8A903530:01CC15F1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173940>


> From: mailings@hupie.com
> On 05/19/2011 08:43 AM, Tim Mazid wrote:
> >
> >> Is there a "concepts" or "glossary" man page or similar somewhere that
> >> explains all the terms used in git that an "outsider" (somebody who does
> >> not develop git and just began to use it) might not be aware of?
> >
> > Well, I look like an idiot; I just found the glossary man page.
> >
> > However, there is no entry for "glob", or anything about pathnames.
> >
>
> Well glob is 'real easy' to find, once you actually know that the code
> calls fnmatch :-) :-)
>
> man fnmatch points to man 7 glob :-)
>
> A regular git user will never know this so adding it to the glossary
> seems a good idea

Yes... I was merely demonstrating a point... I knew that all along... >.>

Onto the glossary, though; I did not even know it existed until just now 
when I tried to look for it. Nothing ever told me "if you're confused
about anything, go 'git help glossary'". I don't think it was ever in
the "see also" sections of other pages.

Out of curiosity, did Linus/Junio write the majority of the 
documentation? I know it is difficult to write documentation for those
who don't know once you already know what is going on.


() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
 		 	   		  