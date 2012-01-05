From: greened@obbligato.org (David A. Greene)
Subject: Re: git-subtree
Date: Thu, 05 Jan 2012 10:33:20 -0600
Message-ID: <87sjjuyur3.fsf@smith.obbligato.org>
References: <nngaa638nwf.fsf@transit.us.cray.com>
	<CALkWK0nU9iO_6CCbWw8c_Fz=xodkaAW4300Jpc7M7D+kBP=QRg@mail.gmail.com>
	<87ipkq199w.fsf@smith.obbligato.org>
	<CALkWK0k+AwCsizZFwbKKxuz0B4xLoyC4hAy3WRD=sLCq-HvvCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Greene <dag@cray.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 23:24:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rivjj-00020j-Rp
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 23:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837Ab2AEWY3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 17:24:29 -0500
Received: from dsl001-154-008.msp1.dsl.speakeasy.net ([72.1.154.8]:45713 "EHLO
	smith.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932905Ab2AEWY2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 17:24:28 -0500
Received: from greened by smith.obbligato.org with local (Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1RiqFl-0000P8-4K; Thu, 05 Jan 2012 10:33:21 -0600
In-Reply-To: <CALkWK0k+AwCsizZFwbKKxuz0B4xLoyC4hAy3WRD=sLCq-HvvCw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 5 Jan 2012 21:02:16 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188003>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Hi again,
>
> [+CC: Junio Hamano, our maintainer]
>
> David A. Greene wrote:
>> I've read that document. =C2=A0The issue is that I didn't develop th=
e code,
>> Avery did.
>
> Not an issue as long as you have Avery's signoff.

As in a signed-off-by log entry on the commit?  I did a commit -s to ad=
d
my own signed-off-by tag and added a "From:" line in accordance with th=
e
SubmittingPatches document:

  "If you are forwarding a patch from somebody else, optionally, at the
   beginning of the e-mail message just before the commit message start=
s,
   you can put a "From: " line to name that person."

I have not used signoffs before in my day-to-day git flow.  How do I go
about getting one from Avery and incorporating it into the history in a=
n
autheticated way?  I'm assuming you don't want me to forge his sign-off=
=2E
:)

>>=C2=A0It's a lot of time to learn a
>> completely new codebase. =C2=A0I was hoping to submit something soon=
 and then
>> learn the codebase gradually during maintenance/further development.
>
> We certainly don't want badly reviewed code that nobody understands
> floating around in the codebase-=20

Certainly, I'm not trying to avoid review, just trying to figure out th=
e
most efficient mechanics.

> so, I'd suggest sending out whatever you think is appropriate for the
> first round of reviews, and see how things shape up from there.

=46air enough.  I think I will take Jeff's suggested route and see wher=
e
that goes.

>> How have completely new tools be introduced into the git mainline in=
 the
>> past?
>
> Yes.  For an example of something I was involved with but didn't
> author, see vcs-svn/.

Ok, I'll look into that.  Thanks for the pointer.

                             -Dave
