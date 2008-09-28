From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH 7/8] Docs: send-email: Added all config variables to man end
Date: Sun, 28 Sep 2008 14:03:42 -0500
Message-ID: <C886DB88-EA48-4608-A9DB-B8A11C1240B2@MIT.EDU>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <1222564196-84202-2-git-send-email-mfwitten@mit.edu> <1222564196-84202-3-git-send-email-mfwitten@mit.edu> <1222564196-84202-4-git-send-email-mfwitten@mit.edu> <1222564196-84202-5-git-send-email-mfwitten@mit.edu> <1222564196-84202-6-git-send-email-mfwitten@mit.edu> <1222564196-84202-7-git-send-email-mfwitten@mit.edu> <20080928031822.GB15696@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 28 21:06:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kk1aY-0005rj-OS
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 21:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbYI1TEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 15:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbYI1TEF
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 15:04:05 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:37865 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751606AbYI1TED (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Sep 2008 15:04:03 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8SJ3h9p026778;
	Sun, 28 Sep 2008 15:03:43 -0400 (EDT)
Received: from [192.168.0.65] (97-116-104-112.mpls.qwest.net [97.116.104.112])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8SJ3K6C015113
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sun, 28 Sep 2008 15:03:42 -0400 (EDT)
In-Reply-To: <20080928031822.GB15696@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.929.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96980>


On 27 Sep 2008, at 10:18 PM, Jeff King wrote:

> On Sat, Sep 27, 2008 at 08:09:55PM -0500, Michael Witten wrote:
>
>> Admittedly, I didn't take much pride in my work, but
>> I'm not trying to solve this problem.
>
> Remember that your commit message is supposed to be convincing us that
> your patch is worth applying. ;P

Well, I told the truth ;-)

> It seems like these are just mechanical "sendemail.foo is a default  
> for
> --foo" additions.

They are indeed!

> Maybe it is better to simply make a note of that (or
> mention it in the --foo section).

Then it would be better to do away with all but

	sendemail.aliasesfile
	sendemail.aliasfile

which sounds OK with me.
