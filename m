From: David Kastrup <dak@gnu.org>
Subject: Re: Data Integrity & un-Commited Branches
Date: Sat, 15 Sep 2007 19:33:00 +0200
Message-ID: <85tzpval6b.fsf@lola.goethe.zz>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com>
	<2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com>
	<7vk5qtd3le.fsf@gitster.siamese.dyndns.org>
	<2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com>
	<20070915025129.GY3099@spearce.org>
	<20070915073845.GB3782@efreet.light.src>
	<20070915075144.GB3099@spearce.org>
	<6bcc356f0709150611i97d31f0yb91016e53c4f5e9f@mail.gmail.com>
	<85myvoav1g.fsf@lola.goethe.zz>
	<6bcc356f0709151014j9606a3ape6b62770304560ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, "Jan Hudec" <bulb@ucw.cz>,
	"Brian Scott Dobrovodsky" <brian@pontech.com>, git@vger.kernel.org
To: "Nikodemus Siivola" <nikodemus@random-state.net>
X-From: git-owner@vger.kernel.org Sat Sep 15 19:33:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWbWR-00083x-I5
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 19:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbXIORdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 13:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755466AbXIORdH
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 13:33:07 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:39145 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755923AbXIORdE (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2007 13:33:04 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 14EAB2CB0E2;
	Sat, 15 Sep 2007 19:33:03 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id 01B87279401;
	Sat, 15 Sep 2007 19:33:03 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-048-000.pools.arcor-ip.net [84.61.48.0])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id B8FEF19B324;
	Sat, 15 Sep 2007 19:33:02 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 59DB11C0024C; Sat, 15 Sep 2007 19:33:00 +0200 (CEST)
In-Reply-To: <6bcc356f0709151014j9606a3ape6b62770304560ba@mail.gmail.com> (Nikodemus Siivola's message of "Sat\, 15 Sep 2007 20\:14\:51 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4281/Sat Sep 15 18:07:24 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58266>

"Nikodemus Siivola" <nikodemus@random-state.net> writes:

> On 9/15/07, David Kastrup <dak@gnu.org> wrote:
>
>> "Take a while"?  What's wrong with git-reflog?
>
> Not needing it as a part of my regular workflow, and therefore
> not thinking about it. *blush*

"Oh no, what have I done now?"

I am afraid that working with git still exposes me to this question
time and again.  And git-reflog usually provides the answer, as well
as what I need to recover.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
