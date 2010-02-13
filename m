From: Ron Garret <ron1@flownet.com>
Subject: Re: Individual file snapshots
Date: Sat, 13 Feb 2010 10:41:34 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-E2C140.10413413022010@news.gmane.org>
References: <ron1-CD3223.04030512022010@news.gmane.org> <4B75BD06.1010802@lsrfire.ath.cx> <ron1-519083.13253112022010@news.gmane.org> <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com> <ron1-62D136.13570812022010@news.gmane.org> <C022F034-F60E-4E89-A174-DC0F53ADEC19@silverinsanity.com> <ron1-5EFFD7.14390512022010@news.gmane.org> <ca433831002121633j5b96049bs71e539c96397aff4@mail.gmail.com> <7v6362c672.fsf@alter.siamese.dyndns.org> <ca433831002130713i5b015686k9f53911954858845@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 19:42:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgMwM-00018e-6c
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 19:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583Ab0BMSl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 13:41:56 -0500
Received: from lo.gmane.org ([80.91.229.12]:46786 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752727Ab0BMSl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 13:41:56 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NgMwE-00013u-OW
	for git@vger.kernel.org; Sat, 13 Feb 2010 19:41:54 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 19:41:54 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 19:41:54 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139820>

In article 
<ca433831002130713i5b015686k9f53911954858845@mail.gmail.com>,
 Mark Lodato <lodatom@gmail.com> wrote:

> On Sat, Feb 13, 2010 at 2:01 AM, Ron Garret <ron1@flownet.com> wrote:
> > Moving the index around seems kinda hacky.  You probably want git-mktree.
> 
> git-mktree is way too complicated.  I would have to parse the index
> and call git-mktree for each directory.

Yeah, but think of how studly you'll feel when you do that! ;-)

> Besides, using GIT_INDEX_FILE as suggested
> by Junio allows me to leave the original index file intact.

Yeah, that might actually be a better plan.

rg
