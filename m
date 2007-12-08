From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 2/2] shortlog: code restruturing and clean-up
Date: Sat, 8 Dec 2007 10:34:39 +0100
Message-ID: <BDA543BC-4D4E-4718-BC29-B4317C44EB90@wincent.com>
References: <1197077573-14945-1-git-send-email-gitster@pobox.com> <1197077573-14945-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 08 10:35:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0w5Q-0007He-9y
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 10:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321AbXLHJen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Dec 2007 04:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756251AbXLHJen
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 04:34:43 -0500
Received: from wincent.com ([72.3.236.74]:33891 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756173AbXLHJem convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Dec 2007 04:34:42 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB89Ye1u016607;
	Sat, 8 Dec 2007 03:34:41 -0600
In-Reply-To: <1197077573-14945-2-git-send-email-gitster@pobox.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67535>

El 8/12/2007, a las 2:32, Junio C Hamano escribi=F3:

> The code tried to parse and clean-up the author name and the one line
> information in three places (two callers of insert_author_oneline() =20
> and
> the called function itself), whihc was a mess.

whihc -> which

Cheers,
Wincent
