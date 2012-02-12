From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v2 1/2] git-svn: remove redundant porcelain option to
 rev-list
Date: Sun, 12 Feb 2012 06:49:42 +0000
Message-ID: <20120212064942.GA30253@dcvr.yhbt.net>
References: <CACBZZX5cwZ4Xz3-C8B3v4eEmyO0B-JiohfRATu1UhxzST0ar5w@mail.gmail.com>
 <1329006186-21346-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 12 07:50:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwTGW-0005wf-LF
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 07:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772Ab2BLGts convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 01:49:48 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47752 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab2BLGtr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 01:49:47 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFF0C1FEE4;
	Sun, 12 Feb 2012 06:49:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1329006186-21346-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190560>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
> Change an invocation of git-rev-list(1) to not use --no-color,
> git-rev-list(1) will always ignore that option and the --color option=
,
> so there's no need to pass it.
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>

Acked-by: Eric Wong <normalperson@yhbt.net>

Thanks, will push this series.
