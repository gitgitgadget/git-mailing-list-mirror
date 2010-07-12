From: "J.H." <warthog9@kernel.org>
Subject: Re: Git Wiki is down
Date: Sun, 11 Jul 2010 20:43:46 -0700
Message-ID: <4C3A8F72.50904@kernel.org>
References: <201007120038.47625.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 05:44:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OY9w8-0006Xj-61
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 05:44:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab0GLDn7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jul 2010 23:43:59 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:58374 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755611Ab0GLDn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jul 2010 23:43:58 -0400
Received: from voot-cruiser.eaglescrag.net (76-10-145-13.dsl.ncf.ca [76.10.145.13] (may be forged))
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id o6C3hkJ7002087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sun, 11 Jul 2010 20:43:53 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Lightning/1.0b2pre Thunderbird/3.0.4
In-Reply-To: <201007120038.47625.jnareb@gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Sun, 11 Jul 2010 20:43:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150790>

*SIGH*

I unplug for a weekend, go and spend a nice couple of days hanging out
on a remote lake, and the mediawiki maintainer within Fedora upgrades
the package and suddenly /etc/httpd/conf.d/mediawiki.conf is no longer a
config file so it gets squashed, overwritten without backup (I.E. no
.rpmsave files)

I'm pulling the backup of the file now, so the git wiki (along with all
the other wikis) should be back online shortly.

- John 'Warthog9' Hawley

On 07/11/2010 03:38 PM, Jakub Narebski wrote:
> What happened to Git Wiki?  Every link leads to 404 Not Found error,
> and http://git.wiki.kernel.org leads to test page for Apache web server.
> 
> I hope that Git Wiki is backed up, and this is only some temporary 
> glitch related e.g. to upgrading.
>  
