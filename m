From: Claudio Scordino <cloud.of.andor@gmail.com>
Subject: Re: Hook after pull ?
Date: Wed, 11 Jul 2007 17:29:19 +0200
Message-ID: <4694F74F.8050908@gmail.com>
References: <4694EC0F.10003@gmail.com> <81b0412b0707110751i7947ac5bv819e1c2de4e94621@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 17:29:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8e84-0002Qg-Qn
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 17:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758293AbXGKP3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 11:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758452AbXGKP3W
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 11:29:22 -0400
Received: from ms01.sssup.it ([193.205.80.99]:47080 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757064AbXGKP3V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 11:29:21 -0400
Received: from [193.205.82.7] (HELO gandalf.sssup.it)
  by sssup.it (CommuniGate Pro SMTP 4.1.8)
  with ESMTP-TLS id 31862495; Wed, 11 Jul 2007 17:20:42 +0200
Received: from [10.30.3.110] ([10.30.3.110])
	by gandalf.sssup.it (8.12.10/8.12.10) with ESMTP id l6BEQTqi031089;
	Wed, 11 Jul 2007 16:26:29 +0200
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <81b0412b0707110751i7947ac5bv819e1c2de4e94621@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52170>

Alex Riesen wrote:
> On 7/11/07, Claudio Scordino <cloud.of.andor@gmail.com> wrote:
>> Hi all.
>>
>> Does any hook being called after the pull (that means, after fetch or 
>> merge) ?
>>
> 
> There are some

Which one of those inside the .git/hooks directory is called afret a pull?

> 
>> If no, does exist any easy way of creating such hook ?
>>
> 
> What for? What do you want to do?
> 
I just need my script to be called after a pull. My script just sends an email 
saying that the repository has been pulled (I already did it for the push).

Thanks,

         Claudio
