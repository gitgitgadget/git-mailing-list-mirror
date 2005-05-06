From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: tool to diff cache <-> working directory
Date: Fri, 6 May 2005 02:23:47 +0200
Message-ID: <20050506002347.GU20994@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 06 02:18:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTqWz-0001q0-4u
	for gcvg-git@gmane.org; Fri, 06 May 2005 02:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVEFAXx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 20:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVEFAXx
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 20:23:53 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:16592 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262099AbVEFAXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 20:23:49 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j460NmS8011486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 6 May 2005 00:23:48 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j460NmjR011485
	for git@vger.kernel.org; Fri, 6 May 2005 02:23:48 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
is there a tool to compare cache with working directory similiar to
diff-tree, diff-cache and diff-files? Or is there a way to find out the
SHA checksum of a file in a working directory without adding it to a
temporary cache?

	Thomas
