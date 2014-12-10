From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: [wish] Revert changes in git gui
Date: Wed, 10 Dec 2014 08:54:31 +0100
Message-ID: <1lwfjzt.1vnoyhf195ryi8M%lists@haller-berlin.de>
References: <54875263.1010407@grueninger.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: foss@grueninger.de (=?ISO-8859-1?Q?Christoph_Gr=FCninger?=),
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 10 08:54:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyc6Z-0001jJ-4v
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 08:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbaLJHye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Dec 2014 02:54:34 -0500
Received: from server90.greatnet.de ([178.254.50.90]:45000 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753469AbaLJHyd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 02:54:33 -0500
Received: from [192.168.42.155] (dslb-094-223-104-253.094.223.pools.vodafone-ip.de [94.223.104.253])
	by server90.greatnet.de (Postfix) with ESMTPA id 8137360047;
	Wed, 10 Dec 2014 08:54:31 +0100 (CET)
In-Reply-To: <54875263.1010407@grueninger.de>
User-Agent: MacSOUP/2.8.4 (Mac OS X version 10.10.1 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261193>

Christoph Gr=FCninger <foss@grueninger.de> wrote:

> While browsing the changes, it is very easy to add (or remove) lines =
or
> hunks for commit via the context menu. I would like to revert the=20
> changes of a line or a hunk in a similar way. I have often white-spac=
e
> or formatting changes I don't want to commit but want them reverted=20
> immediately.

I would like to have this feature too.

In the meantime, my workaround is to stage the whole file, unstage the
hunk(s) or lines that I want to revert, and then choose "Revert Changes=
"
from the Commit menu. A little more awkward than I would like, but it
works well (except when you already took some time to selectively stage
hunks or lines for the next commit). So yes, a context menu for this
would be very welcome.


--=20
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
