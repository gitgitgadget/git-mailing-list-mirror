From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Tue, 16 Oct 2007 08:17:16 +0200
Message-ID: <856417h9cj.fsf@lola.goethe.zz>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
	<471302D2.6010405@trolltech.com>
	<ee77f5c20710142315j192b9f65m22d7980769a46cec@mail.gmail.com>
	<200710150902.52653.johan@herland.net>
	<7EDF99A4-00BD-4F89-A31F-DCA33723CDD5@wincent.com>
	<ee77f5c20710150453g1220d968k9a23f2b8329a67db@mail.gmail.com>
	<0C82FD96-2CF9-4E66-91EB-DBC2CFF003E8@adacore.com>
	<85ve98gl57.fsf@lola.goethe.zz>
	<ee77f5c20710152307n48431a6eu5dc95ee504968e4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Geert Bosch" <bosch@adacore.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	=?iso-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	"Junio Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "David Symonds" <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:16:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhfjI-000227-B9
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbXJPGQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 02:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbXJPGQW
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:16:22 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:38610 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbXJPGQW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 02:16:22 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1Ihfj2-0007WQ-8T; Tue, 16 Oct 2007 02:16:20 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A1ED91C4D4B3; Tue, 16 Oct 2007 08:17:16 +0200 (CEST)
In-Reply-To: <ee77f5c20710152307n48431a6eu5dc95ee504968e4e@mail.gmail.com> (David Symonds's message of "Tue\, 16 Oct 2007 16\:07\:58 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61089>

"David Symonds" <dsymonds@gmail.com> writes:

> On 16/10/2007, David Kastrup <dak@gnu.org> wrote:
>> Geert Bosch <bosch@adacore.com> writes:
>>
>> > On Oct 15, 2007, at 13:53, David Symonds wrote:
>> >> That's also why I suggested "skip"; you might not be able to test a
>> >> particular commit, but you might also not *want* to test a particular
>> >> commit for some reason.
>> >
>> > Skip seems a great choice: it directly expresses the wish to
>> > not consider a certain commit. The reason is unimportant.
>>
>> But it is an _action_, while "good" and "bad" are properties.
>
> "skipped", then.

"good" and "bad" are descriptive.  "to be skipped" would be necessary
to fit it.

> Either way, something like this has got to be much better than
> "dunno".

"undecided" still has my vote, and I could live with "unknown".
Everything that has been proposed since then is, in my opinion,
strictly worse.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
