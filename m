From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Access Denied when pushing git
Date: Tue, 26 May 2009 20:14:23 -0700
Message-ID: <robbat2-20090527T031233-374899931Z@orbis-terrarum.net>
References: <1243388447198-2978561.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 27 05:14:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M99bF-0005KL-Dl
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 05:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbZE0DOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 23:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755362AbZE0DOd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 23:14:33 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:45228 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754690AbZE0DOc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 23:14:32 -0400
Received: (qmail 5422 invoked from network); 27 May 2009 03:14:28 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 27 May 2009 03:14:28 +0000
Received: (qmail 12271 invoked by uid 10000); 26 May 2009 20:14:23 -0700
Content-Disposition: inline
In-Reply-To: <1243388447198-2978561.post@n2.nabble.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120020>

On Tue, May 26, 2009 at 06:40:47PM -0700, Aaron180 wrote:
> I've been trying to figure this out for two days now, any help would be
> appreciated
1. I wouldn't rely on the '~' being expanded, try with a full path.
2. If there is a banner or some output from your bashrc, I've seen those
   cause problems.

-- 
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
