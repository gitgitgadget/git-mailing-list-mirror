From: Bill Lear <rael@zopyra.com>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 13:54:22 -0600
Message-ID: <17855.41582.273304.760413@lisa.zopyra.com>
References: <17855.35058.967318.546726@lisa.zopyra.com>
	<17855.36470.309129.391271@lisa.zopyra.com>
	<Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
	<200701301950.00195.jnareb@gmail.com>
	<Pine.LNX.4.64.0701301058250.3611@woody.linux-foundation.org>
	<17855.39008.920685.62837@lisa.zopyra.com>
	<Pine.LNX.4.63.0701302013420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<17855.40530.256749.539318@lisa.zopyra.com>
	<17855.40922.849939.976654@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 20:54:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBz3k-0000r1-56
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 20:54:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbXA3TyY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 14:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbXA3TyY
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 14:54:24 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60309 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbXA3TyX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 14:54:23 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l0UJsM604968;
	Tue, 30 Jan 2007 13:54:22 -0600
In-Reply-To: <17855.40922.849939.976654@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38199>

On Tuesday, January 30, 2007 at 13:43:22 (-0600) Bill Lear writes:
>On Tuesday, January 30, 2007 at 13:36:50 (-0600) Bill Lear writes:
>>On Tuesday, January 30, 2007 at 20:15:37 (+0100) Johannes Schindelin writes:
>>>On Tue, 30 Jan 2007, Bill Lear wrote:
>>>> On Tuesday, January 30, 2007 at 11:04:57 (-0800) Linus Torvalds writes:
>>>> 
>>>> >Anyway, it's certainly easy to fix. Bill, you can either:
>>>> >
>>>> > - just rename the "topic" branch to "master"
>>>> 
>>>> I don't think I want this.  I want to know I'm on the topic branch of 
>>>> that repo, anything else really makes me nervous.
>>>
>>>The name in the bare repository does not matter as much as your _local_ 
>>>name.
>>
>>Well, being a git newbie, it kinda matters to me.  I need linearity
>>right now.  Anything that swerves is likely to result in me and my
>>project stuck in the weeds.
>>
>>So, I tried a straight fetch:
>>
>>% GIT_DIR=. git fetch git://source/public/project
>>
>>This has one branch:
>>
>>% GIT_DIR=. git branch
>>  topic
>
>Ummm, I may have made a mistake here ... doing again to ensure I did
>not mis-type above ...

Ok, I hate twice quoting my self, especially to admit to crack smoking.
I was indeed apparently smoking crack --- no such branch shows up...


Bill
