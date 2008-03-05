From: "Kenneth P. Turvey" <kt-usenet@squeakydolphin.com>
Subject: Re: git-svn and logging.. new to git
Date: Wed, 5 Mar 2008 16:03:44 +0000 (UTC)
Message-ID: <fqmg8v$rmm$1@ger.gmane.org>
References: <fqloop$ll$1@ger.gmane.org>
	<ee77f5c20803050401o7f33522dj6dd0f0f1c0a78f96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 17:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWw6g-00039O-J8
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 17:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127AbYCEQD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 11:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755897AbYCEQD5
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 11:03:57 -0500
Received: from main.gmane.org ([80.91.229.2]:51286 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781AbYCEQD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 11:03:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JWw5u-0006Eh-6c
	for git@vger.kernel.org; Wed, 05 Mar 2008 16:03:50 +0000
Received: from pool-71-161-44-24.clppva.east.verizon.net ([71.161.44.24])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 16:03:50 +0000
Received: from kt-usenet by pool-71-161-44-24.clppva.east.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 16:03:50 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pool-71-161-44-24.clppva.east.verizon.net
User-Agent: pan 0.120 (Plate of Shrimp)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76237>

On Wed, 05 Mar 2008 23:01:34 +1100, David Symonds wrote:


> git-svn creates a whole bunch of remote branches -- does "git branch
> -a" show them up?
> 
> Also, you can probably leave out the --trunk, etc., and just use
> --stdlayout.


Thanks.  That's good information to have.  Is there a way to just do a
straight import like in svnimport?  Is svnimport still available
somewhere or has it been completely superseded by git-svn? 

-- 
Kenneth P. Turvey <kt-usenet@squeakydolphin.com>

