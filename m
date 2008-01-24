From: "Anthony Bolton" <Anthony.Bolton@ipl.com>
Subject: Query about documentation of git pull -n
Date: Thu, 24 Jan 2008 09:24:55 -0000
Message-ID: <72481CA3A5A6474EA49CFD2CF28A5D5D02CA348A@hektor.iplbath.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 10:25:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHyL4-0001Kk-Ia
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 10:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbYAXJZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 04:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbYAXJZI
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 04:25:08 -0500
Received: from vanessa.ipl.com ([217.205.167.12]:33040 "EHLO vanessa.ipl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752883AbYAXJZG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jan 2008 04:25:06 -0500
X-IPL-MailScanner-Watermark: 1201771496.99123@k8jnwBp22F4Qv/XONRcURA
Received: from hektor.iplbath.com (hektor [192.0.0.90])
	by vanessa.ipl.com (8.13.1/8.13.1) with ESMTP id m0O9OtjG000907
	for <git@vger.kernel.org>; Thu, 24 Jan 2008 09:24:55 GMT
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Query about documentation of git pull -n
Thread-Index: Acheas7nEglouqNmTL25mNnhC3RFZg==
X-IPL-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71609>

Comment from a new user:
 
The git-pull man pages imply that "git pull -n" and "git pull --no-tags"
are the same, but -n seems to do something different entirely (same with
git fetch). I found this in msysgit but the msysgit boys say that it's
actually a problem with core git.
 
If -n is intended to be different from --no-tags than can you update the
documentation please?
 
Regards,
Anthony
____________________________________________________________

Anthony Bolton
phone: +44 (0)1225 475290, email: anthony.bolton@ipl.com

IPL Information Processing Limited 
www.ipl.com
____________________________________________________________


 


The information transmitted is intended only for the person
or entity to which it is addressed and may contain
confidential and/or privileged material. If you are not the
addressee, any disclosure, reproduction, copying,
distribution, or other dissemination or use of this
communication is strictly prohibited. If you have received
this transmission in error please notify the sender
immediately and then delete this email.

Any representations or commitments expressed in this email
are subject to contract.

This message has been scanned for viruses and dangerous
content. However, it is essential that the recipient also
checks this message using commercially available mail
scanning and anti-virus software. IPL Information Processing
Limited accepts no liability for any loss or damage resulting
from any virus or other dangerous content in this message.

IPL Information Processing Limited is registered in England
and Wales under company registration number 1418818.
Registration took place at Cardiff on 10 May 1979. IPL
Information Processing Limited's registered office and
normal place of business is Eveleigh House, Grove Street,
Bath, BA1 5LR, United Kingdom. IPL is also registered for
Value Added Tax (VAT) under registration number GB 601 2931 83.
