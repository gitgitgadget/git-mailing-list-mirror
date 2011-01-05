From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git repo corruption
Date: Wed, 05 Jan 2011 20:49:43 +0100
Organization: At home
Message-ID: <ig2i0m$uv9$1@dough.gmane.org>
References: <AANLkTi=TSy1WQZARNQgGfPiV93hQ-xmCTip75JAixgDB@mail.gmail.com> <4D24B969.50007@gmail.com> <AANLkTikxW-kEhCFKBb-rGPM2xZtk7WyomYnFwz_DYV43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 05 20:50:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaZN7-0003Ap-9P
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 20:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab1AETuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 14:50:05 -0500
Received: from lo.gmane.org ([80.91.229.12]:56361 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752163Ab1AETuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 14:50:04 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PaZMq-0002yn-Ki
	for git@vger.kernel.org; Wed, 05 Jan 2011 20:49:56 +0100
Received: from abwm104.neoplus.adsl.tpnet.pl ([83.8.236.104])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 20:49:56 +0100
Received: from jnareb by abwm104.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 20:49:56 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: abwm104.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164587>

Levend Sayar wrote:

> git ls-files -m | xargs git checkout --

Why not simply "git checkout -- ." or "git checkout HEAD -- ."?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
