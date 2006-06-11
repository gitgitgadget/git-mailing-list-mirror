From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make Documentation (somehwat more) consistent
Date: Sun, 11 Jun 2006 23:04:09 +0200
Organization: At home
Message-ID: <e6i0fl$ui0$1@sea.gmane.org>
References: <11500582682293-git-send-email-vonbrand@inf.utfsm.cl> <11500582752231-git-send-email-vonbrand@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Jun 11 23:04:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FpX6M-000625-Lg
	for gcvg-git@gmane.org; Sun, 11 Jun 2006 23:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWFKVED (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Jun 2006 17:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWFKVEB
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jun 2006 17:04:01 -0400
Received: from main.gmane.org ([80.91.229.2]:35011 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750787AbWFKVEB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jun 2006 17:04:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FpX6D-00060t-ER
	for git@vger.kernel.org; Sun, 11 Jun 2006 23:03:57 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Jun 2006 23:03:57 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Jun 2006 23:03:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21669>

Horst H. von Brand wrote:

> Fix the quoting of the command names, files, etc
> The commands should be used as 'git foo', not 'git-foo'
> Fix some messed up grammar and typing

Commands are used as 'git foo' from command line (user commands,
porcelanish), but in scripts usually used as 'git-foo', and you ask for
'man git-foo'.

-- 
Jakub Narebski
Warsaw, Poland
