From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
Subject: RE: linux-2.6.git mirror
Date: Fri, 19 Oct 2007 15:50:17 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2701685385@az33exm24.fsl.freescale.net>
References: <598D5675D34BE349929AF5EDE9B03E2701684C77@az33exm24.fsl.freesca le.net> <alpine.LFD.0.999.0710181518120.26902@woody.linux-foundation.org> <598D5675D34BE349929AF5EDE9B03E270168517F@az33exm24.fsl.freescale.net> <alpine.LFD.0.999.0710181617090.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 20 00:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij0fz-0005X8-Ff
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 00:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965764AbXJSWu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 18:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935822AbXJSWu0
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 18:50:26 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:37868 "EHLO
	az33egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbXJSWuY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Oct 2007 18:50:24 -0400
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id l9JMoIFM002393
	for <git@vger.kernel.org>; Fri, 19 Oct 2007 15:50:19 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9JMoIU5000106
	for <git@vger.kernel.org>; Fri, 19 Oct 2007 17:50:18 -0500 (CDT)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <alpine.LFD.0.999.0710181617090.26902@woody.linux-foundation.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: linux-2.6.git mirror
Thread-Index: AcgR3iY2JiSoSs2LQsyjgqmDHc/7owAw5RmA
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61772>

Hi Linus,


> And yes, I think this should go into Shawns tree of fixes, 
> assuming that 
> Emil confirms that it fixes it for him.

Indeed, I don't get the error message anymore. Thanks for your help.

A remaining question is why I wasn't seeing that error message on normal
clones, i.e. non-mirrors (with +refs/heads/*:refs/remotes/origin/* fetch
refspec as oposed to +refs/*:refs/* fetch refspec)?


Thanks again,
Emil.
