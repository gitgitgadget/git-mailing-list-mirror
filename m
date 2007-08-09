From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: 'pu' branch for StGIT
Date: Thu, 9 Aug 2007 09:38:01 +0200
Message-ID: <20070809073801.GA31482@diana.vm.bytemark.co.uk>
References: <20070807022043.GA8482@diana.vm.bytemark.co.uk> <1186549433.2112.34.camel@dv> <20070808092027.GB7860@diana.vm.bytemark.co.uk> <20070808213917.GA22521@diana.vm.bytemark.co.uk> <1186611514.7383.4.camel@dv> <20070808232349.GA23172@diana.vm.bytemark.co.uk> <20070808201003.nm90u2s5ny888wcc@webmailbeta.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>,
	Yann Dirson <ydirson@altern.org>
To: Pavel Roskin <proski@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 09:38:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ2b2-0007gV-Ot
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 09:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765561AbXHIHiO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 03:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764955AbXHIHiN
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 03:38:13 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3068 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762289AbXHIHiN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 03:38:13 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IJ2an-0008DK-00; Thu, 09 Aug 2007 08:38:01 +0100
Content-Disposition: inline
In-Reply-To: <20070808201003.nm90u2s5ny888wcc@webmailbeta.spamcop.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55423>

On 2007-08-08 20:10:03 -0400, Pavel Roskin wrote:

> Quoting Karl Hasselstr=F6m <kha@treskal.com>:
>
> > It was all due to a sloppy regexp. This is the fix:
>
> Thank you!

You did all the work on this one.

> And by the way, please fix the description of the commit where you
> added --smtp-server option. You added it to "stg mail", not to "stg
> add".

Mmm, thanks. Will fix tonight.

I take it this all means you're actually using my branch? What's your
opinion on its usefulness?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
