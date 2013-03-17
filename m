From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 0/3] fix unparsed object access in upload-pack
Date: Sun, 17 Mar 2013 17:38:59 +0100
Message-ID: <5145F1A3.1030906@lsrfire.ath.cx>
References: <20130316102428.GA29358@sigill.intra.peff.net> <7v7gl6txl3.fsf@alter.siamese.dyndns.org> <20130317054039.GA16070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 17 17:39:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHGcQ-0003xj-BS
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 17:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756252Ab3CQQjH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 12:39:07 -0400
Received: from india601.server4you.de ([85.25.151.105]:49490 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756307Ab3CQQjE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 12:39:04 -0400
Received: from [192.168.2.105] (p4FFD98FC.dip.t-dialin.net [79.253.152.252])
	by india601.server4you.de (Postfix) with ESMTPSA id 5468620A;
	Sun, 17 Mar 2013 17:39:02 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130317054039.GA16070@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218366>

Am 17.03.2013 06:40, schrieb Jeff King:
> We do have the capability to roll out to one or a few of our servers
> (the granularity is not 0.2%, but it is still small). I'm going to tr=
y
> to keep us more in sync with upstream git, but I don't know if I will
> get to the point of ever deploying "master" or "next", even for a sma=
ll
> portion of the population. We are accumulating more hacks[1] on top o=
f
> git, so it is not just "run master for an hour on this server"; I hav=
e
> to actually merge our fork.

Did you perhaps intend to list these hacks in a footnote or link to a=20
repository containing them?  (I can't find the counterpart of that [1].=
)

Ren=C3=A9
