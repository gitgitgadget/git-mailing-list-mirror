From: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>
Subject: Whitespace on commit
Date: Thu, 13 Mar 2008 03:38:26 +0000 (UTC)
Message-ID: <fra7ji$7p9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 04:39:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZeHs-0008Sk-44
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 04:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbYCMDip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 23:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbYCMDio
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 23:38:44 -0400
Received: from main.gmane.org ([80.91.229.2]:60304 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584AbYCMDio (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 23:38:44 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JZeH7-0007Cx-OZ
	for git@vger.kernel.org; Thu, 13 Mar 2008 03:38:37 +0000
Received: from pool-71-161-49-227.clppva.east.verizon.net ([71.161.49.227])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 03:38:37 +0000
Received: from kt-usenet by pool-71-161-49-227.clppva.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 03:38:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-161-49-227.clppva.east.verizon.net
User-Agent: pan 0.120 (Plate of Shrimp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77031>

I keep getting annoying errors when I try to commit.  Git complains that I
have whitespace in the wrong places.  

This is fine.. I even like it.  What I don't like is having to change this
stuff manually.  Is there anyway to tell git to just fix the stuff and do
the commit?  

I've tried setting

apply.whitespace = fix 

in my .gitconfig, but that doesn't seem to help when doing commits.  Is
there another way to handle this? 

Thanks!

-- 
Kenneth P. Turvey <kt-usenet@squeakydolphin.com>
