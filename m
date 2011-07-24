From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git-show / tig: no indention for commit message
Date: Sun, 24 Jul 2011 09:36:47 +0200
Message-ID: <m2pql0m8og.fsf@linux-m68k.org>
References: <20110511113655.GB24644@nibiru.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 09:36:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QktFB-00017w-6p
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 09:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519Ab1GXHgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 03:36:52 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:46079 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab1GXHgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 03:36:51 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 4E76B188B5BB
	for <git@vger.kernel.org>; Sun, 24 Jul 2011 09:36:49 +0200 (CEST)
X-Auth-Info: 6Pg1VdF0c3vNKVKFdVaJnyeSIDC6aY4JcnKZPUTYibw=
Received: from linux.local (ppp-88-217-105-242.dynamic.mnet-online.de [88.217.105.242])
	by mail.mnet-online.de (Postfix) with ESMTPA id 1B32B1C000A2
	for <git@vger.kernel.org>; Sun, 24 Jul 2011 09:36:49 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 2DE131E52E5; Sun, 24 Jul 2011 09:36:47 +0200 (CEST)
X-Yow: I have a very good DENTAL PLAN.  Thank you.
In-Reply-To: <20110511113655.GB24644@nibiru.local> (Enrico Weigelt's message
	of "Wed, 11 May 2011 13:36:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177727>

Enrico Weigelt <weigelt@metux.de> writes:

> I often have to copy+paste commit messages from tig (when putting
> changes into TFS manually ;-o), and the 4-spaces indention is quite
> unhandy here. Is there a way to switch it off ?

You could use git cat-file instead.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
