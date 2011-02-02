From: Pascal Obry <pascal@obry.net>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Wed, 02 Feb 2011 21:01:53 +0100
Organization: Home - http://www.obry.net
Message-ID: <4D49B831.2030007@obry.net>
References: <20110202022909.30644.qmail@science.horizon.com> <AANLkTikBH8Qs3izT86WW7qyJ2etwFFj9GPVJ2QeRCmag@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 02 21:09:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pkj1W-0005dk-W4
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 21:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286Ab1BBUJt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Feb 2011 15:09:49 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:21719 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab1BBUJt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 15:09:49 -0500
X-Greylist: delayed 471 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Feb 2011 15:09:48 EST
Received: from [192.168.0.100] ([82.124.203.119])
	by mwinf5d09 with ME
	id 381t1g00c2b4kYJ0381u89; Wed, 02 Feb 2011 21:01:56 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <AANLkTikBH8Qs3izT86WW7qyJ2etwFFj9GPVJ2QeRCmag@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165932>

Le 02/02/2011 09:31, Erik Faye-Lund a =E9crit :
> On Wed, Feb 2, 2011 at 3:29 AM, George Spelvin <linux@horizon.com> wr=
ote:
>> If there's a compelling reason to change, could someone please descr=
ibe it?
>=20
> I think the most compelling argument I can think of is that it makes
> top-level entries like Documentation, RelNotes, COPYING, README and
> INSTALL easier to spot when doing "ls". For some users (first-time
> hackers etc) that's a pretty big plus, I'd think.

I was about to say that too. That's an argument strong enough I would
say. Today it is hard to see the structure.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
