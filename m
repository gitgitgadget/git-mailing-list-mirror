From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sat, 5 May 2007 22:37:15 +0200
Message-ID: <20070505203715.GC2898@steel.home>
References: <463BD40C.6080909@gmail.com> <Pine.LNX.4.64.0705050324580.4015@racer.site> <20070505033039.GD16538@spearce.org> <20070505193214.GD30511@admingilde.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Sat May 05 22:37:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkR0N-0007SD-5X
	for gcvg-git@gmane.org; Sat, 05 May 2007 22:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933949AbXEEUhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 16:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933984AbXEEUhT
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 16:37:19 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:27937 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933949AbXEEUhS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 16:37:18 -0400
Received: from tigra.home (195.4.202.37)
	by post.webmailer.de (klopstock mo37) (RZmta 5.9)
	with ESMTP id G04297j45ID9zo ; Sat, 5 May 2007 22:37:16 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 2B431277BD;
	Sat,  5 May 2007 22:37:16 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id AB892D171; Sat,  5 May 2007 22:37:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070505193214.GD30511@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46285>

Martin Waitz, Sat, May 05, 2007 21:32:14 +0200:
> we could also introduce "<tree-ish>/<path>" for absolute path entries.

"012345/abc/def"

Is it a relative path, or a tree-ish + absolute path?
