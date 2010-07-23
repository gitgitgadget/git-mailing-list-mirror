From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Avery Pennarun's git-subtree?
Date: Fri, 23 Jul 2010 17:11:06 +0200
Message-ID: <4C49B10A.8060900@web.de>
References: <4C472B48.8050101@gmail.com> <AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com> 	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com> 	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com> 	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com> 	<4C4778DE.9090905@web.de> <AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> 	<m31vavn8la.fsf@localhost.localdomain> <AANLkTimOb2VjYI21wQsC64lm4HsVPwpRWd1twIUBnbJ3@mail.gmail.com> 	<20100723083149.GD27082@arachsys.com> <AANLkTinBtXmMei2Q6MZrXWxa3t+_quGdzpcq46EZvgvG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Webb <chris@arachsys.com>, Jakub Narebski <jnareb@gmail.com>,
	?var Arnfj?r? Bjarmason <avarab@gmail.com>,
	Bryan Larsen <bryan.larsen@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 17:12:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcJuz-0002Ts-4V
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 17:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760396Ab0GWPLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 11:11:49 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:46184 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758601Ab0GWPLr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 11:11:47 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id DDE2316CAA338;
	Fri, 23 Jul 2010 17:11:46 +0200 (CEST)
Received: from [80.128.110.50] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OcJtz-0007xI-00; Fri, 23 Jul 2010 17:11:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <AANLkTinBtXmMei2Q6MZrXWxa3t+_quGdzpcq46EZvgvG@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+ULsaotl+IkjeIAW+iKjz0RKElV1fdPFShKr+P
	3w8RgMf0qr4Ms54549rH5FXKbRVkS83r3cd5vwmja7710P9LcG
	w3igLBSUcqEC/H4NpNKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151540>

Am 23.07.2010 10:40, schrieb Avery Pennarun:
> I think it would be better if we could abandon .gitmodules entirely;
> it's really only useful for listing repository URLs, and listing
> repository URLs is a major part of the problem.

Then where do you get the URL to clone the submodule from on "git
clone --recursive"?
