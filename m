From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: git doc build failure on OS X 10.5.6 (Leopard) during xmlto phase
Date: Wed, 11 Mar 2009 17:27:28 +0100
Message-ID: <49B7E670.7060606@drmicha.warpmail.net>
References: <5e68abd90903110721o414283a4te188b58e0e4df8ad@mail.gmail.com>	 <76718490903110812t5e1723ebi28a84da680422d8a@mail.gmail.com>	 <76718490903110839m17041c7bxd7912eb09496c81a@mail.gmail.com> <76718490903110849x2ef48a89j3f17706390991eda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Tom Holaday <tlholaday@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 17:29:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhRIv-0007AV-Va
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 17:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbZCKQ1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 12:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbZCKQ1n
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 12:27:43 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55156 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751354AbZCKQ1n (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 12:27:43 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 895982ED82B;
	Wed, 11 Mar 2009 12:27:40 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 11 Mar 2009 12:27:40 -0400
X-Sasl-enc: Q9oPcmsEdSaRdMWEmTVlR56129xASpeP3M22NOlzki3l 1236788859
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4FA9F4C27E;
	Wed, 11 Mar 2009 12:27:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090311 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <76718490903110849x2ef48a89j3f17706390991eda@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112949>

Jay Soffian venit, vidit, dixit 11.03.2009 16:49:
> On Wed, Mar 11, 2009 at 11:39 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
>> On Wed, Mar 11, 2009 at 11:12 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
>>> And your man pages still won't be perfect. Preformatted text will look
>>> like this:
>>>
>>>  .ft C
>>>          ...
>>>  .ft
> I must be losing my mind. This is suddenly working, though I can't
> track it down to any change in git. I just rebuilt my man pages and
> this no longer is occurring, even though I still have a terminal
> window open with the output of "git help help" _showing this problem_
> and that's from man pages I built/installed just a few days ago. (And
> I haven't upgraded MacPorts lately.)
> 
> Oh well.
> 
> j.

FWIW: The effect you describe (which is different from the OP) occurs on
Fedora 10 as well, and not only for git man pages, also for others. I've
been meaning to look into this, just like I've been meaning to look into
so much stuff...

Michael
