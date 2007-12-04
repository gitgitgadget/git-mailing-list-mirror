From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] git-help: add -i|--info option to display info page.
Date: Tue, 4 Dec 2007 06:54:17 +0100
Message-ID: <200712040654.18322.chriscool@tuxfamily.org>
References: <20071202060740.269e54ad.chriscool@tuxfamily.org> <200712030653.15694.chriscool@tuxfamily.org> <47544EE5.1050707@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Dec 04 06:48:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzQdm-0005ax-RY
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 06:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXLDFr7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 00:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbXLDFr7
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 00:47:59 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:60372 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbXLDFr6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Dec 2007 00:47:58 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 754D41AB2AD;
	Tue,  4 Dec 2007 06:47:56 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E7ECC1AB2A8;
	Tue,  4 Dec 2007 06:47:53 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <47544EE5.1050707@obry.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67006>

Le lundi 3 d=C3=A9cembre 2007, Pascal Obry a =C3=A9crit :
> Ok about woman. Woman is an Emacs mode to display man pages. To send =
man
> page to display in Emacs from the command line one can use emacsclien=
t
> for example. I'm already doing this for standard man pages with a bas=
h
> function. This function does something like this:
>
>    $ emacsclient -e '(woman "git")'
>
> -e is for eval and the argument is the Emacs Lisp string to evaluate.
>
> Let me know if you need more information about woman.

Thanks Pascal, I will indeed tell you if I have questions about woman.
(Given the name, I wouldn't be surprised if it's hard to deal with.)

Christian.
