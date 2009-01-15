From: Kirill Smelkov <kirr@landau.phys.spbu.ru>
Subject: Re: What's cooking in git.git (Jan 2009, #03; Wed, 14)
Date: Thu, 15 Jan 2009 22:49:26 +0300
Organization: St.Petersburg State University
Message-ID: <20090115194926.GA6899@roro3.zxlink>
References: <7vmydu3yy7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 20:49:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNYDf-00051c-Ha
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 20:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbZAOTsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 14:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbZAOTsL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 14:48:11 -0500
Received: from landau.phys.spbu.ru ([195.19.235.38]:1581 "EHLO
	landau.phys.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbZAOTsK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 14:48:10 -0500
Received: by landau.phys.spbu.ru (Postfix, from userid 509)
	id 65F6417B661; Thu, 15 Jan 2009 22:48:08 +0300 (MSK)
Received: from kirr by landau.phys.spbu.ru with local (Exim 4.69)
	(envelope-from <kirr@roro3.zxlink>)
	id 1LNYDW-0005UF-CT; Thu, 15 Jan 2009 22:49:26 +0300
Content-Disposition: inline
In-Reply-To: <7vmydu3yy7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105871>

On Wed, Jan 14, 2009 at 03:32:32AM -0800, Junio C Hamano wrote:

[...]

> [Actively cooking]
> 
> * gb/gitweb-opml (Fri Jan 2 13:49:30 2009 +0100) 2 commits
>  + gitweb: suggest name for OPML view
>  + gitweb: don't use pathinfo for global actions
> 
> * ks/maint-mailinfo-folded (Mon Jan 12 15:22:11 2009 -0800) 2 commits
>  - mailinfo: 'From:' header should be unfold as well
>  - mailinfo: correctly handle multiline 'Subject:' header
> 
> The author seems to have more updates, but I couldn't extract them from
> the e-mail.

Sorry for the inconvenience, and please pull them all from

    git://repo.or.cz/git/kirr.git   for-junio


Kirill Smelkov (4):
      mailinfo: 'From:' header should be unfold as well
      mailinfo: more smarter removal of rfc822 comments from 'From'
      mailinfo: correctly handle multiline 'Subject:' header
      mailinfo: add explicit test for mails like '<a.u.thor@example.com> (A U Thor)'


Thanks,
Kirill
