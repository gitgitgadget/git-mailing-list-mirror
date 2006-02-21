From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/2] Add 'stg uncommit' command
Date: Tue, 21 Feb 2006 08:55:39 +0100
Message-ID: <20060221075539.GA5889@diana.vm.bytemark.co.uk>
References: <20060217042728.14175.39928.stgit@backpacker.hemma.treskal.com> <20060217043128.14175.60168.stgit@backpacker.hemma.treskal.com> <43F84D9A.2010905@gmail.com> <20060219134558.GA4784@diana.vm.bytemark.co.uk> <20060219144752.GA5541@diana.vm.bytemark.co.uk> <b0943d9e0602200920v10ef8788o@mail.gmail.com> <20060220173048.GC23501@diana.vm.bytemark.co.uk> <b0943d9e0602201449j15541f8aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 08:55:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBSN7-0003io-Cz
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 08:55:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbWBUHzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Feb 2006 02:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbWBUHzm
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 02:55:42 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:37901 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751132AbWBUHzm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 02:55:42 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FBSN1-0001Ye-00; Tue, 21 Feb 2006 07:55:39 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <b0943d9e0602201449j15541f8aw@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16523>

On 2006-02-20 22:49:22 +0000, Catalin Marinas wrote:

> On 20/02/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > It put curly braces around the name as well.
>
> It wasn't StGIT. Running "git log" on my machine only shows \'s and
> some weird characters.

Those weird characters are the two bytes that make up the character
"=F6" (o with two dots on top of it) in utf8. That's what the utf8
variant of my name looks like when displayed in latin1. :-/

> Maybe it's your terminal showing braces.

You're right, they don't show when I use git-log, so I guess they
aren't really there after all. But they do show up in gitk.

Hopefully all this weirdness will go away with the backslashes. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
