From: Patrick Lehner <lehner.patrick@gmx.de>
Subject: Re: `git mv` has ambiguous error message for non-existing target
Date: Mon, 19 Nov 2012 22:07:21 +0100
Message-ID: <50AA9F89.1050401@gmx.de>
References: <50A53A80.4080203@gmx.de> <7vehju8h5j.fsf@alter.siamese.dyndns.org> <50A5E6D2.5060609@gmx.de> <7vpq3cja4y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 22:08:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaYZU-00059t-1x
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 22:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885Ab2KSVHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 16:07:45 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:52792 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750821Ab2KSVHo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 16:07:44 -0500
Received: (qmail invoked by alias); 19 Nov 2012 21:07:23 -0000
Received: from 188-194-118-2-dynip.superkabel.de (EHLO [192.168.1.110]) [188.194.118.2]
  by mail.gmx.net (mp001) with SMTP; 19 Nov 2012 22:07:23 +0100
X-Authenticated: #36416844
X-Provags-ID: V01U2FsdGVkX1+wH0dcJgmwY6imAMqgY1dQJ8rUR5xzfY5Gc0ZXtJ
	fgrdlq9NCz6X0B
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <7vpq3cja4y.fsf@alter.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210054>

On Sa 17 Nov 2012 20:35:09 CET, Junio C Hamano wrote:
> Patrick Lehner <lehner.patrick@gmx.de> writes:
>
>> But just because mv's error essage isnt very good, does that mean git
>> mv's error message mustn't be better?
>
> Did I say the error message from 'mv' was not very good in the
> message you are responding to (by the way, this is why you should
> never top-post when you are responding to a message on this list)?
>
> I meant to say that the message from 'mv' is good enough, so is the
> one given by 'git mv'.
>
> I wouldn't reject a patch that updates our message to something more
> informative without looking at it, though.

I apologize for top-posting -- I don't usually use mailing lists and am 
not aware of the usual netiquette.

And yes, I did interpret a bit more into your reply than was there.

I wouldn't call the 'mv' error message "good enough" in this case, but 
very well, opinions may very well differ. Unfortunately, I have no time 
to get into the git code and contribution guidelines, so I cannot 
submit a patch myself. I would appreciate if someone else who shares my 
sentiment and knows their way around the git source a bit could find 
the time to add this :)

Regards,
Patrick
