From: Michael Meeks <michael.meeks@novell.com>
Subject: Re: libreoffice merge(tool?) issue #3 ...
Date: Tue, 22 Feb 2011 18:14:39 +0000
Organization: Novell, Inc.
Message-ID: <1298398479.32648.184.camel@lenovo-w500>
References: <1298388877.32648.171.camel@lenovo-w500>
	 <4D63F2C5.2080505@drmicha.warpmail.net>
Reply-To: michael.meeks@novell.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, kendy@novell.com,
	Norbert Thiebaud <nthiebaud@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 22 19:15:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prwlk-0008S5-87
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 19:15:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab1BVSPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 13:15:23 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:41297 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754642Ab1BVSPX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 13:15:23 -0500
Received: from [192.168.1.4] (host81-153-59-197.range81-153.btcentralplus.com [81.153.59.197])
	by nat.nue.novell.com with ESMTP; Tue, 22 Feb 2011 19:15:21 +0100
In-Reply-To: <4D63F2C5.2080505@drmicha.warpmail.net>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167568>

Hi Michael,

On Tue, 2011-02-22 at 18:30 +0100, Michael J Gruber wrote:
> I get thousands of conflicts. Have the branches moved since your post?
> It may be better to give us sha1 or stable tags.

	Nope; there are thousands of conflicts; a subset of these are (I would
like to think ;-) erroneous; but I'm picking out individual files with
problems that I can repeat easily and that have (I hope) simple history
to try to isolate the problems for you.

> Are you doing any builds before merging?

	Builds of what ? git - no; LibreOffice - sure, it builds before the
merge - and then there is a huge slew of work to do to make it build
afterwards ;-) but then that is not so suprising.

	Anyhow - thanks for looking at it; can you replicate the suprising
result in that file: ucb/source/ucp/ext/makefile.mk ? what does
'refusing to loose untracked file' mean in that context ?

	Thanks,

		Michael.

-- 
 michael.meeks@novell.com  <><, Pseudo Engineer, itinerant idiot
