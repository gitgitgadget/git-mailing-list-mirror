From: Perry Wagle <wagle@cs.indiana.edu>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Wed, 27 Aug 2008 12:43:23 -0700
Message-ID: <B83CC7EA-C77E-45CA-B9C5-FC81A8C0C9A5@cs.indiana.edu>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>, <20080826162513.GR10544@machine.or.cz>, <20080826164526.GM26610@one.firstfloor.org> <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Andi Kleen <andi@firstfloor.org>,
	Kristian H??gsberg <krh@redhat.com>,
	Matthias Kestenholz <mk@spinlock.ch>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Wed Aug 27 21:46:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYQyJ-0002SA-05
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 21:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbYH0Tox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 15:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbYH0Tox
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 15:44:53 -0400
Received: from newman.cs.indiana.edu ([129.79.247.4]:33955 "EHLO
	newman.cs.indiana.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYH0Tow (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 15:44:52 -0400
Received: from smtp.cs.indiana.edu (smtp.cs.indiana.edu [129.79.247.7])
	by newman.cs.indiana.edu (8.13.1/8.13.1/IUCS_2.87) with ESMTP id m7RJhWME004624;
	Wed, 27 Aug 2008 15:43:33 -0400
Received: from dhcp-2.metabiology.com (pool-96-253-170-5.ptldor.fios.verizon.net [96.253.170.5])
	(authenticated bits=0)
	by rage.cs.indiana.edu (8.13.1/8.13.1/IUCS_SMTP_Alternate_Port_1.4) with ESMTP id m7RJhOdl019884
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 27 Aug 2008 15:43:28 -0400
In-Reply-To: <48B5098E.748.A598B62@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93931>

On Aug 26, 2008, at 11:00 PM, Ulrich Windl wrote:
> On 26 Aug 2008 at 18:45, Andi Kleen wrote:
>> git<space><tab><tab>.... what? 140-something commands? etc.etc.
> Whether files in /usr/bin, or command completions: Long linear lists  
> are a thing
> humans don't like.

Bash and other shells use hash tables to store the commands in the PATH.

Doing git-<tab> was shocking to me at first, but it also showed me a  
list of commands for me to learn.

Now I guess that when everything's fixed up, I'll have to put in a  
space instead of a dash to get exactly the same thing.

What difference did changing the dash to a space make?

-- Perry
