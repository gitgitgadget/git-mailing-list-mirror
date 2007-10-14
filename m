From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Sun, 14 Oct 2007 17:14:03 +0200
Message-ID: <4712323B.6060902@op5.se>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>	<F32B0EEF-496C-4D6D-BD9A-B6A0C04E0EE3@wincent.com>	<854pgtonp5.fsf@lola.goethe.zz>	<200710141709.51579.chriscool@tuxfamily.org> <85d4vhn35z.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Wincent Colaiuta <win@wincent.com>,
	Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 17:14:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih5AZ-0007ir-6O
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 17:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756458AbXJNPOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Oct 2007 11:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756167AbXJNPOI
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 11:14:08 -0400
Received: from mail.op5.se ([193.201.96.20]:53935 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753855AbXJNPOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 11:14:07 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C876B17306EF;
	Sun, 14 Oct 2007 17:14:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6SGxSQZD3-H7; Sun, 14 Oct 2007 17:14:05 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 96B8F1730682;
	Sun, 14 Oct 2007 17:14:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <85d4vhn35z.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60856>

David Kastrup wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
>=20
>> Le dimanche 14 octobre 2007, David Kastrup a =C3=A9crit :
>>> Wincent Colaiuta <win@wincent.com> writes:
>>>> El 14/10/2007, a las 14:28, Christian Couder escribi=C3=B3:
>>>>> Here is my bisect dunno patch series again.
>>>> Good work on the series, Christian, but don't you think that
>>>> "unknown" would sound a little bit better than "dunno"? For people
>>>> who don't speak English as a second language "dunno" might not be
>>>> immediately clear.
>>> "undecided"?
>> I choosed "dunno" because that was what Dscho suggested in this thre=
ad:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/53584/focus=3D=
53595
>=20
> I would think that tongue-in-cheek.  In case it was serious, I'd
> consider it one of those cases where it would make good sense to
> overrule the geek penchant for quirkiness.
>=20
> Just think about the nuisance of finding adequate translations in
> i18n: "Woa=C3=9Fnet", "Eh?", "Chepas" etc.
>=20

Well, that won't be a problem, as commands and their subcommands and
options aren't translated.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
