From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: don't confuse editors with an apostrophe
Date: Thu, 31 Mar 2011 15:59:04 -0700
Message-ID: <20110331225904.GA12265@dcvr.yhbt.net>
References: <1301583753-2688-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Fri Apr 01 00:59:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Qpk-0008WB-FB
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 00:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759434Ab1CaW7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 18:59:07 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:37106 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605Ab1CaW7G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 18:59:06 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F0B1F68D;
	Thu, 31 Mar 2011 22:59:05 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1301583753-2688-1-git-send-email-cmn@elego.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170540>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> wrote:
> The quotation mark serving as an apostrophe confuses editors and they
> think a large part of the rest of the file is a string. Change
> "you're" to "you are" to avoid this.
>=20
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>

Looks reasonable.  Avoiding contractions may make life easier for folks
less familiar with English overall

Acked-by: Eric Wong <normalperson@yhbt.net>

Thanks!
