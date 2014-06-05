From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: Git autocorrect bug
Date: Thu, 5 Jun 2014 06:10:12 +0000 (UTC)
Message-ID: <loom.20140605T080932-187@post.gmane.org>
References: <1401940145.18134.170.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 05 08:15:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsQxF-0004Nd-O7
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 08:15:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbaFEGPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 02:15:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:46553 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715AbaFEGPF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 02:15:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WsQx6-0004Gm-Ay
	for git@vger.kernel.org; Thu, 05 Jun 2014 08:15:04 +0200
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 08:15:04 +0200
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 08:15:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:29.0) Gecko/20100101 Firefox/29.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250818>

David Turner <dturner <at> twopensource.com> writes:

> 
> (I am extremely unlikely to fix this bug myself, since it only arises in
> very rare circumstances).
>

I see now that `git init foo` and `git git foo` (with git corrected
to init) behave differently. Is this the bug you're referring to? 
