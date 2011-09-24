From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [ANNOUNCE] Git 1.7.6.4
Date: Sat, 24 Sep 2011 10:35:04 +0000
Message-ID: <robbat2-20110924T103319-176337633Z@orbis-terrarum.net>
References: <7vlitesucu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 12:35:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7PZw-00088Q-HD
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 12:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045Ab1IXKfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 06:35:06 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:59225 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab1IXKfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 06:35:05 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id A701F1B40F1
	for <git@vger.kernel.org>; Sat, 24 Sep 2011 10:35:04 +0000 (UTC)
Received: (qmail 1868 invoked by uid 10000); 24 Sep 2011 10:35:04 -0000
Content-Disposition: inline
In-Reply-To: <7vlitesucu.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182025>

On Fri, Sep 23, 2011 at 04:37:53PM -0700,  Junio C Hamano wrote:
> The latest maintenance release Git 1.7.6.4 is available but not at the
> usual places.
> 
> The release tarballs are found at:
> 
>     http://code.google.com/p/git-core/downloads/list
> 
> and their SHA-1 checksums are:
> 
> df91e2c32d6097ab1c9d0edc56dd8cecb4e9b686  git-1.7.6.4.tar.gz
> 6abd985e24b6585284cef7fae2e3046ba9201356  git-htmldocs-1.7.6.4.tar.gz
> c6f6d92f4005a7eccaf89e851c45768c18f7e65a  git-manpages-1.7.6.4.tar.gz
Can you please upload the manpages and htmldocs tarballs to
code.google.com downloads? We use them in packaging on Gentoo for users
that want the docs without all of the documentation build chain.

(For 1.7.7.rc* too please).

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85
