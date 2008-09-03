From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] diffcol.sh: Use /bin/bash explicitly
Date: Wed, 3 Sep 2008 18:21:23 +0200
Message-ID: <20080903162123.GA874@diana.vm.bytemark.co.uk>
References: <48BEB185.2080505@ruby.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>
X-From: git-owner@vger.kernel.org Wed Sep 03 18:01:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kaumb-0003aV-JV
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 18:00:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYICP70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 11:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbYICP7Z
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 11:59:25 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1034 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753247AbYICP7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 11:59:24 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Kav6i-0000LD-00; Wed, 03 Sep 2008 17:21:24 +0100
Content-Disposition: inline
In-Reply-To: <48BEB185.2080505@ruby.dti.ne.jp>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2008-09-04 00:47:17 +0900, Shinya Kuribayashi wrote:

> diffcol.sh is based on Quilt, and Quilt is dependent on bash;
> Actually all Quilt scripts use /bin/bash without exceptions. Then
> it's good for diffcol.sh to use /bin/bash.

Thanks for this, and the other patch you sent. I'll be picking them up
this weekend, unless Catalin beats me to it.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
