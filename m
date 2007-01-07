From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: problem with git clone on cygwin
Date: Sun, 7 Jan 2007 10:30:15 +0100
Organization: -no organization-
Message-ID: <20070107093015.GA9909@scotty.home>
References: <20070106170330.GA8041@scotty.home> <17824.5988.344000.501073@lapjr.intranet.kiel.bmiag.de> <20070106215919.GB8041@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 07 10:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3UMK-00019o-Kv
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 10:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932450AbXAGJaa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 04:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbXAGJaa
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 04:30:30 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:53901 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932450AbXAGJa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 04:30:29 -0500
Received: from [84.134.15.225] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis),
	id 0ML29c-1H3UM449VN-0007z2; Sun, 07 Jan 2007 10:30:27 +0100
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l079UFQ4010493
	for <git@vger.kernel.org>; Sun, 7 Jan 2007 10:30:15 +0100
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id l079UFhH010490
	for git@vger.kernel.org; Sun, 7 Jan 2007 10:30:15 +0100
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070106215919.GB8041@scotty.home>
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC D563
User-Agent: Mutt/1.5.9i
X-Spam-Status: No, score=-0.0 required=5.0 tests=ALL_TRUSTED,
	UNWANTED_LANGUAGE_BODY autolearn=failed version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Virus-Scanned: ClamAV 0.88.7/2417/Sun Jan  7 00:06:17 2007 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36143>

Also sprach Stefan-W. Hahn am Sat, 06 Jan 2007 at 22:59:19 +0100:
> Also sprach Juergen Ruehle am Sat, 06 Jan 2007 at 22:40:52 +0100:
> > You should compile a cygwin.dll from 1.5.21 sources with the pread
> > patch applied.
> 
> Thanks for the info.
> 
> > Could you enumerate the other compatability problems?
> 
> The problem that one cannot use one version of cygwin.dll and
> simultaniously another (incomatible) version. (Having a local
> installed cygwin window open and trying to build in a branch where
> another version is used.)
> 
> -- 
> Stefan-W. Hahn                          It is easy to make things.
> / mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			
> 

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			
