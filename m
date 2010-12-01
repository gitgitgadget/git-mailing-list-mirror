From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-add.txt: Order options alphabetically
Date: Thu, 02 Dec 2010 00:28:06 +0200
Organization: Private
Message-ID: <8739qhuo09.fsf@picasso.cante.net>
References: <1291218145-13016-1-git-send-email-jari.aalto@cante.net>
	<1291229622.11917.14.camel@drew-northup.unet.maine.edu>
	<87bp55uw96.fsf@picasso.cante.net>
	<1291232706.11917.35.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 23:28:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNvA1-0007Gx-8d
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 23:28:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab0LAW2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 17:28:20 -0500
Received: from lo.gmane.org ([80.91.229.12]:37545 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab0LAW2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 17:28:19 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PNv9u-0007DM-0k
	for git@vger.kernel.org; Wed, 01 Dec 2010 23:28:18 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 23:28:18 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 23:28:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:miI8fhV83mnozRcnnR4+1pBRwy4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162624>

2010-12-01 21:45 Drew Northup <drew.northup@maine.edu>:
> On Wed, 2010-12-01 at 21:29 +0200, Jari Aalto wrote:
>
>> 2010-12-01 20:53 Drew Northup <drew.northup@maine.edu>:
>> > (lacking a commit message to tell me), WHY? [alphabetical]
>> 
>> Quoting <http://permalink.gmane.org/gmane.comp.version-control.git/162552>
>> 
>>     - You read from top to bottom, therefore A-Z.
>>     - GNU project uses it in manual pages. It looks good, it looks
>>       professional, it looks clean. And it works when searching (= no
>>       oriantation problems regardless of tools; even when you print on
>>       paper when you don't have any computerized aids to help your search.).
>> 
>> Jari
>
> THAT belongs in a commit message!!!

It does not. No need to clutter 10's of message that long in there..

> As an aside, you haven't looked at the sed and gawk manpages, have you?

There are plenty of pages that are bad examples. Let's make ours better.

Jari
