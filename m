From: Mark Burton <markb@ordern.com>
Subject: Sporadic BSOD with msys git?
Date: Thu, 29 Jan 2009 11:54:42 +0000
Organization: Order N Ltd.
Message-ID: <20090129115442.6ce311f8@crow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 29 13:01:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSVaA-00015t-Do
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 13:01:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756AbZA2L7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 06:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbZA2L7w
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 06:59:52 -0500
Received: from c2beaomr07.btconnect.com ([213.123.26.185]:4067 "EHLO
	c2beaomr07.btconnect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbZA2L7v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 06:59:51 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jan 2009 06:59:51 EST
Received: from crow.ordern.com (host86-128-142-98.range86-128.btcentralplus.com [86.128.142.98])
	by c2beaomr07.btconnect.com (MOS 3.8.6-GA)
	with ESMTP id BTM70700;
	Thu, 29 Jan 2009 11:54:42 GMT
Received: from crow (localhost [127.0.0.1])
	by crow.ordern.com (Postfix) with ESMTP id 640F1190D90
	for <git@vger.kernel.org>; Thu, 29 Jan 2009 11:54:42 +0000 (GMT)
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.12.9; x86_64-pc-linux-gnu)
X-Junkmail-Status: score=10/50, host=c2beaomr07.btconnect.com
X-Junkmail-SD-Raw: score=unknown,
	refid=str=0001.0A0B0202.49819903.01AD,ss=1,fgs=0,
	ip=86.128.142.98,
	so=2007-10-30 19:00:17,
	dmn=5.7.1/2008-09-02
X-Junkmail-IWF: false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107664>


Hi,

I occasionally have to use Windows (XP under VMWare) and thought I would try
out msysgit so I installed the recent version (1.6.1). For what I was
wanting to use it for, it worked OK.

However, I then started getting crashes when using the Windows explorer. I would
click on a folder to look at its contents and, whammo, Windows would crash. It
just happened every now and again, not all the time.

I uninstalled msysgit and now the crashes are not happening any more. Not
exactly conclusive evidence but, perhaps, there's an issue there?

Has anyone else seen this?

Cheers,

Mark
