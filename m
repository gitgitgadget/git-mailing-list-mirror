From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC] l10n: de.po: translate 27 new messages
Date: Mon, 11 Jun 2012 10:26:56 +0200
Message-ID: <87zk8amey7.fsf@thomas.inf.ethz.ch>
References: <1339341080-23674-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <jk@jk.gs>, <stimming@tuhh.de>, <worldhello.net@gmail.com>,
	<git@vger.kernel.org>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 10:27:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdzxq-0005Y8-53
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 10:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab2FKI1A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 04:27:00 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:31199 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab2FKI07 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 04:26:59 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 11 Jun
 2012 10:26:56 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 11 Jun
 2012 10:26:56 +0200
In-Reply-To: <1339341080-23674-1-git-send-email-ralf.thielow@googlemail.com>
	(Ralf Thielow's message of "Sun, 10 Jun 2012 17:11:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199632>

Ralf Thielow <ralf.thielow@googlemail.com> writes:

> +#: git-am.sh:95
> +msgid ""
> +"You seem to have moved HEAD since the last 'am' failure.\n"
> +"Not rewinding to ORIG_HEAD"
> +msgstr ""
> +"Du scheinst seit dem letzten fehlerhaften 'am' die Zweigspitze (HEA=
D)\n"
> +"ge=C3=A4ndert zu haben.\n"
> +"Keine Zur=C3=BCcksetzung zu ORIG_HEAD."

since the last 'am' failure -> seit dem letzten *gescheiterten* 'am'?

> +#: git-am.sh:831
> +msgid ""
> +"You still have unmerged paths in your index\n"
> +"did you forget to use 'git add'?"
> +msgstr ""
> +"Du hast weiterhin nicht zusammengef=C3=BChrte Pfade in der Bereitst=
ellung.\n"
> +"Hast du vergessen 'git add' zu benutzen?"

still -> immer noch?

> +#: git-bisect.sh:48
> +msgid "You need to start by \"git bisect start\""
> +msgstr "Du must mit \"git bisect start\" beginnen."
                ^
typo: musst

Other than those nits I like them.  Thanks for your work!

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
