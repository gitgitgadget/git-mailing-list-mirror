From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: git-rev-tree ---stdin -s -p broken
Date: Wed, 25 May 2005 14:17:38 +0200
Message-ID: <20050525121738.GC24325@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 25 14:18:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dauov-0000i9-Ts
	for gcvg-git@gmane.org; Wed, 25 May 2005 14:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVEYMSE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 08:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVEYMSE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 08:18:04 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:15314 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262310AbVEYMRo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2005 08:17:44 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4PCHdS8009547
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 25 May 2005 12:17:39 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4PCHcQo009546
	for git@vger.kernel.org; Wed, 25 May 2005 14:17:38 +0200 (CEST)
To: GIT <git@vger.kernel.org>
Mail-Followup-To: GIT <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,
this doesn't produce any output for me:

(faui01) [~/work/git/yagf] git-rev-list HEAD | git-diff-tree --stdin -v -s
(faui01) [~/work/git/yagf]

	Thomas
