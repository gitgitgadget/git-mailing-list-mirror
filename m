From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH V3 1/4] git-mw: Introduction of GitMediawiki.pm
Date: Tue, 18 Jun 2013 12:10:30 +0200
Message-ID: <vpqhagvu3u1.fsf@anie.imag.fr>
References: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
	<1371349893-7789-2-git-send-email-benoit.person@ensimag.fr>
	<vpqobb5g679.fsf@anie.imag.fr>
	<CAETqRChcu+N-2uNzL9_J6abR5fnduT5UVRif5NTQYOoxPTiRTw@mail.gmail.com>
	<vpq8v299pn6.fsf@anie.imag.fr>
	<CAETqRCjiMh_cYuZit5Z8OLki_RTz8=ViYPMv005iQu9Fv=U0ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: =?iso-8859-1?Q?Beno=EEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 12:10:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoss5-0004AN-SI
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 12:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab3FRKKf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 06:10:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:46444 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164Ab3FRKKe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 06:10:34 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5IAAVrp001194
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 18 Jun 2013 12:10:31 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1Uosrw-0007W3-5z; Tue, 18 Jun 2013 12:10:32 +0200
In-Reply-To: <CAETqRCjiMh_cYuZit5Z8OLki_RTz8=ViYPMv005iQu9Fv=U0ow@mail.gmail.com>
	(=?iso-8859-1?Q?=22Beno=EEt?= Person"'s message of "Tue, 18 Jun 2013
 11:06:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 18 Jun 2013 12:10:31 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228184>

Beno=EEt Person <benoit.person@ensimag.fr> writes:

>>From my point of view, this could definitely be improved from:
>> -     perlcritic -2 *.perl
>> +     perlcritic -2 *.perl
>> \ No newline at end of file
> to something like that:
>> -     perlcritic -2 *.perl
>> +     perlcritic -2 *.perl
>> \ removed newline at end of file
> which gives more insights into why the line is considered "edited".

Too late ;-). This is a diff/patch thing, and Git is compatible with
them.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
