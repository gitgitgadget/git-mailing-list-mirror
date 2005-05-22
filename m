From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: Kernel nightly snapshots..
Date: Sun, 22 May 2005 14:09:54 +0200
Message-ID: <20050522120954.GH15178@cip.informatik.uni-erlangen.de>
References: <1115303933.16187.135.camel@hades.cambridge.redhat.com> <Pine.LNX.4.58.0505050742180.2328@ppc970.osdl.org> <1115305813.16187.143.camel@hades.cambridge.redhat.com> <1115307033.16187.146.camel@hades.cambridge.redhat.com> <427ABA45.3050803@zytor.com> <1115364543.29495.24.camel@localhost.localdomain> <427BE699.60802@zytor.com> <20050506215142.GA15357@logos.cnet> <20050522115038.GC15178@cip.informatik.uni-erlangen.de> <1116763160.19183.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 22 14:09:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZpG6-0006Dw-Nw
	for gcvg-git@gmane.org; Sun, 22 May 2005 14:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVEVMJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 08:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbVEVMJ5
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 08:09:57 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:663 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261792AbVEVMJz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 08:09:55 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4MC9sS8028606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Sun, 22 May 2005 12:09:54 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4MC9sDV028605
	for git@vger.kernel.org; Sun, 22 May 2005 14:09:54 +0200 (CEST)
To: Git Mailing List <git@vger.kernel.org>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1116763160.19183.15.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> That should be done against the 2.6 kernel, and that tree is already
> available.

it is a shame that 2.6 doesn't even boot on this machine[1]. And even if
the patch doesn't do its way upstream its good to have something like
git available to to vendortracking.

	Thomas

[1] http://bugzilla.kernel.org/show_bug.cgi?id=4415
