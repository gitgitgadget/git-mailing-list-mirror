From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH v3] Introduce BEL<branch> as shortcut to the tracked  branch
Date: Fri, 20 Mar 2009 13:45:23 +0100
Organization: SUSE Labs / Novell
Message-ID: <200903201345.23864.agruen@suse.de>
References: <200903181448.50706.agruen@suse.de> <alpine.DEB.1.00.0903201053280.10279@pacific.mpi-cbg.de> <adf1fd3d0903200533s2be08ee7t58a22180b1c886c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 13:49:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lke9z-0006pY-5F
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 13:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbZCTMrq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2009 08:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752758AbZCTMrq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 08:47:46 -0400
Received: from cantor.suse.de ([195.135.220.2]:49819 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481AbZCTMrq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 08:47:46 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id CC0EA6CB00;
	Fri, 20 Mar 2009 13:47:43 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <adf1fd3d0903200533s2be08ee7t58a22180b1c886c0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113952>

On Friday, 20 March 2009 13:33:18 Santi B=E9jar wrote:
> Can we use branch^{origin} instead? It is longer to type, but uses th=
e
> same syntax as the ^{tree}, ^{commit}, ^{tag} and you don't have to
> know how to produce the bell character.

=46or me this defeats the purpose; I can just as well type origin/branc=
h (or=20
whatever it is) instead of branch^{origin}.  I'm really looking for som=
ething=20
very short like % or %branch.

A notation for referring to the tracked branch in arbitrary contexts st=
ill=20
sounds like a good idea, and for that purpose, your proposal sounds use=
ful.

Thanks,
Andreas
