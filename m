From: =?ISO-8859-1?Q?C=E9lestin_Matte?= <celestin.matte@ensimag.fr>
Subject: Re: [PATCH v3 00/28] Follow perlcritic's recommandations
Date: Tue, 11 Jun 2013 14:54:54 +0200
Message-ID: <51B71E1E.8020103@ensimag.fr>
References: <1370816573-3808-1-git-send-email-celestin.matte@ensimag.fr> <CAPig+cR1=32TwatmTdVBDnkpkhwtUNyKL_Z9f=V_FPtt_Y-xiA@mail.gmail.com> <vpq7gi2qrnz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?ISO-8859-1?Q?C=E9lestin_?= =?ISO-8859-1?Q?Matte?= 
	<celestin.matte@ensimag.fr>, Git List <git@vger.kernel.org>,
	benoit.person@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 11 14:55:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmO6b-0004Si-Aq
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 14:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755420Ab3FKMzD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jun 2013 08:55:03 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53624 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab3FKMy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 08:54:59 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5BCsrT5010695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 11 Jun 2013 14:54:53 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5BCss2Q014736;
	Tue, 11 Jun 2013 14:54:54 +0200
Received: from [127.0.0.1] (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5BCssj9007386;
	Tue, 11 Jun 2013 14:54:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <vpq7gi2qrnz.fsf@anie.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 11 Jun 2013 14:54:54 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227434>

So, do I send a last version of the patch? What is left is quick fix:
- removing whitespace in [18/28]
- typo in [09/28]
- better line split in [22/28]
I already fixed first two problems, so it would be done rapidly.

--=20
C=E9lestin Matte
