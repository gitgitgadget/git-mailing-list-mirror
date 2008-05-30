From: Petr Baudis <pasky@suse.cz>
Subject: Re: Gitweb caching: Google Summer of Code project
Date: Fri, 30 May 2008 17:38:22 +0200
Message-ID: <20080530153822.GH593@machine.or.cz>
References: <483C4CFF.2070101@gmail.com> <200805300127.10454.jnareb@gmail.com> <483FABB4.1010309@gmail.com> <200805301202.25368.jnareb@gmail.com> <4840166C.3030903@gmail.com> <20080530150713.GG593@machine.or.cz> <48401CFF.4020702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Hjemli <hjemli@gmail.com>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 30 17:39:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K26hJ-0005YR-Km
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 17:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYE3PiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 11:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbYE3PiZ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 11:38:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56820 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412AbYE3PiY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 11:38:24 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id C991D1E4C036; Fri, 30 May 2008 17:38:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48401CFF.4020702@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83310>

On Fri, May 30, 2008 at 05:27:59PM +0200, Lea Wiemann wrote:
> Petr Baudis wrote:
>> I wonder what oldest Perl versions do we aim to support?
>
> I'm thinking about 5.8 or 5.10.  Looking at Debian, Perl 5.10 is not in 
> stable (etch), but it's in lenny, which is planned to become stable in 
> Sept. 08.  So by the time the updated Gitweb/Git.pm has stabilized (and 
> shows up as a package in Debian), Perl 5.10 will definitely be available 
> widely enough.

Wow, and here I was wondering if requiring at least 5.6 was not too
liberal. ;-) I believe 5.8 is the newest possible candidate though, it
is still too widespread; e.g. Debian-wise, many servers run on Etch and
are going to stay there even for quite some time after Lenny gets
released. Heck, I still have accounts on plenty of Sarge machines. ;-)
(Sarge seems to have Perl-5.8.4.)

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
