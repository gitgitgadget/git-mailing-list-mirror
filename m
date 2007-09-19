From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Side-by-side diff and patch visualization
Date: Wed, 19 Sep 2007 14:36:03 +0200
Message-ID: <5340F4CD-929F-4D87-94D0-367122284FDA@wincent.com>
References: <A92611E8-1035-46A6-AFEF-9C8A6F93AFB1@wincent.com> <20070919120956.GA20715@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 19 14:36:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXyn5-0004Xw-7R
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 14:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799AbXISMgT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Sep 2007 08:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbXISMgT
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 08:36:19 -0400
Received: from wincent.com ([72.3.236.74]:46661 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753027AbXISMgS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2007 08:36:18 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8JCaDIW016752;
	Wed, 19 Sep 2007 07:36:13 -0500
In-Reply-To: <20070919120956.GA20715@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58707>

El 19/9/2007, a las 14:09, Jeff King escribi=F3:

> On Wed, Sep 19, 2007 at 01:40:17PM +0200, Wincent Colaiuta wrote:
>
>> Does anybody know of any tools for doing side-by-side =20
>> visualizations of
>> diffs and patches which work well with Git?
>
> Have you tried kompare?
>
>   git-diff HEAD~5 | kompare -
>
> -Peff

Ah, didn't know about that one. From the look of it that is exactly =20
the kind of extremely simple viewer that I was wanting.

Cheers,
Wincent
