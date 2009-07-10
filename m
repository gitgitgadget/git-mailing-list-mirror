From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: make install fails with $bindir = $execdir
Date: Fri, 10 Jul 2009 13:57:01 +0200
Message-ID: <adf1fd3d0907100457s6ee06344nf4b4fecac1e30358@mail.gmail.com>
References: <adf1fd3d0907100311k3b70c9f4va077e96a499ce093@mail.gmail.com>
	 <4A571966.1080505@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 13:57:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPEj4-0005eg-LS
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 13:57:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbZGJL5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 07:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbZGJL5F
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 07:57:05 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:44337 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbZGJL5F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 07:57:05 -0400
Received: by bwz25 with SMTP id 25so814107bwz.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 04:57:01 -0700 (PDT)
Received: by 10.204.99.129 with SMTP id u1mr1817313bkn.200.1247227021697; Fri, 
	10 Jul 2009 04:57:01 -0700 (PDT)
In-Reply-To: <4A571966.1080505@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123051>

2009/7/10 Johannes Sixt <j.sixt@viscovery.net>:
> Santi B=E9jar schrieb:
>> =A0 since commit 4ecbc17 (Makefile: install 'git' in execdir,
>> 2009-07-09), included in v1.6.4-rc0, the install fails when $bindir =
is
>> equal to $execdir with:
>
> A fix was posted 11 hours ago:
>
> http://thread.gmane.org/gmane.comp.version-control.git/122903/focus=3D=
123020

Thanks. I missed it because it is hidden inside a thread.

Santi
