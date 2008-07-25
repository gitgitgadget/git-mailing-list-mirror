From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/6] archive: allow --exec and --remote without equal
 sign
Date: Fri, 25 Jul 2008 12:54:00 +0200
Message-ID: <4889B0C8.70908@lsrfire.ath.cx>
References: <1216982486-5887-1-git-send-email-rene.scharfe@lsrfire.ath.cx> <1216982486-5887-2-git-send-email-rene.scharfe@lsrfire.ath.cx> <1216982486-5887-3-git-send-email-rene.scharfe@lsrfire.ath.cx> <1216982486-5887-4-git-send-email-rene.scharfe@lsrfire.ath.cx> <1216982486-5887-5-git-send-email-rene.scharfe@lsrfire.ath.cx> <1216982486-5887-6-git-send-email-rene.scharfe@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 12:55:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMKx0-0002rE-N6
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 12:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbYGYKyH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 06:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYGYKyF
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 06:54:05 -0400
Received: from india601.server4you.de ([85.25.151.105]:55548 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbYGYKyE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 06:54:04 -0400
Received: from [10.0.1.200] (p57B7EC0C.dip.t-dialin.net [87.183.236.12])
	by india601.server4you.de (Postfix) with ESMTPSA id 2C4972F8028;
	Fri, 25 Jul 2008 12:54:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <1216982486-5887-6-git-send-email-rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90032>

Rene Scharfe schrieb:
> Convert git archive to parse_options().  The parameters --remote and =
--exec
> are still handled by their special parser.  Define them anyway in ord=
er for
> them to show up in the usage notice.

Hmpf, the _real_ subject of this email is "[PATCH 6/6] archive: convert
to parse_options()"..

Ren=E9
