From: Alberto Bertogli <albertito@blitiri.com.ar>
Subject: [ANN] git-arr 0.12
Date: Sun, 3 Nov 2013 21:42:02 +0000
Message-ID: <20131103214202.GI6411@blitiri.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 03 23:03:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd5lt-0005TB-VK
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 23:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727Ab3KCWDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 17:03:46 -0500
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:41780 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181Ab3KCWDp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Nov 2013 17:03:45 -0500
X-Greylist: delayed 1292 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Nov 2013 17:03:45 EST
Received: from 87-198-57-52.ptr.magnet.ie ([87.198.57.52] helo=blitiri.com.ar)
	by alerce.vps.bitfolk.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.76)
	(envelope-from <albertito@blitiri.com.ar>)
	id 1Vd5Qy-0003Fv-2R
	for git@vger.kernel.org; Sun, 03 Nov 2013 18:42:12 -0300
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237279>


Hi!

git-arr is a git repository browser that can generate static HTML
instead of having to run dynamically.

I've just released version 0.12, which includes minor bug fixes and the
following new features:

 - Support for embedded markdown and image files in the blob view
   (thanks to Vanya Sergeev).
 - Show the age of a repository in the index.

You can find it at http://blitiri.com.ar/p/git-arr.

Thanks!
		Alberto
