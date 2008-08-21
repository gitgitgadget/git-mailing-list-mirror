From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Suggestion: "man git clone"
Date: Thu, 21 Aug 2008 09:37:51 -0700
Message-ID: <48AD99DF.5090802@zytor.com>
References: <48ACB29C.7000606@zytor.com> <48ACB5F4.3000905@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?IlBldGVyIFZhbGRlbWFyIE3DuHJjaCAoTGlzdHMpIg==?= 
	<4ux6as402@sneakemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 18:40:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWDC3-0006X0-Ve
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 18:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544AbYHUQh6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Aug 2008 12:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758277AbYHUQh5
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 12:37:57 -0400
Received: from terminus.zytor.com ([198.137.202.10]:40397 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbYHUQh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 12:37:57 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7LGbqTp029848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 21 Aug 2008 09:37:52 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7LGbqSM026919;
	Thu, 21 Aug 2008 09:37:52 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7LGbpw6018096;
	Thu, 21 Aug 2008 09:37:52 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <48ACB5F4.3000905@sneakemail.com>
X-Virus-Scanned: ClamAV 0.93.3/8065/Thu Aug 21 08:27:29 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93173>

Peter Valdemar M=C3=B8rch (Lists) wrote:
>=20
> Sorry man that behaviour is the way "man" works. See "man man".
>=20
>   $ git clone --help
> or
>   $ git help clone
>=20
> work right?
>=20
> Peter
>=20
> P.S: man, there are puns in that...

I know that that is the way "man" currently works.

I doubt you find *anyone* who relies on the current behaviour, so I am=20
suggesting changing man.  That's why the man author was on the recipien=
t=20
list, but you removed it.

	-hpa
