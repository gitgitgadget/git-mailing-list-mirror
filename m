From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Command-line git Vs IDE+plugin?
Date: Tue, 19 Nov 2013 18:20:46 +0100
Message-ID: <vpq1u2c9ukx.fsf@anie.imag.fr>
References: <vpqiovpfxd1.fsf@anie.imag.fr> <201311191336.31000.thomas@koch.ro>
	<xmqqbo1g9vua.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Koch <thomas@koch.ro>, git <git@vger.kernel.org>,
	Noufal Ibrahim KV <noufal@nibrahim.net.in>,
	Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 18:21:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vioz9-0002Cm-P5
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 18:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab3KSRVI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Nov 2013 12:21:08 -0500
Received: from mx1.imag.fr ([129.88.30.5]:51288 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624Ab3KSRVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 12:21:05 -0500
Received: from globule.imag.fr (globule.imag.fr [129.88.34.238])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id rAJHKmmb022052
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 19 Nov 2013 18:20:48 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	(authenticated bits=0)
	by globule.imag.fr (8.13.8/8.13.8) with ESMTP id rAJHKkoY029742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 19 Nov 2013 18:20:50 +0100
In-Reply-To: <xmqqbo1g9vua.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 Nov 2013 08:53:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 19 Nov 2013 18:20:48 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: rAJHKmmb022052
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1385486453.45574@fP9xBl+4TapNV3nJI5K4JA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238032>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps I am being na=EFve, but I would expect that a GUI is a much
> better vehicle to help users build the right mental model.

One thing the command-line does well is to give names to concepts
(basically, command names, option names, ...). It's easy to write in a
tutorial or an email "run the command 'git foo'". It's less easy to
write "click on that red button, on the right of the green one".
Then, it's clear to everyone what "commit", "rebase", "amend" & so mean=
,
regardless of the colors of buttons (that's one of the reasons I use th=
e
english words even when I speak french).

That said, even when I teach the command-line, gitk is a very valuable
tool to explain what the DAG is and how branching works.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
