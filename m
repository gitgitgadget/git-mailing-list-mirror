From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH 0/1] Diff-helper update
Date: Wed, 18 May 2005 20:52:31 +0200
Message-ID: <20050518185231.GF4738@cip.informatik.uni-erlangen.de>
References: <7v3bslqc94.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505180821470.18337@ppc970.osdl.org> <7v64xgpgb0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505181110480.18337@ppc970.osdl.org> <Pine.LNX.4.58.0505181134470.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed May 18 20:53:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYTeE-0004Mv-Dd
	for gcvg-git@gmane.org; Wed, 18 May 2005 20:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVERSwh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 14:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVERSwh
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 14:52:37 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:10195 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262215AbVERSwc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 14:52:32 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4IIqVS8028596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Wed, 18 May 2005 18:52:31 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4IIqVSt028595
	for git@vger.kernel.org; Wed, 18 May 2005 20:52:31 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505181134470.18337@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> 	git-rev-list HEAD | git-diff-tree -r -v --stdin | ./git-diff-helper -r | less -S

nice one!

	Thomas
