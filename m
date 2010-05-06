From: Jeff King <peff@peff.net>
Subject: Re: Feature request: relative paths
Date: Thu, 6 May 2010 05:09:33 -0400
Message-ID: <20100506090933.GC31873@coredump.intra.peff.net>
References: <19426.23330.525936.981066@winooski.ccs.neu.edu>
 <20100506083113.GA25993@progeny.tock>
 <20100506084607.GA9921@atjola.homenet>
 <20100506090132.GA26079@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Eli Barzilay <eli@barzilay.org>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 11:09:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9x5U-0004Q6-00
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 11:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587Ab0EFJJi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 05:09:38 -0400
Received: from peff.net ([208.65.91.99]:33874 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086Ab0EFJJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 05:09:38 -0400
Received: (qmail 5187 invoked by uid 107); 6 May 2010 09:09:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 06 May 2010 05:09:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 May 2010 05:09:33 -0400
Content-Disposition: inline
In-Reply-To: <20100506090132.GA26079@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146466>

On Thu, May 06, 2010 at 04:01:33AM -0500, Jonathan Nieder wrote:

> I suggest reviving Dscho=E2=80=99s :./ syntax[1].
> [1] http://thread.gmane.org/gmane.comp.version-control.git/68786/focu=
s=3D68905

Oops, I was wrong about "there is no patch" (apparently I even submitte=
d
a followup!).

Yes, I think that patch is a sane start, but it needs some cleanup.

-Peff
