From: Chris Wright <chrisw@osdl.org>
Subject: Re: git-core and cogito now in Fedora Extras
Date: Mon, 19 Sep 2005 15:52:43 -0700
Message-ID: <20050919225243.GZ7762@shell0.pdx.osdl.net>
References: <20050918173725.GS7762@shell0.pdx.osdl.net> <432F0FEE.6090107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Wright <chrisw@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 00:54:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHUVD-0006dQ-FR
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 00:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbVISWwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 18:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932675AbVISWwp
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 18:52:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8618 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932662AbVISWwo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 18:52:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8JMqhBo014526
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Sep 2005 15:52:43 -0700
Received: from shell0.pdx.osdl.net (localhost [127.0.0.1])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8JMqhcL021347;
	Mon, 19 Sep 2005 15:52:43 -0700
Received: (from chrisw@localhost)
	by shell0.pdx.osdl.net (8.13.1/8.13.1/Submit) id j8JMqhhn021346;
	Mon, 19 Sep 2005 15:52:43 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <432F0FEE.6090107@zytor.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.116 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8918>

* H. Peter Anvin (hpa@zytor.com) wrote:
> Chris Wright wrote:
> >If you're a Fedora user, you should now find git-core and cogito packages
> >in extras/.  Should be available in FC-3, FC-4, and current devel.
> 
> How long do you expect the lag to be between a new version being 
> released and it showing up in FE?

I expect to keep FE reasonably up-to-date with current releases.  Lag in
terms of days not weeks.  Pushing an update out seems to take about 1 day
(individual mirror may lag behind that).  Plus any lag from fixing any
rpm specific issues and me noticing the new release.

thanks,
-chris
