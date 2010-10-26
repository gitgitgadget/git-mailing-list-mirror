From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 09/10] user-manual.txt: explain better the remote(-tracking) branch terms
Date: Wed, 27 Oct 2010 00:13:34 +0200
Message-ID: <vpqwrp438mp.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287986922-16308-10-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTiky=FiLX=FQL5V66FW_t4yeHjAxE_JJyovTTw5u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 00:13:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PArmF-0005cH-4w
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 00:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760594Ab0JZWNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 18:13:44 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59323 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760591Ab0JZWNm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 18:13:42 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9QLwthI012339
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 26 Oct 2010 23:58:55 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PArlu-0003Vy-GK; Wed, 27 Oct 2010 00:13:34 +0200
In-Reply-To: <AANLkTiky=FiLX=FQL5V66FW_t4yeHjAxE_JJyovTTw5u@mail.gmail.com> (Jay Soffian's message of "Tue\, 26 Oct 2010 02\:07\:08 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 26 Oct 2010 23:58:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9QLwthI012339
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288735135.85337@yX5if2YE4EVrwCP5o3l6EQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160008>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Mon, Oct 25, 2010 at 2:08 AM, Matthieu Moy <Matthieu.Moy@imag.fr> =
wrote:
>> =A0You cannot check out these remote-tracking branches, but you can
>> =A0examine them on a branch of your own, just as you would a tag:
>
> Suggestion: "You do not commit directly to remote-tracking branches,
> but you can examine them or create a branch from them, just as you
> would a tag:"

There was already a patch by Jonathan to fix that. I've integrated it
in my patch serie, it will be in the next resend.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
