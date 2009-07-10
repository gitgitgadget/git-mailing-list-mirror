From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: make install fails with $bindir = $execdir
Date: Fri, 10 Jul 2009 12:35:18 +0200
Message-ID: <4A571966.1080505@viscovery.net>
References: <adf1fd3d0907100311k3b70c9f4va077e96a499ce093@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jul 10 12:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPDS8-000788-PI
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 12:35:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbZGJKfd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jul 2009 06:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbZGJKfc
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 06:35:32 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37853 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbZGJKfb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jul 2009 06:35:31 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MPDRn-0001He-4E; Fri, 10 Jul 2009 12:35:26 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CE8409F88; Fri, 10 Jul 2009 12:35:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <adf1fd3d0907100311k3b70c9f4va077e96a499ce093@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123047>

Santi B=E9jar schrieb:
>   since commit 4ecbc17 (Makefile: install 'git' in execdir,
> 2009-07-09), included in v1.6.4-rc0, the install fails when $bindir i=
s
> equal to $execdir with:

A fix was posted 11 hours ago:

http://thread.gmane.org/gmane.comp.version-control.git/122903/focus=3D1=
23020

-- Hannes
