From: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: RE: gitweb not friendly to firefox?
Date: Thu, 1 Mar 2007 19:54:39 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DA710@zch01exm26.fsl.freescale.net>
References: <200703011134.22451.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: "Andy Parkins" <andyparkins@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 12:53:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMjqc-0004ke-If
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 12:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbXCALxV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 06:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbXCALxV
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 06:53:21 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:56875 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965013AbXCALxU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2007 06:53:20 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l21BrHV8007607
	for <git@vger.kernel.org>; Thu, 1 Mar 2007 04:53:17 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l21BrFmN015127
	for <git@vger.kernel.org>; Thu, 1 Mar 2007 05:53:16 -0600 (CST)
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <200703011134.22451.andyparkins@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gitweb not friendly to firefox?
Thread-Index: Acdb9ZmRhI2Y08BsS3+EkW3KSwKA7wAAkIXA
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41089>

> -----Original Message-----
> From: Andy Parkins [mailto:andyparkins@gmail.com]
> Sent: Thursday, March 01, 2007 7:34 PM
> To: git@vger.kernel.org
> Cc: Li Yang-r58472
> Subject: Re: gitweb not friendly to firefox?
> 
> On Thursday 2007 March 01 10:57, Li Yang-r58472 wrote:
> 
> > XML Parsing Error: not well-formed
> > Location:
> >
http://10.193.20.133/gitweb/?p=linux-2.6.git;a=commit;h=c0051ec763eca4c1
> > adfcb8d461243d0a7b444bb7
> > Line Number 43, Column 38:<tr><td>author</td><td>Li Yang
> > <LeoLi@freescale.com></td></tr>
> > -------------------------------------^
> >
> >
> > Would it be anything wrong with my gitweb configuration or apache
setup?
> 
> When I've had errors like that in the past it has been because:
>  a) Firefox installation corrupt; try running with a new profile
>     (firefox -ProfileManager)

I have reinstalled my firefox and updated to 2.0.0.2
>  b) Firefox has been upgraded but you haven't restarted it since.

It is restarted.
>  c) An extension is incompatible with your current version, but
doesn't know
>     it

I have disabled all the add-ons

And the problem still exists.  :(

- Leo
