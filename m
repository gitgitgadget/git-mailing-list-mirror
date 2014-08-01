From: Hartmut Henkel <henkel@vh-s.de>
Subject: Re: [PATCH] l10n: de.po: fix typo
Date: Fri, 1 Aug 2014 15:37:07 +0200 (CEST)
Message-ID: <alpine.DEB.2.02.1408011535110.18761@hahepc.vhs>
References: <1402503455-20503-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-311820639-1406900227=:18761"
Cc: git@vger.kernel.org, tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 16:01:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDDOM-0006bh-5S
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 16:01:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398AbaHAOBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 10:01:00 -0400
Received: from vh-s.de ([176.9.63.7]:45040 "EHLO vh-s.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327AbaHAOA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 10:00:59 -0400
X-Greylist: delayed 1423 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Aug 2014 10:00:59 EDT
Received: from p5dcc4fbc.dip0.t-ipconnect.de ([93.204.79.188] helo=vhssv2.vhs)
	by vh-s.de with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <henkel@vh-s.de>)
	id 1XDD19-0000CE-Dk; Fri, 01 Aug 2014 15:37:13 +0200
Received: from hahepc.vhs ([192.168.0.3])
	by vhssv2.vhs with esmtp (Exim 4.80)
	(envelope-from <henkel@vh-s.de>)
	id 1XDD19-0000Ew-Ix; Fri, 01 Aug 2014 15:37:07 +0200
Received: from hahe (helo=localhost)
	by hahepc.vhs with local-esmtp (Exim 4.80)
	(envelope-from <henkel@vh-s.de>)
	id 1XDD19-0004un-Ep; Fri, 01 Aug 2014 15:37:07 +0200
In-Reply-To: <1402503455-20503-1-git-send-email-ralf.thielow@gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-SA-Exim-Connect-IP: 93.204.79.188
X-SA-Exim-Mail-From: henkel@vh-s.de
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on mailserver
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED shortcircuit=no
	autolearn=disabled version=3.3.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on vh-s.de)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254627>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-311820639-1406900227=:18761
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Dear Ralf,

thanks a lot for signing off the tiny patch below. Yet somehow it didn't 
make it into git version 2.1.0.rc0.52.gaa544bf.

Regards, Hartmut


On Wed, 11 Jun 2014, Ralf Thielow wrote:

> Reported-by: Hartmut Henkel
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/po/de.po b/po/de.po
> index b777ef4..88d10ed 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -10551,13 +10551,13 @@ msgstr "Bitte committen Sie die Änderungen oder benutzen Sie \"stash\"."
>  #: git-rebase.sh:577
>  #, sh-format
>  msgid "Current branch $branch_name is up to date."
> -msgstr "Aktueller Branch $branch_name ist auf dem neusten Stand."
> +msgstr "Aktueller Branch $branch_name ist auf dem neuesten Stand."
>  
>  #: git-rebase.sh:581
>  #, sh-format
>  msgid "Current branch $branch_name is up to date, rebase forced."
>  msgstr ""
> -"Aktueller Branch $branch_name ist auf dem neusten Stand, Rebase erzwungen."
> +"Aktueller Branch $branch_name ist auf dem neuesten Stand, Rebase erzwungen."
>  
>  #: git-rebase.sh:592
>  #, sh-format
> -- 
> 2.0.0.415.g8cd8cf8
--8323329-311820639-1406900227=:18761--
