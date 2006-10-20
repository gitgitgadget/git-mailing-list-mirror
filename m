From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 14:34:32 +0200
Message-ID: <vpqslhjyxlz.fsf@ecrins.imag.fr>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<45357411.20500@utoronto.ca> <200610180246.18758.jnareb@gmail.com>
	<45357CC3.4040507@utoronto.ca>
	<Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
	<4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org>
	<453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org>
	<453803E6.2060309@utoronto.ca> <eha9rq$5t7$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 14:35:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gatan-0007aP-5s
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 14:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbWJTMfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 08:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbWJTMfN
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 08:35:13 -0400
Received: from imag.imag.fr ([129.88.30.1]:41123 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1751671AbWJTMfL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 08:35:11 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.6/8.13.6) with ESMTP id k9KCYXPT002531
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 20 Oct 2006 14:34:33 +0200 (CEST)
Received: from ecrins.imag.fr ([129.88.43.124])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Gata4-0000LZ-5V; Fri, 20 Oct 2006 14:34:32 +0200
Received: from moy by ecrins.imag.fr with local (Exim 4.50)
	id 1Gata4-00048a-20; Fri, 20 Oct 2006 14:34:32 +0200
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eha9rq$5t7$2@sea.gmane.org> (Jakub Narebski's message of "Fri\, 20 Oct 2006 12\:53\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Fri, 20 Oct 2006 14:34:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29458>

Jakub Narebski <jnareb@gmail.com> writes:

>> If you're interested, it's called "Bugs Everywhere" and it's available here:
>> http://panoramicfeedback.com/opensource/
>> 
>> New VCS backends are welcome :-D
>
> While SCM can (and should be usually) distributed, I think that bugtracker
> has to be centralized.

Well, indeed, I think bug _reporting_ should be somehow centralized,
while bug _fixing_ can be decentralized: You fix a bug, you mark it as
fixed, and then the main branch gets the information that the bug is
fixed when the bugfix is merged.

-- 
Matthieu
