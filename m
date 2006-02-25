From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitview: Use monospace font to draw the branch and tag name
Date: Fri, 24 Feb 2006 22:05:00 -0800
Message-ID: <7vzmkg6kj7.fsf@assigned-by-dhcp.cox.net>
References: <43FC8BF2.60205@gmail.com>
	<7vr75tc8gj.fsf@assigned-by-dhcp.cox.net>
	<cc723f590602240829y3ebffaf9mdd7de0cd2a9051e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 07:05:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCsYL-0004dL-Qu
	for gcvg-git@gmane.org; Sat, 25 Feb 2006 07:05:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbWBYGFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Feb 2006 01:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932684AbWBYGFH
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Feb 2006 01:05:07 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:57238 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932656AbWBYGFF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2006 01:05:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060225060208.OSUT26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Feb 2006 01:02:08 -0500
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16757>

"Aneesh Kumar" <aneesh.kumar@gmail.com> writes:

> On 2/24/06, Junio C Hamano <junkio@cox.net> wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> writes:
>>
>> > This patch address the below:
>> > Use monospace font to draw branch and tag name
>> > set the font size to 13.
>>
>> I have an impression that hardcoding UI policy like this is
>> generally frowned upon.
>
> But with that changes branch and the tag name looks neat.

The point being that it only looks neat on your display, with
its size and resolution, and to your eye.

People have different tastes and equipments.  One thing I really
liked gitk (I do not know if gitview does this as well -- if so
I am happy) is I can do - and + to change the text size
depending on what display I am working on.
