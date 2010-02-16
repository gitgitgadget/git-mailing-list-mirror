From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: make test fails with git 1.7.0 on my debian
Date: Tue, 16 Feb 2010 16:23:28 +0000
Message-ID: <robbat2-20100216T162259-829076679Z@orbis-terrarum.net>
References: <7fce93be1002160818p1095b251s281dcd0b644ca519@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 16 17:23:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhQD7-0006Xy-NR
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 17:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833Ab0BPQXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 11:23:35 -0500
Received: from b01.ext.isohunt.com ([208.71.112.51]:39541 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932254Ab0BPQXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 11:23:34 -0500
Received: (qmail 19689 invoked from network); 16 Feb 2010 16:23:29 -0000
Received: from tsi-static.orbis-terrarum.net (HELO grubbs.orbis-terrarum.net) (76.10.188.108)
    by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (CAMELLIA256-SHA encrypted) ESMTPS; Tue, 16 Feb 2010 16:23:29 +0000
Received: (qmail 29321 invoked by uid 10000); 16 Feb 2010 16:23:28 -0000
Content-Disposition: inline
In-Reply-To: <7fce93be1002160818p1095b251s281dcd0b644ca519@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140130>

On Tue, Feb 16, 2010 at 05:18:07PM +0100, Sylvain Rabot wrote:
> root@numerobis:~/src/git-1.7.0# uname -a
> Linux numerobis 2.6.26-2-686 #1 SMP Wed Nov 4 20:45:37 UTC 2009 i686 GNU/Linux
> root@numerobis:~/src/git-1.7.0# make test
Don't run the tests as root.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
