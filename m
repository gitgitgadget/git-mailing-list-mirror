From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 7] autoconf: Add support for setting CURLDIR, OPENSSLDIR, EXPATDIR
Date: Thu, 10 Aug 2006 12:50:40 +0200
Organization: At home
Message-ID: <ebf31a$8qv$2@sea.gmane.org>
References: <200608081834.09271.jnareb@gmail.com> <200608090215.10917.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Aug 10 12:55:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GB8CM-0004cG-Rw
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 12:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161161AbWHJKzT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Aug 2006 06:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161163AbWHJKzS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 06:55:18 -0400
Received: from main.gmane.org ([80.91.229.2]:30633 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161161AbWHJKzQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Aug 2006 06:55:16 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GB8Br-0004Xn-44
	for git@vger.kernel.org; Thu, 10 Aug 2006 12:55:03 +0200
Received: from host-81-190-31-92.torun.mm.pl ([81.190.31.92])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 12:55:03 +0200
Received: from jnareb by host-81-190-31-92.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Aug 2006 12:55:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-31-92.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25181>

Jakub Narebski wrote:

> Add support for --with-openssl=PATH and --without-openssl,
> --with-curl=PATH and --without-curl, --with-expat=PATH and
> --without-expat ./configure options, each setting or unsetting
> appropriate NO_PACKAGE and if called with argument also PACKAGEDIR
> (of which only CURLDIR is documented in Makefile)
> 
> All above options are supported as override to autodetection; more to
> come in the same style (override to autodetection), so moved the bulk
> of comments for site configuration down.

Is this patch dropped?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
