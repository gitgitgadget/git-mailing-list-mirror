From: Greg KH <greg@kroah.com>
Subject: Re: Problems with using git
Date: Thu, 2 Mar 2006 15:21:51 -0800
Message-ID: <20060302232151.GA12252@kroah.com>
References: <44063B7C.40609@webdrake.net> <Pine.LNX.4.64.0603011651240.22647@g5.osdl.org> <4406F8B1.9050303@webdrake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 00:34:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FExJc-0000K8-ET
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 00:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbWCBXed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 18:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752091AbWCBXed
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 18:34:33 -0500
Received: from mail.kroah.org ([69.55.234.183]:37286 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1752088AbWCBXed (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 18:34:33 -0500
Received: from [192.168.0.10] (dsl093-040-174.pdx1.dsl.speakeasy.net [66.93.40.174])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id k22NYRK24524;
	Thu, 2 Mar 2006 15:34:27 -0800
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1FEx7H-3Cd-00; Thu, 02 Mar 2006 15:21:51 -0800
To: Joseph Wakeling <joseph.wakeling@webdrake.net>
Content-Disposition: inline
In-Reply-To: <4406F8B1.9050303@webdrake.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17121>

On Thu, Mar 02, 2006 at 01:52:49PM +0000, Joseph Wakeling wrote:
> Thanks very much to all who offered advice on this. :-)
> 
> Unfortunately openSUSE is somewhat out of sync not just with git but in
> libraries necessary to install the latest version (libcrypto.so.4,
> libssl.so.4).  The openssl (0.9.7g-2.4) and openssl-devel (0.9.7g-2)
> packages don't contain these but rather contain libcrypto.so.0.9.7 and
> libssl.0.9.7.  Just in case it's important to future git development.

If you use the latest openSUSE betas or the FACTORY tree, git 1.1.3 is
available there.

10.0 was released six months or so ago, so that is why it contains an
older version of git.

thanks,

greg k-h
