From: Arafangion <thestar@fussycoder.id.au>
Subject: Re: inted problems when upgrading to 1.6.0.4
Date: Tue, 25 Nov 2008 22:14:34 +1100
Message-ID: <1227611674.3222.7.camel@therock.nsw.bigpond.net.au>
References: <492BC56A.6040506@xmos.com>
	 <1227608420.3222.2.camel@therock.nsw.bigpond.net.au>
	 <492BCFA0.5030708@xmos.com>
	 <1227610459.3222.4.camel@therock.nsw.bigpond.net.au>
	 <492BD951.1010200@xmos.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luis Gutierrez <luis.gutierrez@xmos.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 12:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4vjw-0001ND-MV
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 12:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbYKYLDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 06:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbYKYLDv
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 06:03:51 -0500
Received: from nschwmtas06p.mx.bigpond.com ([61.9.189.152]:42646 "EHLO
	nschwmtas06p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750793AbYKYLDu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2008 06:03:50 -0500
Received: from nschwotgx01p.mx.bigpond.com ([58.173.132.215])
          by nschwmtas06p.mx.bigpond.com with ESMTP
          id <20081125110348.LZKU1799.nschwmtas06p.mx.bigpond.com@nschwotgx01p.mx.bigpond.com>;
          Tue, 25 Nov 2008 11:03:48 +0000
Received: from therock.local ([58.173.132.215])
          by nschwotgx01p.mx.bigpond.com with ESMTP
          id <20081125110347.EPUJ1935.nschwotgx01p.mx.bigpond.com@therock.local>;
          Tue, 25 Nov 2008 11:03:47 +0000
In-Reply-To: <492BD951.1010200@xmos.com>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150203.492BDB94.0061,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101660>

On Tue, 2008-11-25 at 10:54 +0000, Luis Gutierrez wrote:
<snip>
> This is what I have now:
> ls /usr/local/bin/git*
> git  git-cvsserver  gitk  git-receive-pack  git-shell  
> git-upload-archive  git-upload-pack
> it seems.. a lot less than it used to be, but then again, perhaps this 
> is why the git-* commands were deprecated?

As Johannes Sixt mentioned, they have been moved from the bindir to the
new gitexecdir.
