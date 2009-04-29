From: Jason Brice <jason@sbh.co.nz>
Subject: Project Setup Problem
Date: Wed, 29 Apr 2009 00:22:56 +0000 (UTC)
Message-ID: <loom.20090429T001456-24@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 02:30:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyxh9-00032a-As
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 02:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755347AbZD2AaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 20:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbZD2AaI
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 20:30:08 -0400
Received: from main.gmane.org ([80.91.229.2]:51570 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754677AbZD2AaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 20:30:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LyxgZ-00080a-A2
	for git@vger.kernel.org; Wed, 29 Apr 2009 00:30:05 +0000
Received: from 121.90.202.59 ([121.90.202.59])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 00:30:03 +0000
Received: from jason by 121.90.202.59 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 00:30:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 121.90.202.59 (Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117839>

Hi,

I am very new to git and I am trying to create my first project. After running:
"git init", I ran "git add ." but I get the following error message:
fatal: pathspec '' did not match any files

I am running on CentOS 4.7 on a CPanel/WHM server. The git install is in a 
user's account space.

Thanks,
Jason
