From: Andreas Ericsson <ae@op5.se>
Subject: Re: git versus CVS (versus bk)
Date: Wed, 02 Nov 2005 09:54:07 +0100
Message-ID: <43687EAF.4060505@op5.se>
References: <200511012356.jA1NuPBd004502@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 02 09:54:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXENq-00028G-5b
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 09:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932663AbVKBIyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 03:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbVKBIyK
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 03:54:10 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:24192 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932663AbVKBIyI
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 2 Nov 2005 03:54:08 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id B216C6BD00
	for <git@vger.kernel.org>; Wed,  2 Nov 2005 09:54:07 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <200511012356.jA1NuPBd004502@inti.inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11012>

Horst von Brand wrote:
> Martin Langhoff <martin.langhoff@gmail.com> wrote:
> 
> [...]
> 
> 
>>In practice, a new developer will often roll up commits to avoid
>>sending a string of shameful patches and corrections on top -- I often
>>do that ;-) . Developers with more "mana" will have published repos
>>where Junio pulls directly from -- and they get merged with full
>>history. Of course -- they don't have brown-paper-bag commits like I
>>do...
> 
> 
> I bet they have a scratchpad on their laptop (full of brown-paper-bag
> commits and backtracking) from which they push into a cleaned up repository
> for public consumption.

I just do a lot of branches.

Incidentally though, is there any way to make a commit completely go 
away without resetting the files?

It'd be a nice feature even if it can only do it from the top down, 
unlike git-revert which can do it anywhere in the middle as well.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
