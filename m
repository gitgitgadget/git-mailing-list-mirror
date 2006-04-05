From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add git-clean command
Date: Wed, 05 Apr 2006 08:25:52 +0200
Organization: At home
Message-ID: <e0vntc$slu$1@sea.gmane.org>
References: <20060405060048.6694.65940.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Apr 05 08:26:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR1TK-0001Wh-G8
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 08:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWDEG0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 02:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbWDEG0G
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 02:26:06 -0400
Received: from main.gmane.org ([80.91.229.2]:43654 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750910AbWDEG0F (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 02:26:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FR1Sq-0001RV-19
	for git@vger.kernel.org; Wed, 05 Apr 2006 08:26:00 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Apr 2006 08:26:00 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Apr 2006 08:26:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18416>

Pavel Roskin wrote:

> +SYNOPSIS
> +--------
> +[verse]
> +'git-clean' [-d | -D] [-n] [-q] [-x]

Shouldn't it be
> +'git-clean' [-d] [-n] [-q] [-x | -X]
like in below?

> +USAGE="[-d] [-n] [-q] [-x | -X]"

-- 
Jakub Narebski
Warsaw, Poland
