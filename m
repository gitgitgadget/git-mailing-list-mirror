From: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
Subject: RE: Did I miss something? git-clone doesn't grab all branches????
Date: Fri, 30 Mar 2007 09:30:33 -0700
Message-ID: <AF0367BA48C55940A43CCF08DF35553C0114148C@az33exm24.fsl.freescale.net>
References: <460D336E.9040708@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "Tabi Timur-B04825" <timur@freescale.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 18:30:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXJzv-0001Ip-2s
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 18:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbXC3Qaj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 12:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbXC3Qaj
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 12:30:39 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:63872 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbXC3Qai convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Mar 2007 12:30:38 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l2UGUZNw027857
	for <git@vger.kernel.org>; Fri, 30 Mar 2007 09:30:36 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2UGUZua021629
	for <git@vger.kernel.org>; Fri, 30 Mar 2007 11:30:35 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <460D336E.9040708@freescale.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Did I miss something? git-clone doesn't grab all branches????
Thread-Index: Acdy5DFymCQ9Ymt0SheEefi1fL8oowABEZZQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Timur,

You missed something. :-) You didn't read the Release
Notes for 1.5 that I forwarded.  As a start, do this:

    git branch -a
 
Jdl
