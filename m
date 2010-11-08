From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/7] add description parameter to OPT__QUIET
Date: Mon, 08 Nov 2010 22:06:42 +0100
Message-ID: <4CD86662.2050102@lsrfire.ath.cx>
References: <4CD83917.3040801@lsrfire.ath.cx> <4CD83ABD.30804@lsrfire.ath.cx> <20101108181801.GB30428@sigill.intra.peff.net> <20101108195448.GA12660@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 22:07:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFYvf-0006t8-W1
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 22:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455Ab0KHVGx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Nov 2010 16:06:53 -0500
Received: from india601.server4you.de ([85.25.151.105]:37895 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab0KHVGx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 16:06:53 -0500
Received: from [10.0.1.100] (p4FC564D6.dip.t-dialin.net [79.197.100.214])
	by india601.server4you.de (Postfix) with ESMTPSA id C3C2C2F807B;
	Mon,  8 Nov 2010 22:06:46 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101108195448.GA12660@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160989>

Am 08.11.2010 20:54, schrieb Jonathan Nieder:
> Jeff King wrote:
>=20
>> Maybe my "don't repeat yourself" spider sense is over-reacting, but =
of
>> 12 callsites, 11 of them will continue to use "be quiet".
>=20
> Maybe something like this would help alleviate the smell.

Yes, patches like yours were what I was hoping for. :)

Thanks,
Ren=E9
