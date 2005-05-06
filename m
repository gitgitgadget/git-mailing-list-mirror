From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Locking the repository
Date: Fri, 6 May 2005 14:31:22 +0200
Message-ID: <20050506123122.GF11506@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 06 14:25:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DU1t6-0005dm-Ui
	for gcvg-git@gmane.org; Fri, 06 May 2005 14:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVEFMbe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 May 2005 08:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVEFMbd
	(ORCPT <rfc822;git-outgoing>); Fri, 6 May 2005 08:31:33 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:31713 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261203AbVEFMb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2005 08:31:27 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j46CVMS8004218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 6 May 2005 12:31:22 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j46CVMbH004217
	for git@vger.kernel.org; Fri, 6 May 2005 14:31:22 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
I need a way to lock a repository for certain actions. What can I use to
obtain this? Is there a way to use rsync for that? It should also be
NFS-safe. Are there are any classic unix tools that I can use for this?

	Thomas
