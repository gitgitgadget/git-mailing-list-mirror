From: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Subject: Re: gitk on Windows: layout problem
Date: Tue, 30 May 2006 21:20:17 +0200
Organization: -no organization-
Message-ID: <20060530192017.GC9948@scotty.home>
References: <20060530185441.GA10985@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 21:20:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl9lQ-0004Ws-Rl
	for gcvg-git@gmane.org; Tue, 30 May 2006 21:20:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWE3TUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 15:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWE3TUV
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 15:20:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:20720 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932373AbWE3TUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 15:20:20 -0400
Received: from [84.134.58.127] (helo=scotty.home)
	by mrelayeu.kundenserver.de (node=mrelayeu1) with ESMTP (Nemesis),
	id 0MKwpI-1Fl9lK1EU7-00072z; Tue, 30 May 2006 21:20:19 +0200
Received: from scotty.home (localhost [127.0.0.1])
	by scotty.home (8.13.4/8.13.4/Debian-3sarge1) with ESMTP id k4UJKHBc013431;
	Tue, 30 May 2006 21:20:17 +0200
Received: (from hs@localhost)
	by scotty.home (8.13.4/8.13.4/Submit) id k4UJKHgm013428;
	Tue, 30 May 2006 21:20:17 +0200
X-Authentication-Warning: scotty.home: hs set sender to stefan.hahn@s-hahn.de using -f
To: git@wingding.demon.nl
Content-Disposition: inline
In-Reply-To: <20060530185441.GA10985@nospam.com>
X-Mailer: Mutt 1.5.6 http://www.mutt.org/
X-Editor: GNU Emacs 21.4.1 http://www.gnu.org/
X-Accept-Language: de en
X-Location: Europe, Germany, Wolfenbuettel
X-GPG-Public-Key: http://www.s-hahn.de/gpg-public-stefan.asc
X-GPG-key-ID/Fingerprint: 0xE4FCD563 / EF09 97BB 3731 7DC7 25BA 5C39 185C F986 E4FC D563
User-Agent: Mutt/1.5.9i
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on scotty.home
X-Virus-Scanned: ClamAV 0.88.2/1499/Mon May 29 22:35:17 2006 on scotty.home
X-Virus-Status: Clean
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:77aa76da759ebc9bab1cc524fc813130
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21041>

Also sprach Rutger Nijlunsing am Tue, 30 May 2006 at 20:54:41 +0200:

> Is this a known problem? gitk-du-jour on Windows starts up with an
> unusable layout. Screenshot attached.

I have the same problem using gitk on Windows with Cygwin. Till now I avoid the
problem (because I know too little about TCL/TK) with commenting out the line
"catch {source ~/.gitk}".  Then then window can be sized to correct layout.

Stefan

-- 
Stefan-W. Hahn                          It is easy to make things.
/ mailto:stefan.hahn@s-hahn.de /        It is hard to make things simple.			
