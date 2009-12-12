From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: FEATURE REQUEST: Announce branch name with merge comamnd
Date: Sat, 12 Dec 2009 10:35:40 +0200
Organization: Private
Message-ID: <87tyvwpp2b.fsf@jondo.cante.net>
References: <87zl5p1gsp.fsf@jondo.cante.net>
	<81b0412b0912111735v474a9d3k5a24024c2d51587b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 09:36:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJNSJ-0002ZM-Uf
	for gcvg-git-2@lo.gmane.org; Sat, 12 Dec 2009 09:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754088AbZLLIfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Dec 2009 03:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbZLLIfi
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 03:35:38 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:50926 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbZLLIfi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Dec 2009 03:35:38 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 94A82C7B5C;
	Sat, 12 Dec 2009 10:35:43 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A02175913AC; Sat, 12 Dec 2009 10:35:43 +0200
Received: from jondo.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 2851241BE5;
	Sat, 12 Dec 2009 10:35:40 +0200 (EET)
In-Reply-To: <81b0412b0912111735v474a9d3k5a24024c2d51587b@mail.gmail.com>
	(Alex Riesen's message of "Sat, 12 Dec 2009 02:35:49 +0100")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.1 (gnu/linux)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135124>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Fri, Dec 11, 2009 at 19:55, Jari Aalto <jari.aalto@cante.net> wrot=
e:
>
>> Please announce the branch name being merged so that the listing is
>> easier to follow (possibly only with --verbose, -v option). Add
>> "Branch: <name>" just before the merge is attempted. somethiglike th=
is
>>
>> =C2=A0 =C2=A0Branch: bug--manpage-fix-hyphen
>> =C2=A0 =C2=A0Trying simple merge with c87c49b1e413e5dc378d7e6b169517=
61a1e82f6d
>
> It is not exactly "easier" to follow in your case. It is more
> text and there is no immediately visible cue that the two
> lines are related. You have to give the observer this information.
> Put reference name and SHA-1 on the same line?

That would work too. As long as the branch name appears there
(optionally only with -v in effect).

Jari
