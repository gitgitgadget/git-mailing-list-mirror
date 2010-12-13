From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@mit.edu>
Subject: Re: git-send-email: add some short options and update documentation
Date: Mon, 13 Dec 2010 15:12:09 -0500
Message-ID: <4D067E19.1060904@mit.edu>
References: <1291869878-19645-1-git-send-email-asedeno@mit.edu> <1292006656-1264-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
X-From: git-owner@vger.kernel.org Mon Dec 13 21:19:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSErg-0000P7-6m
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 21:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab0LMUTO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Dec 2010 15:19:14 -0500
Received: from mx2.itasoftware.com ([63.115.78.21]:37996 "EHLO
	mx2.itasoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab0LMUTO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 15:19:14 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2010 15:19:14 EST
Received: from ita4mta3.internal.itasoftware.com (ita4mta3.internal.itasoftware.com [10.4.52.159])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.itasoftware.com (Postfix) with ESMTP id B1EBD57D42;
	Mon, 13 Dec 2010 15:12:09 -0500 (EST)
Received: from asedeno.corp.itasoftware.com (lb1.dc4nat163.dc4.internal.itasoftware.com [10.4.199.163])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ita4mta3.internal.itasoftware.com (Postfix) with ESMTP id 8F0491C24053;
	Mon, 13 Dec 2010 15:12:09 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101110 Icedove/3.1.6
In-Reply-To: <1292006656-1264-1-git-send-email-asedeno@mit.edu>
X-ITASoftware-MailScanner: Found to be clean
X-ITASoftware-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-1, required 3, ALL_TRUSTED -1.00)
X-ITASoftware-MailScanner-From: asedeno@mit.edu
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163591>

On 12/10/2010 01:44 PM, Alejandro R. Sede=C3=B1o wrote:
> Add short options that were mentioned in the thread to git-send-email=
,
> specifically:
>=20
> -n for --dry-run
> -f for --force
> -q for --quiet
>=20
> Since --force didn't have documentation in
> Documentation/git-send-email.txt, a separate commit adds some
> first.
>=20
> [PATCH 1/2] Add --force to git-send-email documentation

I see this has been pulled into master. Thanks, Junio.

> [PATCH 2/2] git-send-email: Add some short options

Any more comments on this?

-Alejandro
