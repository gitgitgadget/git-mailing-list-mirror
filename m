From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: Problems with using git
Date: Thu, 02 Mar 2006 13:52:49 +0000
Message-ID: <4406F8B1.9050303@webdrake.net>
References: <44063B7C.40609@webdrake.net> <Pine.LNX.4.64.0603011651240.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Mar 02 14:53:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEoEl-0004Az-SL
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 14:53:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWCBNw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 08:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWCBNw4
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 08:52:56 -0500
Received: from alf.nbi.dk ([130.225.212.55]:4612 "EHLO alf.nbi.dk")
	by vger.kernel.org with ESMTP id S1750782AbWCBNwz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 08:52:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by alf.nbi.dk (8.9.3/8.9.3) with ESMTP id OAA32356
	for <git@vger.kernel.org>; Thu, 2 Mar 2006 14:52:49 +0100 (MET)
User-Agent: Thunderbird 1.5 (X11/20060111)
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0603011651240.22647@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17070>

Thanks very much to all who offered advice on this. :-)

Unfortunately openSUSE is somewhat out of sync not just with git but in
libraries necessary to install the latest version (libcrypto.so.4,
libssl.so.4).  The openssl (0.9.7g-2.4) and openssl-devel (0.9.7g-2)
packages don't contain these but rather contain libcrypto.so.0.9.7 and
libssl.0.9.7.  Just in case it's important to future git development.

Best wishes & thanks again,

          -- Joe
