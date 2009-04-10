From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git-cvsimport: add support for cvs pserver password scrambling.
Date: Fri, 10 Apr 2009 09:34:34 +0900
Message-ID: <20090410093434.6117@nanako3.lavabit.com>
References: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?Dirk_H=F6rner?= <dirker@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 02:37:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls4kW-0007hz-Jh
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 02:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765205AbZDJAfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 20:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764713AbZDJAfW
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 20:35:22 -0400
Received: from karen.lavabit.com ([72.249.41.33]:56652 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764572AbZDJAfU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 20:35:20 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id BA54011B8BB;
	Thu,  9 Apr 2009 19:35:19 -0500 (CDT)
Received: from 1828.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 7CTXKYER6PFP; Thu, 09 Apr 2009 19:35:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=DTYTwNjm+ljuTrBGrrBQka6mFSfQDJA3Y3nCa10VFvTmiPskUWWfBVhNo/6NdjnB9JjqcPShSzCIo1CP7BmlH31wZxYNdzQX9AFXEx6L0zZEj0ssJR+kS7FdKJJM5vnEvGZk6XgiP1G2MQrJrZksVppMJvOO8GvcJjbcB+upcrk=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116224>

Quoting Dirk H=C3=B6rner:

> Instead of a cleartext password, the CVS pserver expects a scrambled =
one
> in the authentication request. With this patch it is possible to impo=
rt
> CVS repositories only accessible via pserver and user/password.
>=20
> Signed-off-by: Dirk Hoerner <dirker@gmail.com>

Junio, may I ask what happened to this patch?

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
