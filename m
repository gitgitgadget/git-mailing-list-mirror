From: Eric Raible <raible@gmail.com>
Subject: Re: [ANNOUNCE] Git-1.6.0.2-preview20080923
Date: Tue, 23 Sep 2008 17:51:09 +0000 (UTC)
Message-ID: <loom.20080923T174850-898@post.gmane.org>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de> <691F01A6-CA78-46DA-8388-C8339A3F0F04@zib.de> <B463062F-DD48-44A7-B2BB-8E5E0D177616@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 23 19:52:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiC3q-00027v-35
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 19:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbYIWRvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 13:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbYIWRvU
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 13:51:20 -0400
Received: from main.gmane.org ([80.91.229.2]:56914 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940AbYIWRvT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 13:51:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KiC2f-0000nR-4W
	for git@vger.kernel.org; Tue, 23 Sep 2008 17:51:17 +0000
Received: from 12.96.234.114 ([12.96.234.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 17:51:17 +0000
Received: from raible by 12.96.234.114 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Sep 2008 17:51:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 12.96.234.114 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.30 Safari/525.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96580>

Steffen Prohaska <prohaska <at> zib.de> writes:

> 
> On Sep 21, 2008, at 7:33 PM, Steffen Prohaska wrote:
> 
> > Git-1.6.0.2-preview20080921 for Windows is available at
> >
> >   http://code.google.com/p/msysgit/downloads
> 
> I updated the installer to Git-1.6.0.2-preview20080923.
> The problems reported on the mailing list during the
> last two days should be fixed.
> 
> I apologize for the quality of Git-1.6.0.2-preview20080921.
> It was unacceptable.
> 
> 	Steffen

Your apology is not accepted - it is us who owe thanks.
Anyway, is this expected:

/c/Documents and Settings/eric  % git --version
git version 1.6.0.2.1325.gc3e64
/c/Documents and Settings/eric  % git commit --help
warning: failed to exec 'man': No such file or directory
fatal: no man viewer handled the request
/c/Documents and Settings/eric  % git commit --help --web
fatal: 'c:/Documents and Settings/eric/share/doc/git-doc': not a documentation 
directory.

- Eric
