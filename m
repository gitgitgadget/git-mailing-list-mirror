From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Wed, 27 Oct 2010 18:08:54 +0200
Message-ID: <vpqwrp3y5wp.fsf@bauges.imag.fr>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	<AANLkTimkovH9OysLSxA+=di89Xi+dTCYL5hRPmNaADDH@mail.gmail.com>
	<20101019175103.GA28847@kytes> <20101027150314.GB1136@kytes>
	<1288192595.15518.37.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thore Husfeldt <thore.husfeldt@gmail.com>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Oct 27 18:11:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB8aw-0001Xd-Qa
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 18:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761191Ab0J0QLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 12:11:15 -0400
Received: from mx2.imag.fr ([129.88.30.17]:38144 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760956Ab0J0QLK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 12:11:10 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o9RG2RAQ017158
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 27 Oct 2010 18:02:28 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PB8YZ-0007U6-8S; Wed, 27 Oct 2010 18:08:55 +0200
In-Reply-To: <1288192595.15518.37.camel@drew-northup.unet.maine.edu> (Drew Northup's message of "Wed\, 27 Oct 2010 11\:16\:35 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 27 Oct 2010 18:02:28 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9RG2RAQ017158
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288800153.2018@HFy5EI92FzDjUwz3AY6EUg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160094>

Drew Northup <drew.northup@maine.edu> writes:

> Matthieu has been working on a more comprehensive set of documentation
> patches

Right. I had missed your patches and our works overlapped.

> --which I'm pretty sure include all of the changes you just
> mentioned.

Not all:

>> > Subject: [PATCH] Documentation: Consistently use the hyphenated "remote-tracking"

This (and other "synonyms" of remote-tracking) is addressed by my
patch, but

>> > Subject: [PATCH] UI: Don't say "working directory" when we really
>> > mean "working tree"

this isn't.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
