From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: [msysGit] Re: Need your help with MinGW Issue 17: --color options
 don't work (produce garbage)
Date: Tue, 21 Aug 2007 16:08:27 +0200
Message-ID: <46CAF1DB.3080305@dawes.za.net>
References: <a1bbc6950708142329w4e0e3d7cq573c67dd3b28f03a@mail.gmail.com>	<3f4fd2640708150032l7441b285mc2cc9e22702bce21@mail.gmail.com>	<Pine.LNX.4.64.0708151708570.19222@wbgn129.biozentrum.uni-wuerzburg.de>	<46C36E7C.1080501@dawes.za.net> <7vsl6ko51b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Reece Dunn <msclrhd@googlemail.com>,
	msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 16:09:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INUQF-0001fx-Br
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 16:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760340AbXHUOJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 10:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760253AbXHUOJX
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 10:09:23 -0400
Received: from sd-green-bigip-145.dreamhost.com ([208.97.132.145]:47564 "EHLO
	spunkymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760340AbXHUOJW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2007 10:09:22 -0400
Received: from [192.168.201.100] (dsl-146-25-160.telkomadsl.co.za [165.146.25.160])
	by spunkymail-a1.g.dreamhost.com (Postfix) with ESMTP id 2864AFFDD8;
	Tue, 21 Aug 2007 07:09:01 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vsl6ko51b.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56296>

Junio C Hamano wrote:
> Rogan Dawes <lists@dawes.za.net> writes:
> 
>> Users that *do* need to use rxvt or SSH should simply disable the
>> color mode, or alternatively, use the cygwin version. Color, while
>> useful, is hardly critical functionality.
> 
> Heh, that almost suggests that the native Windows command.com
> support can disable the color without upsetting anybody ;-)
> 

Following my other comment in this regard, another reason that colour in 
the cmd line tools is less important, is because my impression of the 
intent of the Windows port (end goal, that is), is that the user will be 
able to use a Windows GUI front-end to do whatever it is they want to.

And so the GUI front-end will be responsible for implementing the color 
anyway, most likely through pattern matching and a state machine.

Regards,

Rogan
