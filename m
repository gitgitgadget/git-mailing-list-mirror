From: Joseph Wakeling <joseph.wakeling@webdrake.net>
Subject: Re: Configuring gitk appearance
Date: Thu, 15 Feb 2007 17:05:55 +0000
Message-ID: <45D492F3.90404@webdrake.net>
References: <45D48951.2000207@webdrake.net> <20070215162646.GA25337@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Vincent Hanquez <tab@snarc.org>
X-From: git-owner@vger.kernel.org Thu Feb 15 18:06:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHk46-0003cl-5e
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 18:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbXBORGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 12:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbXBORGJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 12:06:09 -0500
Received: from alf.nbi.dk ([130.225.212.55]:1048 "EHLO alf.nbi.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030247AbXBORGI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 12:06:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by alf.nbi.dk (8.9.3/8.9.3) with ESMTP id SAA13448;
	Thu, 15 Feb 2007 18:05:57 +0100 (MET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
In-Reply-To: <20070215162646.GA25337@snarc.org>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39838>

Vincent Hanquez wrote:
> gitk is not using GTK v1 but TCL/TK.
> 
> see your ~/.gitk and just change those option (9 to 13 or 15 will do):
> 
> set mainfont {Helvetica 9}
> set textfont {Courier 9}
> set uifont {Helvetica 9 bold}

Thanks very much.  Where does gitk look for fonts?  It seems to find
some, but not others, of the different sorts I have on my system.
