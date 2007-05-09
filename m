From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Anyone running GIT on native Windows
Date: Wed, 09 May 2007 01:41:42 -0300
Message-ID: <46415106.5040401@xs4all.nl>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>		 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>		 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>		 <463ECEF4.625F3633@eudaptics.com> <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com> <463F14FF.F8DF11EB@eudaptics.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 09 06:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hle89-00020C-DW
	for gcvg-git@gmane.org; Wed, 09 May 2007 06:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbXEIEuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 00:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754615AbXEIEuQ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 00:50:16 -0400
Received: from main.gmane.org ([80.91.229.2]:57317 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbXEIEuO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 00:50:14 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hle6L-0003ee-7v
	for git@vger.kernel.org; Wed, 09 May 2007 06:48:33 +0200
Received: from c911deb6.bhz.virtua.com.br ([201.17.222.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2007 06:48:33 +0200
Received: from hanwen by c911deb6.bhz.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 09 May 2007 06:48:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c911deb6.bhz.virtua.com.br
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
In-Reply-To: <463F14FF.F8DF11EB@eudaptics.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46657>

Johannes Sixt escreveu:
> The next big thing to think about is an installer. Does anyone have a
> suggestion for a free installer tool? I only know about Microsoft's WiX
> (wix.sf.net), but it requires .NET (for the developer, not the user).

I packaged Mingw GIT using NSIS some time ago; see 

  http://lilypond.org/git/binaries/mingw/

Due various personal reasons, I haven't been able to update this, but I 
will package a new version soon. Please try it to see whether there are 
any rough edges. 

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
