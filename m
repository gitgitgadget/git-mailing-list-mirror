From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] octopus: make merge process simpler to follow
Date: Sat, 12 Dec 2009 20:56:58 +0100
Message-ID: <200912122056.59297.j6t@kdbg.org>
References: <87zl5p1gsp.fsf@jondo.cante.net> <1260578339-30750-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jari Aalto <jari.aalto@cante.net>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 02:32:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJdK1-0006CK-1I
	for gcvg-git-2@lo.gmane.org; Sun, 13 Dec 2009 02:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720AbZLMBcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2009 20:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755699AbZLMBcQ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Dec 2009 20:32:16 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:29413 "HELO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S933482AbZLMBcP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2009 20:32:15 -0500
Received: from bsmtp.bon.at (unknown [172.18.12.54])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 47DDFCE031
	for <git@vger.kernel.org>; Sat, 12 Dec 2009 20:59:26 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 432D0CDF82;
	Sat, 12 Dec 2009 20:57:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9402419F6B8;
	Sat, 12 Dec 2009 20:56:59 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1260578339-30750-1-git-send-email-bebarino@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135144>

On Samstag, 12. Dezember 2009, Stephen Boyd wrote:
> +	pretty_name="$(eval echo \$GITHEAD_$SHA1)"

	eval pretty_name=\$GITHEAD_$SHA1

:)

-- Hannes
