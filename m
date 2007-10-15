From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Mon, 15 Oct 2007 22:47:48 +0200
Message-ID: <85ve98gl57.fsf@lola.goethe.zz>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
	<471302D2.6010405@trolltech.com>
	<ee77f5c20710142315j192b9f65m22d7980769a46cec@mail.gmail.com>
	<200710150902.52653.johan@herland.net>
	<7EDF99A4-00BD-4F89-A31F-DCA33723CDD5@wincent.com>
	<ee77f5c20710150453g1220d968k9a23f2b8329a67db@mail.gmail.com>
	<0C82FD96-2CF9-4E66-91EB-DBC2CFF003E8@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Symonds <dsymonds@gmail.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Christian Couder" <chriscool@tuxfamily.org>,
	=?iso-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	"Junio Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Oct 16 07:55:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhfOw-0007jQ-J9
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 07:55:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760074AbXJPFzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 01:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759184AbXJPFzY
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 01:55:24 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:56617 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758779AbXJPFzX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 01:55:23 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IhfOg-0006AX-E4; Tue, 16 Oct 2007 01:55:18 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E4F7A1C4D4B3; Mon, 15 Oct 2007 22:47:48 +0200 (CEST)
In-Reply-To: <0C82FD96-2CF9-4E66-91EB-DBC2CFF003E8@adacore.com> (Geert Bosch's message of "Mon\, 15 Oct 2007 22\:33\:47 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61080>

Geert Bosch <bosch@adacore.com> writes:

> On Oct 15, 2007, at 13:53, David Symonds wrote:
>> That's also why I suggested "skip"; you might not be able to test a
>> particular commit, but you might also not *want* to test a particular
>> commit for some reason.
>
> Skip seems a great choice: it directly expresses the wish to
> not consider a certain commit. The reason is unimportant.

But it is an _action_, while "good" and "bad" are properties.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
