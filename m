From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [ANNOUNCE] Guilt 0.16
Date: Sat, 6 Jan 2007 21:07:17 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0701062104480.27682@yvahk01.tjqt.qr>
References: <20070106184639.GC12543@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 21:08:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3Hpr-0002Dx-38
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 21:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbXAFUIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 15:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbXAFUIG
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 15:08:06 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:37391 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143AbXAFUID (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 15:08:03 -0500
Received: from linux01.gwdg.de ([134.76.13.21])
	by mailer.gwdg.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <jengelh@linux01.gwdg.de>)
	id 1H3Hph-0002tI-1z; Sat, 06 Jan 2007 21:08:01 +0100
Received: from linux01.gwdg.de (localhost [127.0.0.1])
	by linux01.gwdg.de (8.13.3/8.13.3/SuSE Linux 0.7) with ESMTP id l06K7Ho6010879;
	Sat, 6 Jan 2007 21:07:19 +0100
Received: from localhost (jengelh@localhost)
	by linux01.gwdg.de (8.13.3/8.13.3/Submit) with ESMTP id l06K7Hvn010873;
	Sat, 6 Jan 2007 21:07:17 +0100
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
In-Reply-To: <20070106184639.GC12543@filer.fsl.cs.sunysb.edu>
X-Spam-Level: /
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
X-Virus-Scanned: (clean) by exiscan+sophie
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36098>


On Jan 6 2007 13:46, Josef Sipek wrote:
>
>Guilt (Git Quilt) is a series of bash scripts which add a Mercurial

"I feel so guilty when using guilt!"

Oh well I should point out that people should give
tools a better naming. :-)
Prime examples are "Squid", "Icecream", and to a
lesser extent "Apache".
Perhaps gquilt?

>queues-like [1] functionality and interface to git.  The one distinguishing
>feature from other quilt-like porcelains, is the format of the patches
>directory. _All_ the information is stored as plain text - a series file and
>the patches (one per file). This easily lends itself to versioning the
>patches using any number of of SCMs.

	-`J'
-- 
