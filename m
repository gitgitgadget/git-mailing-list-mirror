From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Use time_t for timestamps returned by approxidate()  instead of unsigned
Date: Sat, 24 Jan 2009 17:37:09 +0100
Message-ID: <643EB4C4-D3A9-41B9-AE1B-00D71B4CA9F9@wincent.com>
References: <1232665622-5110-1-git-send-email-tim.henigan@gmail.com> <alpine.DEB.1.00.0901240726070.13232@racer> <32c343770901240813k2eeb19b0q65b533f829cb44d4@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 17:38:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQlWs-0005Do-GQ
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 17:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbZAXQhT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Jan 2009 11:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755362AbZAXQhT
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 11:37:19 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:51364 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754977AbZAXQhS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jan 2009 11:37:18 -0500
Received: from cuzco.lan (139.pool85-53-3.dynamic.orange.es [85.53.3.139])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n0OGbAJJ015022
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 24 Jan 2009 11:37:12 -0500
In-Reply-To: <32c343770901240813k2eeb19b0q65b533f829cb44d4@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106975>

El 24/1/2009, a las 17:13, Tim Henigan escribi=F3:

> Should I update the GitWiki page to remove this Janitor task or do yo=
u
> keep it as a test to see if people are properly searching the mail
> archives?

I don't know of too many projects which intentionally publish =20
misleading information to "test" would-be contributors. I think =20
editing the wiki would be a good idea.

Cheers,
Wincent
