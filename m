From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Importing Mozilla CVS into git
Date: Wed, 07 Jun 2006 17:58:37 +0200
Organization: At home
Message-ID: <e66t2v$6hb$1@sea.gmane.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com> <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com> <1149219593.5521.34.camel@neko.keithp.com> <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com> <1149220518.5521.43.camel@neko.keithp.com> <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com> <20060602041107.GA5429@spearce.org> <1149223164.2443.33.camel@dv> <9e4733910606012144p5f4fda26sdc2de2cc77b71fe7@mail.gmail.com> <df0b33100606070202w581ff581i435056f0fbc197f8@mail.gmail.com> <9e4733910606070830g24a08771i1a332552a95283d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 07 17:59:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo0RU-0000bZ-Id
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 17:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWFGP7e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 11:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWFGP7d
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 11:59:33 -0400
Received: from main.gmane.org ([80.91.229.2]:48598 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932276AbWFGP7d (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jun 2006 11:59:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Fo0Qq-0000RA-7W
	for git@vger.kernel.org; Wed, 07 Jun 2006 17:58:56 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 17:58:56 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Jun 2006 17:58:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21440>

Jon Smirl wrote:

> On 6/7/06, Igor Bukanov <igor.bukanov@gmail.com> wrote:
>> On 6/2/06, Jon Smirl <jonsmirl@gmail.com> wrote:
>>> On 6/2/06, Pavel Roskin <proski@gnu.org> wrote:
>>>> Dependency on Cygwin, Perl and Python is too much.  Windows is becoming
>>>> a legacy system in some circles, and it may run on legacy hardware. Yet
>>>> it's irreplaceable as a testing platform for many projects.
>>>
>>> 80% of Mozilla commiters are running Windows. Some are OS bilingual
>>> but many are not.
>>
>> Mozilla build system on Windows requires Cygwin and there are 198 Perl
>> files in Firefox tree. So it is only Python that can be problematic.
> 
> Other people have sent me mail saying this may not be as big  as
> problem as was thought, only documentation people on WIndows may be an
> issues.

With 1.4.0 there should be tar files of documentation. For now, one can use
html and man branches of git.git repository: see the INSTALL file and/or

  http://git.or.cz/gitwiki/GitDocumentation

-- 
Jakub Narebski
Warsaw, Poland
