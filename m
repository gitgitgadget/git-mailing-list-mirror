From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Sat, 08 Sep 2007 08:24:24 +0200
Message-ID: <858x7h1xpj.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<Pine.LNX.4.64.0709071119510.28586@racer.site>
	<a1bbc6950709071732s1f15e5ev28bdfc5c1ab5877b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 08 08:24:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITtkI-0007jM-Fb
	for gcvg-git@gmane.org; Sat, 08 Sep 2007 08:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbXIHGYg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 02:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbXIHGYf
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 02:24:35 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:44000 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751107AbXIHGYf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Sep 2007 02:24:35 -0400
Received: from mail-in-06-z2.arcor-online.net (mail-in-06-z2.arcor-online.net [151.189.8.18])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id BDB281F52F4;
	Sat,  8 Sep 2007 08:24:33 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-06-z2.arcor-online.net (Postfix) with ESMTP id AA0F65BF34;
	Sat,  8 Sep 2007 08:24:33 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-010.pools.arcor-ip.net [84.61.13.10])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 809F234A618;
	Sat,  8 Sep 2007 08:24:29 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 3921A1CAD71D; Sat,  8 Sep 2007 08:24:25 +0200 (CEST)
In-Reply-To: <a1bbc6950709071732s1f15e5ev28bdfc5c1ab5877b@mail.gmail.com> (Dmitry Kakurin's message of "Fri\, 7 Sep 2007 17\:32\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4194/Sat Sep  8 06:33:29 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58103>

"Dmitry Kakurin" <dmitry.kakurin@gmail.com> writes:

> On 9/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
>> No, it's not.  As has been shown by some very good _arguments_.
>> Once you have facts to back up your claims, it is not any belief
>> any longer.
>
> Well I've heard *opinions* and anecdotal evidence. No facts though.

Anecdotal evidence _is_ hard facts.  That's what experience is all
about.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
