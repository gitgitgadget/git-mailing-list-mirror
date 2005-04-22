From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: Re: ia64 git pull
Date: Thu, 21 Apr 2005 19:06:28 -0700
Message-ID: <17000.23588.462823.574142@sodium.jf.intel.com>
References: <200504212042.j3LKgng04318@unix-os.sc.intel.com>
	<Pine.LNX.4.58.0504211403080.2344@ppc970.osdl.org>
	<200504212155.j3LLtho04949@unix-os.sc.intel.com>
	<200504212301.j3LN1Do05507@unix-os.sc.intel.com>
	<20050422012546.GD1474@pasky.ji.cz>
	<17000.22515.170455.192374@sodium.jf.intel.com>
	<20050422015340.GD7443@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: tony.luck@intel.com, Linus Torvalds <torvalds@osdl.org>,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
X-From: linux-ia64-owner@vger.kernel.org Fri Apr 22 04:02:22 2005
Return-path: <linux-ia64-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOnUk-0002uM-Oz
	for glpi-linux-ia64-2@gmane.org; Fri, 22 Apr 2005 04:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVDVCGn (ORCPT <rfc822;glpi-linux-ia64-2@m.gmane.org>);
	Thu, 21 Apr 2005 22:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVDVCGm
	(ORCPT <rfc822;linux-ia64-outgoing>);
	Thu, 21 Apr 2005 22:06:42 -0400
Received: from fmr19.intel.com ([134.134.136.18]:27620 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261919AbVDVCGh (ORCPT <rfc822;linux-ia64@vger.kernel.org>);
	Thu, 21 Apr 2005 22:06:37 -0400
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr004.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3M26TWa008541;
	Fri, 22 Apr 2005 02:06:29 GMT
Received: from sodium.jf.intel.com (sodium.jf.intel.com [134.134.19.18])
	by orsfmr100.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3M26TtX015999;
	Fri, 22 Apr 2005 02:06:29 GMT
Received: from inaky by sodium.jf.intel.com with local (Exim 3.36 #1 (Debian))
	id 1DOnYq-00046W-00; Thu, 21 Apr 2005 19:06:28 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050422015340.GD7443@pasky.ji.cz>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Scanned-By: MIMEDefang 2.44
Sender: linux-ia64-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ia64@vger.kernel.org

>>>>> Petr Baudis <pasky@ucw.cz> writes:

> Remember that it's an URL (so you can't use '%'), and '#' is the
> canonical URL fragment identifier delimiter. (And fragments are
> perfect for this kind of thing, if you look at the RFC, BTW.)

Ouch, true--rule out %...

> Still, why would you escape it? My shell will not take # as a
> comment start if it is immediately after an alphanumeric character.

Well, you just taught me something about bash I didn't know....

/me goes back to his hole with some more knowledge.

Thanks,

-- 

Inaky

