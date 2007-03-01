From: "Li Yang-r58472" <LeoLi@freescale.com>
Subject: gitweb not friendly to firefox?
Date: Thu, 1 Mar 2007 18:57:39 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DA70E@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 01 11:56:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMixT-00084S-Oz
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 11:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbXCAK4W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 05:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbXCAK4W
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 05:56:22 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:49483 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964936AbXCAK4V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2007 05:56:21 -0500
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l21AuIWD028021
	for <git@vger.kernel.org>; Thu, 1 Mar 2007 03:56:19 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l21AuHTX028100
	for <git@vger.kernel.org>; Thu, 1 Mar 2007 04:56:17 -0600 (CST)
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: gitweb not friendly to firefox?
Thread-Index: Acdb8G3uf/tf6dfUTgWQc6ZteCG5Eg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41081>

Hi,

I'm using gitweb from latest git tree.  I can't view any objects with my
firefox browser, but it works ok with my IE.  The error is like this:

XML Parsing Error: not well-formed
Location:
http://10.193.20.133/gitweb/?p=linux-2.6.git;a=commit;h=c0051ec763eca4c1
adfcb8d461243d0a7b444bb7
Line Number 43, Column 38:<tr><td>author</td><td>Li Yang
<LeoLi@freescale.com></td></tr>
-------------------------------------^


Would it be anything wrong with my gitweb configuration or apache setup?

Thanks,
Leo
