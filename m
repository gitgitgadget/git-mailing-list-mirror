From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-tag: add flag to verify a tag
Date: Wed, 03 Jan 2007 08:25:59 -0800
Message-ID: <7vac10oz54.fsf@assigned-by-dhcp.cox.net>
References: <877iw4tgff.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 17:26:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H28wJ-0006F0-Pv
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 17:26:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbXACQ0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 3 Jan 2007 11:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbXACQ0D
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 11:26:03 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50133 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbXACQ0C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jan 2007 11:26:02 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103162601.IALU97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Wed, 3 Jan 2007 11:26:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 6gRD1W0051kojtg0000000; Wed, 03 Jan 2007 11:25:13 -0500
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <877iw4tgff.fsf@gmail.com> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Wed, 03
	Jan 2007 13:59:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35876>

Santi B=E9jar <sbejar@gmail.com> writes:

> This way "git tag -v $tag" is the UI for git-verify-tag.
> ---
>  Documentation/git-tag.txt |    7 ++++++-
> ...


Signoffs?
