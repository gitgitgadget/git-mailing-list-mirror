From: David Brown <git@davidb.org>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 10:39:48 -0800
Message-ID: <20081115183948.GA22714@linode.davidb.org>
References: <491DE6CC.6060201@op5.se> <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org> <20081114234658.GA2932@spearce.org> <20081115043051.GA21608@linode.davidb.org> <20081115050039.GC2932@spearce.org> <alpine.LFD.2.00.0811150256140.27509@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 19:41:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1Q5K-0006cL-Fu
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 19:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124AbYKOSkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 13:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYKOSj5
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 13:39:57 -0500
Received: from linode.davidb.org ([72.14.176.16]:34731 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751888AbYKOSj4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 13:39:56 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1L1Q3g-0005wl-4d; Sat, 15 Nov 2008 10:39:48 -0800
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811150256140.27509@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101083>

On Sat, Nov 15, 2008 at 03:04:29AM -0500, Nicolas Pitre wrote:

>libgcc is a dynamic library on most modern systems these days. Yet they 
>routinely execute non-GPL programs. If that text intentionally excluded 
>the dynamic case then every non-GPL applications on such systems would 
>have been breaking the license for a long time.  So I don't think anyone 
>could have substance for such a claim.

Sure they can.  Lack of enforcement doesn't dilute copyright like it
does trademark.

It may be that the gcc authors intend for it to be allowed for dynamic
libraries, and therefore wouldn't sue for that usage, but that's not
what they're saying in their license.

What I'm saying is that if I was in a position to review the license
and determine what was permitted, this license with exception does not
appear to allow dynamic linking against the library.  It doesn't
explicitly forbid this, but it is ambiguous about it.

David
