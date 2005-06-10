From: Sebastian Kuzminsky <seb@highlab.com>
Subject: cg-pull fails on ssh repos
Date: Fri, 10 Jun 2005 16:15:25 -0600
Message-ID: <E1Dgrmf-0003x5-Ik@highlab.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 00:12:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dgrgk-0002Sl-Rw
	for gcvg-git@gmane.org; Sat, 11 Jun 2005 00:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVFJWN1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Jun 2005 18:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVFJWN1
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jun 2005 18:13:27 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:10227 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261266AbVFJWN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2005 18:13:26 -0400
Received: from highlab.com ([24.8.179.27])
          by comcast.net (sccrmhc14) with ESMTP
          id <2005061022132601400crjeae>; Fri, 10 Jun 2005 22:13:26 +0000
Received: from seb (helo=highlab.com)
	by highlab.com with local-esmtp (Exim 4.50)
	id 1Dgrmf-0003x5-Ik
	for git@vger.kernel.org; Fri, 10 Jun 2005 16:15:25 -0600
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

cg-pull's pull_ssh() calls git-rpull, should that be git-ssh-pull?


-- 
Sebastian Kuzminsky
