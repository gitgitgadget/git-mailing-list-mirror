From: David Brown <git@davidb.org>
Subject: Re: git to libgit2 code relicensing
Date: Fri, 14 Nov 2008 20:30:52 -0800
Message-ID: <20081115043051.GA21608@linode.davidb.org>
References: <491DE6CC.6060201@op5.se> <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org> <20081114234658.GA2932@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 05:32:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1CpQ-0005Fw-3Z
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 05:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbYKOEa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 23:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751963AbYKOEa4
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 23:30:56 -0500
Received: from linode.davidb.org ([72.14.176.16]:53514 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009AbYKOEa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 23:30:56 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1L1Co8-0005gR-1g; Fri, 14 Nov 2008 20:30:52 -0800
Content-Disposition: inline
In-Reply-To: <20081114234658.GA2932@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101044>

On Fri, Nov 14, 2008 at 03:46:58PM -0800, Shawn O. Pearce wrote:

> In addition to the permissions in the GNU General Public License,
> the authors give you unlimited permission to link the compiled
> version of this file into combinations with other programs,
> and to distribute those combinations without any restriction
> coming from the use of this file.  (The General Public License
> restrictions do apply in other respects; for example, they cover
> modification of the file, and distribution when not linked into
> a combined executable.)

Is this license intended to allow static linking but forbid dynamic
linking into a non-GPL program?  It depends on how you interpret
"linked into a combined executable", but that sounds like it
intentionally excludes the dynamic case.

David
