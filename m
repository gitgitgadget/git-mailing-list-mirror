From: John Chapman <thestar@fussycoder.id.au>
Subject: Re: Sporadic BSOD with msys git?
Date: Thu, 29 Jan 2009 23:27:07 +1100
Message-ID: <1233232027.5816.1.camel@therock.nsw.bigpond.net.au>
References: <20090129115442.6ce311f8@crow>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 14:07:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSWcE-0003HI-Rg
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 14:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbZA2NFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 08:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZA2NFz
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 08:05:55 -0500
Received: from nschwqsrv02p.mx.bigpond.com ([61.9.189.234]:37717 "EHLO
	nschwqsrv02p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120AbZA2NFy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jan 2009 08:05:54 -0500
Received: from nschwotgx02p.mx.bigpond.com ([58.173.132.215])
          by nschwmtas06p.mx.bigpond.com with ESMTP
          id <20090129121431.WJGF3101.nschwmtas06p.mx.bigpond.com@nschwotgx02p.mx.bigpond.com>;
          Thu, 29 Jan 2009 12:14:31 +0000
Received: from therock.local ([58.173.132.215])
          by nschwotgx02p.mx.bigpond.com with ESMTP
          id <20090129121430.NYMS6144.nschwotgx02p.mx.bigpond.com@therock.local>;
          Thu, 29 Jan 2009 12:14:30 +0000
In-Reply-To: <20090129115442.6ce311f8@crow>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150201.49819DA7.0032,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107669>

Is that a clean windows XP system in VMware - with how much RAM?
 - I just find it strange, because I've had a similar setup, but never
once got a crash like that.

Additionally, the BSOD is in the guest, and not the host?
 - if it is the host that is BSOD'ing, then go check your memory,
something's wierd there.

On Thu, 2009-01-29 at 11:54 +0000, Mark Burton wrote:
> Hi,
> 
> I occasionally have to use Windows (XP under VMWare) and thought I would try
> out msysgit so I installed the recent version (1.6.1). For what I was
> wanting to use it for, it worked OK.
> 
> However, I then started getting crashes when using the Windows explorer. I would
> click on a folder to look at its contents and, whammo, Windows would crash. It
> just happened every now and again, not all the time.
> 
> I uninstalled msysgit and now the crashes are not happening any more. Not
> exactly conclusive evidence but, perhaps, there's an issue there?
> 
> Has anyone else seen this?
> 
> Cheers,
> 
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
