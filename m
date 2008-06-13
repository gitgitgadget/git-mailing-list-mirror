From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: git-instaweb portability issue (maybe?)
Date: Fri, 13 Jun 2008 10:16:36 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0806131016120.8043@alchemy.localdomain>
References: <6dbd4d000806130626pfdb06f2qbfea6f1909710b7b@mail.gmail.com>            <6dbd4d000806130638k4461a41eo8ce6fe803505fa88@mail.gmail.com>            <alpine.DEB.1.10.0806130946060.8043@alchemy.localdomain>            <6dbd4d000806130659r2a8bc57ev6db4ef058ee97440@mail.gmail.com>
 <48527FEC.8080909@isode.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 16:18:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7A5y-0002UN-M5
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 16:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755430AbYFMOQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 10:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755022AbYFMOQm
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 10:16:42 -0400
Received: from wide-rose.makesad.us ([203.178.130.147]:44514 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753016AbYFMOQm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 10:16:42 -0400
Received: from alchemy (localhost [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTP id 8F19BA0127
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 10:18:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by alchemy (Postfix) with ESMTPS id 72F7B6CCD3
	for <git@vger.kernel.org>; Fri, 13 Jun 2008 07:16:36 -0700 (PDT)
X-X-Sender: paulproteus@alchemy.localdomain
In-Reply-To: <48527FEC.8080909@isode.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-OpenPGP-Key-ID: 0x70096AD1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84879>

On Fri, 13 Jun 2008, Chris Ridd wrote:

> Denis Bueno wrote:
>> On Fri, Jun 13, 2008 at 09:46, Asheesh Laroia <asheesh@asheesh.org> wrote:
>>> Does OS X ship /usr/bin/env?
>>> 
>>> If you type "/usr/bin/env perl" in a Terminal window, do you get Perl?
>> 
>> Sorry, I should have made that clear earlier: yes.
>> 
>> funsat[122] > /usr/bin/env perl --version
>> 
>> This is perl, v5.8.8 built for darwin-2level
>
> MacPorts /tends/ to make ports use stuff from other ports instead of using 
> Apple-installed bits. In this case, maybe git from MacPorts is using perl 
> from MacPorts?

FWIW, the problem seems to be that it's not finding *any* Perl.

-- Asheesh.

-- 
A can of ASPARAGUS, 73 pigeons, some LIVE ammo, and a FROZEN DAQUIRI!!
