From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: checkout extra files
Date: Sun, 09 Sep 2012 15:48:07 +0200
Message-ID: <vpq627ntii0.fsf@bauges.imag.fr>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
	<CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
	<7vsjayew50.fsf@alter.siamese.dyndns.org>
	<CACsJy8BDtV95QmWmJ8CEh06FUePOB7KY6nKPR1KCZ7DkMN_MNQ@mail.gmail.com>
	<7vd322ebsz.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9BbOJgVNepFittD5fVkFLY24Tf10PVg3MD6E1M3hMyNsQ@mail.gmail.com>
	<7vpq61dfn9.fsf@alter.siamese.dyndns.org>
	<7v8vcpdat2.fsf@alter.siamese.dyndns.org>
	<7vk3w5woc4.fsf@alter.siamese.dyndns.org>
	<3DA7C9D97E19414C81F8D73CB66171DA@PhilipOakley>
	<7voblfub16.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Philip Oakley" <philipoakley@iee.org>,
	"Angelo Borsotti" <angelo.borsotti@gmail.com>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 15:48:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAhs9-0000yj-LM
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 15:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab2IINsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 09:48:18 -0400
Received: from mx2.imag.fr ([129.88.30.17]:60696 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792Ab2IINsR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 09:48:17 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q89DhCLF027219
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 9 Sep 2012 15:43:12 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TAhrs-0008Vq-1W; Sun, 09 Sep 2012 15:48:08 +0200
In-Reply-To: <7voblfub16.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 08 Sep 2012 20:31:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 09 Sep 2012 15:43:13 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q89DhCLF027219
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1347802994.53847@wAZs8801inKZB8Rm3r5WXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205078>

Junio C Hamano <gitster@pobox.com> writes:

> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> Having said that, it would therefore be better to point folk at gitcli
>> in a few more places, not just the 'see also' line at the very end of
>> the general 'git' page, and buried within rev-parse.
>
> Didn't we update the very early part of git(1) for exactly for that
> reason recently?

I don't think many people read git(1) directly, as there are many other
starting points to learn Git (official tutorial, user-manual, and tens
of very good tutorial on the web). On the other hand, reading
git-<command> is probably much more common, as it is the only place to
find exhaustive documentation about a particular command.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
