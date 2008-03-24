From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [ANNOUNCE] Stacked GIT 0.14.2
Date: Mon, 24 Mar 2008 23:31:57 +0100
Message-ID: <47E82BDD.9060507@keyaccess.nl>
References: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com> <alpine.LNX.1.10.0803242113070.9368@fbirervta.pbzchgretzou.qr> <47E81037.5030808@keyaccess.nl> <7vlk47ua3v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	git <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755470AbYCXWa6@vger.kernel.org Mon Mar 24 23:32:04 2008
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755470AbYCXWa6@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdvCy-00051i-Fx
	for glk-linux-kernel-3@gmane.org; Mon, 24 Mar 2008 23:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755470AbYCXWa6 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 24 Mar 2008 18:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753600AbYCXWar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Mar 2008 18:30:47 -0400
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:55213 "EHLO
	smtpq2.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbYCXWaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Mar 2008 18:30:46 -0400
Received: from [213.51.130.188] (port=45527 helo=smtp3.groni1.gr.home.nl)
	by smtpq2.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JdvBg-0005n7-Qt; Mon, 24 Mar 2008 23:30:40 +0100
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:49206 helo=[192.168.0.3])
	by smtp3.groni1.gr.home.nl with esmtp (Exim 4.60)
	(envelope-from <rene.herman@keyaccess.nl>)
	id 1JdvBg-0003Be-2n; Mon, 24 Mar 2008 23:30:40 +0100
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <7vlk47ua3v.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78110>

On 24-03-08 21:43, Junio C Hamano wrote:

> Rene Herman <rene.herman@keyaccess.nl> writes:
> 
>> On 24-03-08 21:15, Jan Engelhardt wrote:
>>
>>> On Monday 2008-03-24 20:59, Catalin Marinas wrote:
>>>
>>>> Stacked GIT 0.14.2 release is available from
>>>> http://www.procode.org/stgit/.
>>>>
>>>> StGIT is a Python application providing similar functionality to Quilt
>>>> (i.e. pushing/popping patches to/from a stack) on top of GIT.
>>> I always wondered what the difference between stgit and guilt is.
>>> Does anyone have a comparison up?
>> And I remember some mumblings about git growing quilt-like
>> functionality itself. Anything on that?
> 
> Not my mumbling

Believe it was Linus. Seem to remember him saying something about possibly 
adding a native queues-like interface not too long ago but it's proving 
impossible to google for.

> but I am quite open to slurp in guilt as a subdirectory in git.git at
> some point in the future just like we bundle git-gui and gitk if asked by
> the maintainer.
> 
> The same applies to StGIT for that matter, although I somehow feel that
> is much less likely to happen, because it lived long enough as a
> standalone project with enough following to achieve sustainable momentum
> by itself.

Rene.
