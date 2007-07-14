From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH 2/2] Wire new date formats to --date=<format> parser.
Date: Sat, 14 Jul 2007 12:29:27 +0200
Message-ID: <200707141229.27668.robin.rosenberg@dewire.com>
References: <7vy7hklzsf.fsf@assigned-by-dhcp.cox.net> <20070713225836.17922.32546.stgit@lathund.dewire.com> <7vodiflc3v.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 15:22:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9haI-0003to-Jf
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 15:22:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbXGNNWk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 14 Jul 2007 09:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755188AbXGNNWk
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 09:22:40 -0400
Received: from [83.140.172.130] ([83.140.172.130]:10180 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754142AbXGNNWj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 09:22:39 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9547A80266A;
	Sat, 14 Jul 2007 15:15:31 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31425-03; Sat, 14 Jul 2007 15:15:31 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 1750680265B;
	Sat, 14 Jul 2007 15:15:31 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7vodiflc3v.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52479>

l=F6rdag 14 juli 2007 skrev Junio C Hamano:
> Now we can use all internally supported date formats with
>=20
> 	git log --date=3D<format>
>=20
> syntax.  Earlier, we only allowed relative/local/default.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Ack, 1/2 and 2/2.

-- robin
