From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
	summary continued
Date: Wed, 24 Oct 2007 00:13:59 +0200
Message-ID: <20071023221358.GB729@steel.home>
References: <Pine.LNX.4.64.0710221156540.25221@racer.site> <ED965042-27DE-450B-96CB-00D27000FAF6@wincent.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 00:14:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkS10-0007sV-Nk
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 00:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbXJWWOH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 18:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbXJWWOG
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 18:14:06 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:31532 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbXJWWOF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 18:14:05 -0400
Received: from tigra.home (Fa823.f.strato-dslnet.de [195.4.168.35])
	by post.webmailer.de (mrclete mo56) (RZmta 13.6)
	with ESMTP id 506102j9NMAC3X ; Wed, 24 Oct 2007 00:14:01 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3B944277AE;
	Wed, 24 Oct 2007 00:14:01 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E91C356D22; Wed, 24 Oct 2007 00:13:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ED965042-27DE-450B-96CB-00D27000FAF6@wincent.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggTYQtQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62165>

Wincent Colaiuta, Mon, Oct 22, 2007 15:17:19 +0200:
>
>> So once again, what operations involving git do people use regularly?
>
> Here are my top ten commands, sorted by the number of times they appear in 
> my ~/.bash_history:

from my (short, 500) .bash_history:

     26 am
     22 gitk
     21 fetch
     15 reset
     10 log
      9 merge
      8 cherry-pick
      7 status
      5 commit
      4 svn
      4 push
      4 gc
      4 diff
      3 gui
      3 format-patch
      2 pull
      2 clone
      1 show
      1 rebase
      1 grep
      1 cat-file
      1 branch
      1 apply

branch, cat-file and show are actually fairly common, the history just
shorted and I lost them.
