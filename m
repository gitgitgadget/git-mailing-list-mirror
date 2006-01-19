From: Christopher Faylor <me@cgf.cx>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 15:34:28 -0500
Message-ID: <20060119203428.GA5090@trixie.casa.cgf.cx>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com> <20060119052914.GC8121@trixie.casa.cgf.cx> <7vlkxciodu.fsf@assigned-by-dhcp.cox.net> <20060119161000.GA27888@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 19 21:34:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzgUe-0003Pf-KU
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 21:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161417AbWASUea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 15:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161418AbWASUea
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 15:34:30 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:20401 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1161417AbWASUe3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 15:34:29 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 7256E4A8303; Thu, 19 Jan 2006 15:34:28 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060119161000.GA27888@trixie.casa.cgf.cx>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14930>

On Thu, Jan 19, 2006 at 11:10:00AM -0500, Christopher Faylor wrote:
>On Thu, Jan 19, 2006 at 12:59:57AM -0800, Junio C Hamano wrote:
>>Christopher Faylor <me@cgf.cx> writes:
>>>"They" probably would like to hear about any irregularities that are
>>>found.  "They" probably don't like it when people treat an open source
>>>project as if it was some unresponsive proprietary enterprise which
>>>does not listen to or accept patches.
>>
>>First of all, thanks for joining our discussion.
>
>You're welcome.  I use git on linux and cygwin so I'm happy to try to help.

Btw, we're looking to roll out a new release of cygwin which fixes the
embarrassing typo in sockaddr_storage.  It is fixed in cygwin snapshots:

http://cygwin.com/snapshots/

cgf
