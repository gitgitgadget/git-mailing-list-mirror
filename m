From: Junio C Hamano <junkio@cox.net>
Subject: Re: "git cat" and "git ls"
Date: Wed, 18 Jan 2006 09:14:42 -0800
Message-ID: <7vlkxdxxtp.fsf@assigned-by-dhcp.cox.net>
References: <87irsh6087.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 18:16:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzGtY-0001l9-RD
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 18:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWARROq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 18 Jan 2006 12:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWARROq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 12:14:46 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51890 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751384AbWARROp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 12:14:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118171233.GISU26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 12:12:33 -0500
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <87irsh6087.fsf@gmail.com> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Wed, 18
	Jan 2006 16:10:16 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14842>

Santi B=E9jar <sbejar@gmail.com> writes:

>         following the "git diff" wrapper I've done two new wrappers:
>
> git cat: USAGE=3D'<tag|commit|blob> | [<ent>|-1|-2|-3] -- <file>'
> git ls: USAGE=3D'[<ent>] [--] <path>'

Not interested; sorry.

The only thing I find lacking from the current set of tools is a
way to prettyprint an annotated tag to make its date human
readable.
