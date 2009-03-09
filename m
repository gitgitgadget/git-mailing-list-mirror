From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/4] parseopt: make usage optional
Date: Mon, 09 Mar 2009 21:19:57 +0100
Message-ID: <49B579ED.2090304@lsrfire.ath.cx>
References: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org> <49B2C784.90800@lsrfire.ath.cx> <49B40B9A.8080202@lsrfire.ath.cx> <7vr617kbit.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, carlos.duclos@nokia.com,
	Pierre Habouzit <madcoder@madism.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 21:21:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lglyg-0003Iz-Of
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 21:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbZCIUUH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 16:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752565AbZCIUUG
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 16:20:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:52962 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbZCIUUF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 16:20:05 -0400
Received: from [10.0.1.101] (p57B7F24E.dip.t-dialin.net [87.183.242.78])
	by india601.server4you.de (Postfix) with ESMTPSA id 6E0AB2F8063;
	Mon,  9 Mar 2009 21:20:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7vr617kbit.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112736>

Junio C Hamano schrieb:
> Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>> Allow usagestr to be NULL and don't display anything a help screen i=
n
>> this case.  This is useful to implement incremental parsers.
>=20
> Can I amend "s/anything a/any/"?

Oh, definitely.

Thanks,
Ren=C3=A9
