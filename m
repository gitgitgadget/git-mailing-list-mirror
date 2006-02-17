From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Handle branch names with slashes
Date: Fri, 17 Feb 2006 10:53:23 +0100
Message-ID: <20060217095323.GA1188@diana.vm.bytemark.co.uk>
References: <20060214173509.GA8666@diana.vm.bytemark.co.uk> <20060217014117.12525.21330.stgit@backpacker.hemma.treskal.com> <tnxbqx6z592.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 17 10:53:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FA2Ir-0005ve-N7
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 10:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWBQJx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 17 Feb 2006 04:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWBQJx1
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 04:53:27 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1809 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932594AbWBQJx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 04:53:26 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1FA2Im-0000Ki-00; Fri, 17 Feb 2006 09:53:24 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <tnxbqx6z592.fsf@arm.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16334>

On 2006-02-17 09:47:21 +0000, Catalin Marinas wrote:

> Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > Let StGIT grok branch names with slashes in them. It used to fall
> > flat on its face when confronted with them.
>
> Thanks for the patches you sent. I'll have a look at them tomorrow.
>
> As a side note, for future patches, could you please use my
> catalin.marinas@gmail.com address instead of the company one? I
> maintain StGIT outside the working hours and it's much easier to
> grab them from my personal address.

Ah, I hadn't realized you were using more than one address. Will do.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
