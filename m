From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Convert "sink" to the new infrastructure
Date: Thu, 18 Sep 2008 09:10:20 +0200
Message-ID: <20080918071020.GA12550@diana.vm.bytemark.co.uk>
References: <20080914085118.GC30664@diana.vm.bytemark.co.uk> <b0943d9e0809141419q6facb21at627e658805f1d223@mail.gmail.com> <20080915075740.GB14452@diana.vm.bytemark.co.uk> <b0943d9e0809150944o71acafe7ndeda500b1fba97df@mail.gmail.com> <20080916074024.GA2454@diana.vm.bytemark.co.uk> <b0943d9e0809160759w5c9be510t3b33d5d983bff5a7@mail.gmail.com> <20080916193647.GA12513@diana.vm.bytemark.co.uk> <b0943d9e0809170455m53eaf677t87e9ade3f001d044@mail.gmail.com> <20080917130432.GA26365@diana.vm.bytemark.co.uk> <b0943d9e0809170901o15027408w439af4436cfea67c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 08:49:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDKc-0002oq-UG
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 08:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbYIRGsb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Sep 2008 02:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752640AbYIRGsb
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 02:48:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1819 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbYIRGsa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 02:48:30 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KgDee-0003Ji-00; Thu, 18 Sep 2008 08:10:20 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0809170901o15027408w439af4436cfea67c@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96170>

On 2008-09-17 17:01:22 +0100, Catalin Marinas wrote:

> 2008/9/17 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > Have you tried the benchmarks I committed a while back?
>
> No, I wanted to see how some real patches behave and I'm pretty
> pleased with the result.

In addition to the synthetic patch series you seem to have in mind,
there is also a more than 1000 patches long series from the kernel
history. Try running the setup.sh and take a look (it takes a few
minutes to run, but you'll only have to do it once because the
performance test script is careful not to wreck the repo it works on).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
