From: Johannes Gilger <heipei@hackvalue.de>
Subject: Re: git maintenance bug tracker sooner better than later
Date: Fri, 6 Feb 2009 12:33:07 +0000 (UTC)
Message-ID: <gmham3$209$1@ger.gmane.org>
References: <alpine.DEB.1.00.0902031541100.6573@intel-tinevez-2-302>
 <87tz7bniyk.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 13:34:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVPuw-0006Ae-V4
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 13:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbZBFMdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 07:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbZBFMdT
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 07:33:19 -0500
Received: from main.gmane.org ([80.91.229.2]:59697 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753129AbZBFMdS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 07:33:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LVPtU-0005I4-Oo
	for git@vger.kernel.org; Fri, 06 Feb 2009 12:33:17 +0000
Received: from u-4-171.vpn.rwth-aachen.de ([137.226.100.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 12:33:16 +0000
Received: from heipei by u-4-171.vpn.rwth-aachen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 12:33:16 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: u-4-171.vpn.rwth-aachen.de
User-Agent: slrn/0.9.9p1 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108693>

On 2009-02-04, jidanni@jidanni.org <jidanni@jidanni.org> wrote:
> Anyway, I have this file
>   -rw-r--r--  1   19561 2009-01-13 03:26 DietCherries17
> where I have 17 tiny documentation patches that sent to
> git@vger.kernel.org but nothing happened.

As I recall a lot of those things were replied to (at least for the 
first few patches) as being not quite right (or plain wrong). Once you 
even said "oh, if you could fix this for me before applying it". At some 
point the time it takes to review patches and to write a quick fix for 
the bugs/typos yourself stands in no relation whatsoever.

> Perhaps I could send them to a volunteer who could see if any of them
> are useful and then do something with them. Thanks.

Or you could make one big "typo-fix"-patch out of them and one 
"i-didnt-understand-the-manpage-there"-patch. Then these patches could 
be reviewed and you could revise them.

A second solution would be to tackle real problems, earn the respect of 
the maintainer and those close to him, have your patches merged and 
_then_ when you come up with nitpicks about documentation, those people 
would be sure of your abilities and would put more trust in you to not 
mess up when writing documentation.

About the bug-tracker-thing: I am quite happy that git is one of those 
projects where everything happens in one spot: Development, 
bug-reporting and general discussion. It makes it a lot easier than 
disconnected systems where information is easily duplicated and becomes 
stale at other ends.

But that's just my oppinion,
Greetings, Jojo

-- 
Johannes Gilger <heipei@hackvalue.de>
http://hackvalue.de/heipei/
GPG-Key: 0x42F6DE81
GPG-Fingerprint: BB49 F967 775E BB52 3A81  882C 58EE B178 42F6 DE81
