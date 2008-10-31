From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 15:01:33 -0700
Message-ID: <20081031220133.GA14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <490B7FD3.8060003@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:03:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw258-0007kk-0s
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752568AbYJaWBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbYJaWBf
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:01:35 -0400
Received: from george.spearce.org ([209.20.77.23]:48300 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbYJaWBe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:01:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id DD5D53835F; Fri, 31 Oct 2008 22:01:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <490B7FD3.8060003@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99656>

Andreas Ericsson <ae@op5.se> wrote:
>>   * proper public "stuff" naming (I e.g. realy like types names -- not
>>     struct or enum tags, that I don't really care -- ending with _t as
>>     it helps navigating source.
>
> *_t types are reserved by POSIX for future implementations, so that's
> a no-go (although I doubt POSIX will ever make types named git_*_t).

Yikes.  Anyone know where a concise list of the reserved names are?

> Apart from that, please consider reading Ulrich Drepper's musings on
> library design at http://people.redhat.com/drepper/goodpractice.pdf

I think I've read that before, but I'll skim over it again.
Thanks for the link.

-- 
Shawn.
