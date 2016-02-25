From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/5] Documentation/diff-config: fix description of diff.renames
Date: Thu, 25 Feb 2016 18:34:56 +0100
Message-ID: <vpqvb5c3d8f.fsf@anie.imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249498-3232-2-git-send-email-Matthieu.Moy@imag.fr>
	<loom.20160225T181310-74@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe =?iso-8859-1?Q?Gon=E7alves?= Assis 
	<felipeg.assis@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 18:35:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYzoh-0001hQ-HO
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 18:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933295AbcBYRfB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2016 12:35:01 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43130 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933066AbcBYRfB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 12:35:01 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id u1PHYs35018349
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 25 Feb 2016 18:34:54 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1PHYu8o023823;
	Thu, 25 Feb 2016 18:34:56 +0100
In-Reply-To: <loom.20160225T181310-74@post.gmane.org> ("Felipe
 =?iso-8859-1?Q?Gon=E7alves?=
	Assis"'s message of "Thu, 25 Feb 2016 17:27:02 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 25 Feb 2016 18:34:55 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1PHYs35018349
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1457026496.99786@Z5u+GAE7UUEUd8qzw0R46A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287403>

=46elipe Gon=E7alves Assis <felipeg.assis@gmail.com> writes:

> Matthieu Moy <Matthieu.Moy <at> imag.fr> writes:
>
>>  diff.renames::
>> -	Tells Git to detect renames.  If set to any boolean value, it
>> -	will enable basic rename detection.  If set to "copies" or
>> -	"copy", it will detect copies, as well.
>> +	Whether and how Git detects renames.  If set to "false",
>> +	rename detection is disabled. If set to "true", basic rename
>> +	detection is enable.  If set to "copies" or "copy", Git will
>> +	detect copies, as well.  Defaults to false.
>
> Just a minor typo: s/enable/enabled/
> Also, there is only one space between the second and third sentences.

Indeed. Thanks.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
