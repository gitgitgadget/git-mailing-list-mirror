From: Stephen Kelly <steveire@gmail.com>
Subject: Re: [PATCH v2] Introduce new configuation option to override committer information
Date: Thu, 20 Jan 2011 12:16:37 +0100
Message-ID: <ih95il$62b$2@dough.gmane.org>
References: <igadki$4tb$2@dough.gmane.org> <1294568989-5848-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 20 12:20:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfsYm-00027Q-Bl
	for gcvg-git-2@lo.gmane.org; Thu, 20 Jan 2011 12:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755437Ab1ATLUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jan 2011 06:20:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:45761 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752916Ab1ATLUG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jan 2011 06:20:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PfsYe-00022r-AC
	for git@vger.kernel.org; Thu, 20 Jan 2011 12:20:04 +0100
Received: from 188.111.54.34 ([188.111.54.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 12:20:04 +0100
Received: from steveire by 188.111.54.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 20 Jan 2011 12:20:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.34
User-Agent: KNode/4.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165310>

Ramkumar Ramachandra wrote:

> Currently, there is no way to set committer information on a
> per-repository basis. The 'user.name' and 'user.email' configuration
> options set both author and committer information. To solve this,
> introduce 'user.committername' and 'user.committeremail' configuration
> options to override committer name and email respectively.

Is this patch going to become part of git, or is it in already?

If not it will probably just get lost because there is no issue tracker.

Thanks,

Steve.
