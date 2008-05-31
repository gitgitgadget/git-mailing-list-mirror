From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] gitweb: Remove gitweb/test/ directory
Date: Sat, 31 May 2008 20:49:04 +0200
Message-ID: <5DBABAFE-C447-4E5D-A7E8-0C16B4D1D960@wincent.com>
References: <28EDBE43-6E55-4EC9-97C6-8AC8D949E82D@zib.de> <20080531182555.1646.47950.stgit@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 20:50:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2W9Y-0006ss-Dp
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 20:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613AbYEaStP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 May 2008 14:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbYEaStP
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 14:49:15 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:56193 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbYEaStO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 May 2008 14:49:14 -0400
Received: from cuzco.lan (157.pool85-53-24.dynamic.orange.es [85.53.24.157])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id m4VIn5e2009414
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 31 May 2008 14:49:07 -0400
In-Reply-To: <20080531182555.1646.47950.stgit@localhost.localdomain>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83401>

El 31/5/2008, a las 20:28, Jakub Narebski escribi=F3:

> Testing if gitweb handles filenames with spaces, filenames with plus
> sign ('+') which encodes spaces in CGI parameters (in URLs), and
> filenames with Unicode characters should be handled by gitweb tests.
>
> Those files are remainder of the time when gitweb was project on its
> own, not a part of git (with its testsuite).
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Ack.
Wincent
