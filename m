From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH/RFC] More colors for pretty format: yellow, purple, cyan,
 white and black
Date: Fri, 25 Apr 2008 22:42:08 +0200
Message-ID: <48124220.50300@lsrfire.ath.cx>
References: <c19f1c910804241026q14f95af7qa0289018d08ac23a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Tom ten Thij <mail@tomtenthij.nl>
X-From: git-owner@vger.kernel.org Fri Apr 25 22:43:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpUl7-00058k-09
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 22:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763118AbYDYUmR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Apr 2008 16:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761119AbYDYUmR
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 16:42:17 -0400
Received: from india601.server4you.de ([85.25.151.105]:37888 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbYDYUmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 16:42:16 -0400
Received: from [10.0.1.200] (p57B7D583.dip.t-dialin.net [87.183.213.131])
	by india601.server4you.de (Postfix) with ESMTPSA id 07EE92F804E;
	Fri, 25 Apr 2008 22:42:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <c19f1c910804241026q14f95af7qa0289018d08ac23a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80346>

Tom ten Thij schrieb:
> Add support for other colors in pretty format the same way %Cred
> works.

Hmm.  Currently you can get the same effect by adding the escape codes
to the format string directly.  Arguably, --pretty=3Dformat should hono=
ur
the  config variable color.diff and the options --color and --no-color
to make the colour placeholders useful (both your extended set and the
current one).

Ren=E9
