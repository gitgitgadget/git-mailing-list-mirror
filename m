From: Alberto Bertogli <albertito@blitiri.com.ar>
Subject: [ANN] git-arr 0.11
Date: Wed, 13 Mar 2013 23:41:43 +0000
Message-ID: <20130313234143.GD14686@blitiri.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 14 01:08:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFviZ-0004n1-N8
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 01:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933401Ab3CNAH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 20:07:57 -0400
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:48954 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932588Ab3CNAH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 20:07:57 -0400
X-Greylist: delayed 1520 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Mar 2013 20:07:57 EDT
Received: from 85-91-26-102.ptr.magnet.ie ([85.91.26.102] helo=blitiri.com.ar)
	by alerce.vps.bitfolk.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.76)
	(envelope-from <albertito@blitiri.com.ar>)
	id 1UFvJc-0001yK-5I
	for git@vger.kernel.org; Wed, 13 Mar 2013 20:42:36 -0300
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218106>


Hi!

I wanted to let you know about git-arr, which is a git repository
browser that can generate static HTML instead of having to run
dynamically.

It is smaller, with less features and a different set of tradeoffs than
gitweb or cgit, but if you have a reduced environment, the static
generation can be useful.

You can find more details on http://blitiri.com.ar/p/git-arr/, and see
an example of the generated output at http://blitiri.com.ar/git/.


It's written in Python, uses the Bottle web framework, and is open
source under the MIT licence.

Please note it's new and there are still some rough edges that I
obviously intend to fix, but it's been working fine for my use cases, so
all feedback is welcome :)

Thanks a lot!
		Alberto
