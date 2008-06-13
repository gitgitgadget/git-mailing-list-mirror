From: Chris Ridd <chris.ridd@isode.com>
Subject: Re: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 15:10:52 +0100
Message-ID: <48527FEC.8080909@isode.com>
References: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com>
            <6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com>
            <alpine.DEB.1.10.0806130946060.8043@alchemy.localdomain>
            <6dbd4d000806130659r2a8bc57ev6db4ef058ee97440@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7A0L-00008h-HT
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbYFMOKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 10:10:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbYFMOKy
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 10:10:54 -0400
Received: from rufus.isode.com ([62.3.217.251]:40408 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbYFMOKx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 10:10:53 -0400
Received: from [172.16.0.138] (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPSA 
          id <SFJ=7ABZBGe0@rufus.isode.com> for <git@vger.kernel.org>;
          Fri, 13 Jun 2008 15:10:52 +0100
User-Agent: Thunderbird 2.0.0.14 (X11/20080507)
In-Reply-To: <6dbd4d000806130659r2a8bc57ev6db4ef058ee97440@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84878>

Denis Bueno wrote:
> On Fri, Jun 13, 2008 at 09:46, Asheesh Laroia <asheesh@asheesh.org> wrote:
>> Does OS X ship /usr/bin/env?
>>
>> If you type "/usr/bin/env perl" in a Terminal window, do you get Perl?
> 
> Sorry, I should have made that clear earlier: yes.
> 
> funsat[122] > /usr/bin/env perl --version
> 
> This is perl, v5.8.8 built for darwin-2level

MacPorts /tends/ to make ports use stuff from other ports instead of 
using Apple-installed bits. In this case, maybe git from MacPorts is 
using perl from MacPorts?

Cheers,

Chris
