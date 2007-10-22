From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 22 Oct 2007 20:36:39 +0700
Message-ID: <fcaeb9bf0710220636k40c14c40mdd8d7d0b77cf48fa@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <1192827476.4522.93.camel@cacharro.xalalinux.org>
	 <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
	 <Pine.LNX.4.64.0710210031130.25221@racer.site>
	 <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site>
	 <471C586A.9030900@op5.se>
	 <Pine.LNX.4.64.0710221156540.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Andreas Ericsson" <ae@op5.se>,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Federico Mena Quintero" <federico@novell.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 15:36:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjxSe-00018D-LN
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 15:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbXJVNgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 09:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbXJVNgm
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 09:36:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:24601 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbXJVNgl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 09:36:41 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1007562nfb
        for <git@vger.kernel.org>; Mon, 22 Oct 2007 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=v9f2YYdCcQ4ckVYAw5Fc79G0OAeUawIpSH9HqEbjsJE=;
        b=tBZqRCIKZYwOQHjq47Yw751ufRlZUbNaycNBW/H8/zRBiUkG9AY0AmF+uVaNvSmTE1mxNg3EyDWH2dYbPBmzgT3o1Sn3pgONekb4CfPbjSgeyi7nhONU8fePTGRhKex24a4nFSgC6TkvJMjeyfECxRabd7OOhAwnRQtewXptutk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gBGP5rUpzhm1fJFU7a8s4sFsYowoEJ7FXWnIwdG95q6+WjTDno5og2Ext4ZpStZiezFGBepIEJo7mKvV8yq/Hboc3qKgux/BcNSDlG9FOoex+1i/YNlnGIcfpktHfrQD/vp/sQAnDyTPTIVqaAIfzj9VHCTfO1CtsxbN4tV0wbc=
Received: by 10.86.71.1 with SMTP id t1mr3816458fga.1193060199423;
        Mon, 22 Oct 2007 06:36:39 -0700 (PDT)
Received: by 10.86.83.3 with HTTP; Mon, 22 Oct 2007 06:36:39 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0710221156540.25221@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62002>

On 10/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> So once again, what operations involving git do people use regularly?

All operations in my laptop since May:

    621 git log
    614 git diff
    510 git status
    378 git grep
    203 git checkout
    166 git add
    159 git commit
    106 git fetch
     87 git branch
     61 git help
     55 git am
     49 git ls-files
     48 git format-patch
     46 git show
     46 git reset
     46 git clone
     44 git cherry-pick
     42 git merge
     36 git apply
     26 git cherry
     25 git push
     25 git describe
     24 git rev-list
     20 git rebase
     18 git pull
     17 gitview
     16 git shortlog
     15 git revert
     15 git cat-file
     12 git name-rev
     11 git update-index
     11 git ls-tree
     11 git count-objects
     10 git tag
      9 git send-email
      9 git rev-parse
      7 git svn
      7 git read-tree
      6 git repack
      6 git fsck
      4 git init
      4 git clean
      3 git rm
      3 git gc
      2 git submodule
      2 git prune
      2 git ls
      2 gitk
      2 git gui
      2 git config
      1 git mailinfo
      1 git lost-found
-- 
Duy
