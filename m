From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: git-diff-tree for the first commit
Date: Thu, 19 May 2005 21:51:10 +0200
Message-ID: <20050519195110.GG8105@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 19 21:51:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYr2K-0001mr-Jd
	for gcvg-git@gmane.org; Thu, 19 May 2005 21:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVESTvP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 15:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbVESTvP
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 15:51:15 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:48541 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261237AbVESTvM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 15:51:12 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4JJpAS8026955
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 19 May 2005 19:51:10 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4JJpA4U026954
	for git@vger.kernel.org; Thu, 19 May 2005 21:51:10 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
I would like to see output for the first commit (initial import) in:

	git-rev-list HEAD | git-diff-tree -r --stdin

is it supposed to just be empty or is that a bug?

	Thomas
