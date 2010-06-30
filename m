From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/4] msvc: Select the "fast" definition of the {get,put}_be32()
 macros
Date: Wed, 30 Jun 2010 20:53:59 +0100
Message-ID: <4C2BA0D7.2070903@ramsay1.demon.co.uk>
References: <4C2264B6.5010906@ramsay1.demon.co.uk> <20100624112148.GA12485@burratino> <4C250DD2.2030801@ramsay1.demon.co.uk> <20100626183111.GB13070@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 22:33:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU3yn-0007up-85
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 22:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755715Ab0F3Udt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Jun 2010 16:33:49 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:56459 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755587Ab0F3Uds (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Jun 2010 16:33:48 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1OU3yd-0002hL-XP; Wed, 30 Jun 2010 20:33:47 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20100626183111.GB13070@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149991>

Jonathan Nieder wrote:
>> It should probably be investigated at some point, but I don't think
>> it's an urgent issue (and the msvc build will be no worse off ;-).
>=20
> Right, I agree with this. :)  So for what it=E2=80=99s worth:
>=20
>   Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks!

ATB,
Ramsay Jones
