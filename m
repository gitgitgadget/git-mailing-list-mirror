From: Alberto Bertogli <albertito@blitiri.com.ar>
Subject: [ANNOUNCE] git-arr 0.14
Date: Tue, 20 Jan 2015 11:55:19 +0000
Message-ID: <20150120115519.GA2428@blitiri.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 13:38:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDY4P-0004AQ-4U
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 13:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbbATMiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 07:38:00 -0500
Received: from alerce.vps.bitfolk.com ([85.119.82.134]:59671 "EHLO
	alerce.vps.bitfolk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbbATMh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2015 07:37:59 -0500
X-Greylist: delayed 2474 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Jan 2015 07:37:59 EST
Received: from 87-198-57-52.ptr.magnet.ie ([87.198.57.52] helo=blitiri.com.ar)
	by alerce.vps.bitfolk.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.82)
	(envelope-from <albertito@blitiri.com.ar>)
	id 1YDXQK-0000Pm-OH
	for git@vger.kernel.org; Tue, 20 Jan 2015 08:56:44 -0300
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262651>


Hi!

git-arr is a git repository browser that can generate static HTML
instead of having to run dynamically.

I've just released version 0.14, which includes minor fixes and
performance improvements, as well as the following features:

 - Improved max_pages handling, including saner defaults.
 - Show a creation event for the root commit (optionally).
 - Support for hierarchical branch names.
 - Render hexdump(1)-style binary blob content.

You can find it at http://blitiri.com.ar/p/git-arr.


Thanks specially to Eric Sunshine who wrote almost all the changes in
this release, including all the features mentioned above, as well as
many code cleanups.

Cheers!
		Alberto
