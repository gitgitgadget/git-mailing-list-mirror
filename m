From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: [ANNOUNCE] GIT 1.6.5
Date: Sun, 11 Oct 2009 11:57:53 -0700
Message-ID: <f488382f0910111157s6089cf21y254e0c706b35cd33@mail.gmail.com>
References: <7v8wfi1fya.fsf@alter.siamese.dyndns.org>
	 <f488382f0910110930u1af92299ld5d72dbb31ed1914@mail.gmail.com>
	 <7vfx9pydhk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 11 20:58:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mx3cr-0003e8-JB
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 20:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbZJKS6a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Oct 2009 14:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbZJKS6a
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 14:58:30 -0400
Received: from mail-px0-f179.google.com ([209.85.216.179]:59748 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZJKS63 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Oct 2009 14:58:29 -0400
Received: by pxi9 with SMTP id 9so8067210pxi.4
        for <git@vger.kernel.org>; Sun, 11 Oct 2009 11:57:53 -0700 (PDT)
Received: by 10.142.5.28 with SMTP id 28mr389976wfe.82.1255287473577; Sun, 11 
	Oct 2009 11:57:53 -0700 (PDT)
In-Reply-To: <7vfx9pydhk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129943>

On Sun, Oct 11, 2009 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Steven Noonan <steven@uplinklabs.net> writes:
>
>> Uh-oh.
>>
>> Alcarin:crisscross steven$ git remote update
>> Updating origin
>> fatal: 'git@github.com/tycho/crisscross.git' does not appear to be a
>> git repository
>> fatal: The remote end hung up unexpectedly
>> error: Could not fetch origin
>
> Try user@site:path/to/repo.git with a colon. =A0As you mentioned alre=
ady,
> you could also use ssh://user@site/full/path/to/repo.git

Oops. You're right, of course. I'm going on 4 hours of sleep in 2
days, so needless to say I'm not at my best right now. Sorry for the
noise.

>
>> The 'ssh://' part is omitted in numerous places on github.com. I
>> realize github.com isn't the final authority on the syntax of the UR=
I,
>
> What do you mean by "final authority"?

I didn't want to imply that "github says to do it this way, so git
should follow".
