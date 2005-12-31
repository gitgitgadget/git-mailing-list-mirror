From: Christopher Faylor <me@cgf.cx>
Subject: Re: Possibility of a MinGW version?
Date: Sat, 31 Dec 2005 11:40:12 -0500
Message-ID: <20051231164012.GA24402@trixie.casa.cgf.cx>
References: <006c01c60832$86f92620$6900a8c0@sps> <43AD1E63.4040103@op5.se> <009701c60891$50893fd0$6900a8c0@sps>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Dec 31 17:40:24 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EsjmD-0008AH-Db
	for gcvg-git@gmane.org; Sat, 31 Dec 2005 17:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965024AbVLaQkO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Dec 2005 11:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVLaQkN
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Dec 2005 11:40:13 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:30592 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S965019AbVLaQkM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Dec 2005 11:40:12 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 8E8AA13C49C; Sat, 31 Dec 2005 11:40:12 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>, Rob McDonald <robm@asdl.gatech.edu>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <009701c60891$50893fd0$6900a8c0@sps>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14124>

On Sat, Dec 24, 2005 at 08:51:53AM -0500, Rob McDonald wrote:
>MSYS is a minimal system that includes ports of all build-chain tools
>you need to get Makefiles to work.  I would envision using it along
>with native ports of Perl, Tk/Tcl, etc.

MSYS is basically an unmaintained fork of Cygwin.  It uses an old
version of the Cygwin DLL with some hacks to handle path names
differently.  It isn't intended as a platform for porting packages to
MSYS.  It is intended to be used as an environment for porting packages
to MinGW.

cgf
