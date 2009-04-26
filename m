From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: Google Code: Support for Mercurial and Analysis of Git and 
	Mercurial
Date: Sun, 26 Apr 2009 10:51:02 +0030
Message-ID: <4d8e3fd30904260321u46a4b177xe7c96c13836f3490@mail.gmail.com>
References: <200904260703.31243.chriscool@tuxfamily.org>
	 <m363grq13i.fsf@localhost.localdomain>
	 <4d8e3fd30904260123r35b6a348uab3ad22fde9daa3f@mail.gmail.com>
	 <alpine.DEB.1.00.0904261206170.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Apr 26 13:09:39 2009
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly1VO-0003G1-HQ
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 12:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752029AbZDZKVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 06:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbZDZKVE
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 06:21:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:62375 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbZDZKVD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 06:21:03 -0400
Received: by fg-out-1718.google.com with SMTP id 16so409310fgg.17
        for <git@vger.kernel.org>; Sun, 26 Apr 2009 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gKsDa05GGeHvcZW/BP+yi0+QiyhJzEKEfvfZ+v1kLN0=;
        b=hfDoWN8oaibLEfYHVSOV9jNCSSViwGyvuWuH3/hE+A3YJieYTuytLlT19a0R1hZMMg
         m45fwITDoFPRN6R0CxH/qqSmgSY75GfKi276ILvf3BZOPeQNJ/Y4nXgcCpJ/h1cF1Xgo
         e7iyI4VWsV3spNzUiKxQjJHunTuR4H9uEoISw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MVUkJCuoJyvlZ5zE2rSJfG7GcbEWufrwar/xxk6WIYWuO6+0P1htdMls81L5OxzEHM
         lgcEuRkIWd1vKgjP0z8IDih9nFoL/ZSYKNwL5D3SQzfxzQzs64dIa7ZFBbchRtzXjnOA
         TaCIMKgpZHzUYcO+FfUCQ88LM6+JzG+IXXyp8=
Received: by 10.86.74.4 with SMTP id w4mr2253956fga.60.1240741262518; Sun, 26 
	Apr 2009 03:21:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904261206170.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117585>

On 4/26/09, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 26 Apr 2009, Paolo Ciarrocchi wrote:
>
>> On 4/26/09, Jakub Narebski <jnareb@gmail.com> wrote:
>>
>> > The deciding feature (well, one of deciding features) was the fact
>> > that Mercurial has better HTTP support... I guess (it was not obvious
>> > from the analysis, but it was hinted at) that Mercurial uses its
>> > custom protocol over HTTP, as opposed to "dumb" HTTP protocol support
>> > in Git.
>> >
>> > Perhaps it is time to restart work on _"smart" HTTP protocol_?
>> >
>>
>>
>> wasn't Shawn working on it?
>
> GIVE HIM A BREAK!

it was just a question.

> Isn't Shawn doing enough for Git?  No need to offload the stuff on him
> _that you could very well tackle yourself_.


shawn is a stellar developer and with my message i didn't want to
imply that he should do more than what is already doing.
It was just a question to better understand the issue.

ciao.
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
http://mypage.vodafone.it/
