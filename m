From: "Raimund Bauer" <ray@softwarelandschaft.com>
Subject: RE: gitweb not friendly to firefox?
Date: Thu, 1 Mar 2007 15:26:43 +0100
Organization: Softwarelandschaft
Message-ID: <001001c75c0d$a2840600$0b0aa8c0@abf.local>
References: <20070301140046.GM57456@codelabs.ru>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Li Yang-r58472'" <LeoLi@freescale.com>, <git@vger.kernel.org>
To: "'Eygene Ryabinkin'" <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Thu Mar 01 15:56:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMmFH-0000Yu-1v
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 15:26:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbXCAO0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 09:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbXCAO0q
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 09:26:46 -0500
Received: from s15211414.onlinehome-server.info ([87.106.16.196]:58127 "EHLO
	s15211414.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965084AbXCAO0p (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2007 09:26:45 -0500
Received: (qmail 23644 invoked from network); 1 Mar 2007 15:31:59 +0100
Received: from host-62-245-155-90.customer.m-online.net (HELO swl011) (62.245.155.90)
  by s15211414.onlinehome-server.info with SMTP; 1 Mar 2007 15:31:59 +0100
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <20070301140046.GM57456@codelabs.ru>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41097>

> I think that the situation is simpler: <LeoLi@....> is taken 
> as the XML/HTML tag and it
> - does not closed anywhere,
> - has the wrong syntax, since "@" and "." can not live inside 
> the tag name if memory serves me right.
> 
> The proper thing is to replace "<" with "&lt;" and ">" with "&gt;".

Yes ... I should learn to write out what I mean and not only hint at it ;-)

-- 
best regards

  Ray
