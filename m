From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 2/2] git-svn: Cache results of running the executable
	"git config"
Date: Mon, 4 Apr 2011 14:53:31 -0700
Message-ID: <20110404215331.GB4224@dcvr.yhbt.net>
References: <1301944148-7950-1-git-send-email-asedeno@mit.edu> <1301944148-7950-3-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, James Y Knight <jknight@itasoftware.com>
To: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 04 23:53:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6riP-00037e-Ry
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 23:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337Ab1DDVxg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 17:53:36 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:53891 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359Ab1DDVxf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 17:53:35 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 937691F749;
	Mon,  4 Apr 2011 21:53:35 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1301944148-7950-3-git-send-email-asedeno@mit.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170841>

"Alejandro R. Sede=C3=B1o" <asedeno@mit.edu> wrote:
> From: James Y Knight <jknight@itasoftware.com>
>=20
> Running programs is not cheap!
>=20
> Signed-off-by: James Y Knight <jknight@itasoftware.com>
> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>

Thanks, acked and pushed out to git://bogomips.org/git-svn.git

--=20
Eric Wong
