From: Nicolas Morey-Chaisemartin <devel@morey-chaisemartin.com>
Subject: Re: French git user
Date: Wed, 26 Nov 2008 10:31:37 +0100
Message-ID: <492D1779.8040807@morey-chaisemartin.com>
References: <492B9985.10103@morey-chaisemartin.com> <492C2F2E.2050200@morey-chaisemartin.com> <492D0295.6060808@morey-chaisemartin.com> <200811260955.57421.johan@herland.net>
Reply-To: devel@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 10:36:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5Gob-00065T-1n
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 10:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbYKZJex convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 04:34:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbYKZJex
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 04:34:53 -0500
Received: from 42.mail-out.ovh.net ([213.251.189.42]:56324 "HELO
	42.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750916AbYKZJew (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 04:34:52 -0500
Received: (qmail 4324 invoked by uid 503); 26 Nov 2008 09:34:31 -0000
Received: from b6.ovh.net (HELO mail240.ha.ovh.net) (213.186.33.56)
  by 42.mail-out.ovh.net with SMTP; 26 Nov 2008 09:34:31 -0000
Received: from b0.ovh.net (HELO queue-out) (213.186.33.50)
	by b0.ovh.net with SMTP; 26 Nov 2008 09:34:49 -0000
Received: from ensilinx1.imag.fr (HELO ?0.0.0.0?) (devel@morey-chaisemartin.com@195.221.227.189)
  by ns0.ovh.net with SMTP; 26 Nov 2008 09:34:48 -0000
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <200811260955.57421.johan@herland.net>
X-Enigmail-Version: 0.95.7
X-Ovh-Tracer-Id: 1745144857116003940
X-Ovh-Remote: 195.221.227.189 (ensilinx1.imag.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|H 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101715>

Johan Herland a =E9crit :
> On Wednesday 26 November 2008, Nicolas Morey-Chaisemartin wrote:
>  =20
>> I've been allowed to share my presentation:
>> http://nicolas.morey-chaisemartin.com/git_tuto.pdf
>>
>> Please send me any feedback, I'm always glad to imrpove my work.
>>    =20
>
> I have no knowledge of French, but on page 15 the command
> "git-commit --append" is mentioned. There is no "--append"
> option. I'm guessing the "--amend" option is meant instead.
>
> Also, the very next command is "git-revert COMIT_ID".
> "COMIT_ID" should probably have an extra "M".
>
> Finally, on page 11, you say something about "git foo" vs.
> "git-foo" (hopefully that the "git-foo" form is deprecated),
> but in the rest of the presentation you use a mix of "git foo"
> and "git-foo" (mostly "git-foo"). This seems inconsistent.
>
>
> Have fun! :)
>
> ...Johan
>
>  =20


Thanks, good catch.
Yes I say in french that git-foo is deprecated.
However I'm still using it in the following slides because people have
directly the good command to look at the man.
I know it's not really consistent but asI'd rahter keep it that way and
insist while presenting it, it should only be used for man pages.

I added your vchanged and updated the pdf.

Thanks

Nicolas
