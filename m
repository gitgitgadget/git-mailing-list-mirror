From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: User authentication in GIT
Date: Tue, 7 Feb 2012 07:30:07 +0000
Message-ID: <robbat2-20120207T072254-822967708Z@orbis-terrarum.net>
References: <1328595129258-7261349.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 07 08:30:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RufVe-00026A-LQ
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 08:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab2BGHaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 02:30:12 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:42197 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964Ab2BGHaL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 02:30:11 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 35C9B1B402D
	for <git@vger.kernel.org>; Tue,  7 Feb 2012 07:30:07 +0000 (UTC)
Received: (qmail 31982 invoked by uid 10000); 7 Feb 2012 07:30:07 -0000
Content-Disposition: inline
In-Reply-To: <1328595129258-7261349.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190149>

On Mon, Feb 06, 2012 at 10:12:09PM -0800,  supadhyay wrote:
> Hi All,
[snip]

1. Go and use gitolite.
2. All users must have their own SSH key. You do not create keys for them.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
