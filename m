From: Jon Loeliger <jdl@freescale.com>
Subject: Proper Publishing of a Repository
Date: Wed, 22 Mar 2006 13:17:52 -0600
Message-ID: <1143055072.4527.142.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Mar 22 20:18:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM8r5-0002NH-JQ
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 20:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWCVTSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 14:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWCVTSp
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 14:18:45 -0500
Received: from az33egw02.freescale.net ([192.88.158.103]:56032 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S932376AbWCVTSo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 14:18:44 -0500
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id k2MJWoR6008666
	for <git@vger.kernel.org>; Wed, 22 Mar 2006 12:32:50 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k2MJSife018122
	for <git@vger.kernel.org>; Wed, 22 Mar 2006 13:28:44 -0600 (CST)
To: Git List <git@vger.kernel.org>
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.ydl.1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17822>

Folks,

So, I feel like I missed a step in the grand
"How To Publish A Repository" scheme of things.

I made a repo visible over on jdl.com.  No problem.
But cloning it took forever.  So I ran "git-repack"
on it.  Now cloning only takes hours, not forever.

All this on the linux kernel over HTTP.

Did I miss a step somewhere?

Thanks,
jdl
