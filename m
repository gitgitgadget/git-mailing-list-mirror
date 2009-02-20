From: eletuchy@gmail.com
Subject: [PATCH] Make git blame date output format configurable, a la git log (take 2)
Date: Fri, 20 Feb 2009 13:23:07 -0800
Message-ID: <1235164988-19761-1-git-send-email-eletuchy@gmail.com>
References: <[PATCH] Make git blame date output format configurable, a la git log>
Cc: git@vger.kernel.org, eletuchy@facebook.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Feb 20 22:29:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LacwH-0000m3-3m
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 22:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbZBTV2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 16:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753087AbZBTV2M
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 16:28:12 -0500
Received: from outmail008.ash1.tfbnw.net ([69.63.184.108]:34368 "EHLO
	mx-out.facebook.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752958AbZBTV2M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 16:28:12 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Feb 2009 16:28:12 EST
Received: from [10.18.255.176] ([10.18.255.176:48320] helo=facebook.com)
	by mta002.ash1.facebook.com (envelope-from <eletuchy@facebook.com>)
	(ecelerity 2.2.2.37 r(28805/28844)) with ESMTP
	id D6/62-32672-D3F1F994; Fri, 20 Feb 2009 13:23:09 -0800
Received: by dev051.snc1.facebook.com (Postfix, from userid 1200)
	id F306A11C211; Fri, 20 Feb 2009 13:23:08 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.14.g07c3.dirty
In-Reply-To: <[PATCH] Make git blame date output format configurable, a la git log>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110892>


This version of the patch incorporates Junio's and Peff's suggestions ... doesn't change the default format and gets rid of alignment bugs.
