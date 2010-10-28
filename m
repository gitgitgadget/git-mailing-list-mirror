From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 03/10] Change remote tracking to remote-tracking in non-trivial places
Date: Fri, 29 Oct 2010 00:40:27 +0200
Message-ID: <vpqk4l2djqc.fsf@bauges.imag.fr>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1288290117-6734-4-git-send-email-Matthieu.Moy@imag.fr>
	<20101028183919.GD14212@burratino> <vpq4oc6f0ms.fsf@bauges.imag.fr>
	<20101028221316.GD16125@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 00:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBb9G-0006C3-H7
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 00:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172Ab0J1Wki (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 18:40:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46646 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756352Ab0J1Wkg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 18:40:36 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o9SMPgUT030920
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 29 Oct 2010 00:25:42 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PBb92-000637-32; Fri, 29 Oct 2010 00:40:28 +0200
In-Reply-To: <20101028221316.GD16125@burratino> (Jonathan Nieder's message of "Thu\, 28 Oct 2010 17\:13\:16 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 29 Oct 2010 00:25:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o9SMPgUT030920
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1288909546.26599@pl+iJV70uowJGByhMqXP5Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160245>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> What I'm trying to do here is really to achieve consistancy. If
>> something has a name, let's use the same name everywhere.
>
> Okay, but can it at least not be part of a patch that does something
> simpler (only adding dashes)?

OK, I'll do that.

> I'm not sure why you don't like the idea of rewording it, but
> that's fine ---

Not that I don't like the idea. I'm just saying that my patch makes
the situation better that it used to. No objection if other people
want to make it even better later (but I probably won't have time
soon).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
