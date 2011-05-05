From: Matthew L Daniel <mdaniel@gmail.com>
Subject: git-svn and a new svn remote helper
Date: Thu, 5 May 2011 19:13:04 +0000 (UTC)
Message-ID: <loom.20110505T211005-593@post.gmane.org>
References: <1303138000-27807-1-git-send-email-stsp@stsp.name> <vpqhb9vplu4.fsf@bauges.imag.fr> <7v39lfa1h5.fsf@alter.siamese.dyndns.org> <20110419093108.GA7440@ted.stsp.name> <4DAD6FC4.6060004@drmicha.warpmail.net> <20110419120031.GE4134@ted.stsp.name> <4DAD7EFB.2050507@drmicha.warpmail.net> <BANLkTimJa5EDxXerwgZP7viLFPQRc=39uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 21:15:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI417-0003qt-OJ
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 21:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369Ab1EETPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 15:15:11 -0400
Received: from lo.gmane.org ([80.91.229.12]:33720 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406Ab1EETPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 15:15:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QI40v-0003if-LM
	for git@vger.kernel.org; Thu, 05 May 2011 21:15:05 +0200
Received: from 85-171-101-167.rev.numericable.fr ([85.171.101.167])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 May 2011 21:15:05 +0200
Received: from mdaniel by 85-171-101-167.rev.numericable.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 05 May 2011 21:15:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 85.171.101.167 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_7) AppleWebKit/534.24 (KHTML, like Gecko) Chrome/11.0.696.57 Safari/534.24)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172884>

> >> On Tue, Apr 19, 2011 at 01:19:32PM +0200, Michael J Gruber wrote:
> >>> But, git-svn.perl is basically in maintenance mode
> >>> it seems, and more work is being done to implement a new svn remote helper.
> >>
> >> Is there already code for this new helper I can look at?
> >
> > Please look for "svn-fe".
> 
> svn-fe is a one-time conversion tool, isn't it? It's completely
> different than git-svn,
> which allows interactive working with existing svn repository.

The original thread appears to have died, but I am curious about its outcome.

Is there, in fact, a new svn remote helper under development?

  Thanks kindly,
  -- /v\atthew
