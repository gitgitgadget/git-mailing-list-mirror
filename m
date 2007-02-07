From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH for 'next'] fast-import: in_merge_bases() has a different
 signature now
Date: Wed, 7 Feb 2007 12:42:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702071241200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702071235370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: junkio@cox.net
To: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 07 12:42:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HElCF-00069O-JK
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 12:42:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbXBGLmk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 06:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161225AbXBGLmk
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 06:42:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:47397 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161223AbXBGLmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 06:42:40 -0500
Received: (qmail invoked by alias); 07 Feb 2007 11:42:38 -0000
X-Provags-ID: V01U2FsdGVkX1+RPQUYZUeRifam9yNp77F4/t4tErgfpW+ofebvWG
	lbcQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0702071235370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38915>

Hi,

Ooops. I just realized that I merged 'master' into 'next'. Shawn, or 
Junio, when you actually do that merge, you might want to pick up this 
patch, too.

Ciao,
Dscho
