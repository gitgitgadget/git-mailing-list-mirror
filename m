From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] path-list documentation: document all functions and data
 structures
Date: Sat, 14 Jun 2008 01:30:57 +0200
Message-ID: <48530331.70807@free.fr>
References: <1213397300-23224-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Don Zickus <dzickus@redhat.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 01:32:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7IkP-0001nX-OQ
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 01:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756353AbYFMXac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 19:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756311AbYFMXac
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 19:30:32 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:57374 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756155AbYFMXab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 19:30:31 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 7EE9B12B6C1;
	Sat, 14 Jun 2008 01:30:30 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 363E512B6BB;
	Sat, 14 Jun 2008 01:30:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <1213397300-23224-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84953>

Hi,

Nice work!

Miklos Vajna a =E9crit :
>=20
> +The caller:
> +
> +. Allocates and clears (`memset(&list, '0', sizeof(path_list));`) a
> +  `struct path_list` variable.

Don't you mean sizeof(list) here?

Olivier.
