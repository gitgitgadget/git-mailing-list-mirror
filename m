From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: making HTTP push more robust and more
 user-friendly
Date: Mon, 14 Jan 2008 12:21:08 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0801141220001.8333@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1200250979-19604-1-git-send-email-gb@gbarbier.org> <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 12:21:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JENNt-0002Cg-Cv
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 12:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680AbYANLVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 06:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754194AbYANLVM
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 06:21:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:57305 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754253AbYANLVL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 06:21:11 -0500
Received: (qmail invoked by alias); 14 Jan 2008 11:21:09 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp039) with SMTP; 14 Jan 2008 12:21:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18yKTECiJEyBS5UANX7xqS0TjWH3iur/EOHQlv3bZ
	YDhdavCu/JCE2q
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vbq7ppbyh.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70454>

Hi,

On Sun, 13 Jan 2008, Junio C Hamano wrote:

> The second one to add a couple of "goto cleanup" looked correct.  Acks, 
> people?

I haven't used http-push in ages, but there was a bug report with msysgit.  
Hopefully that issue gets fixed by this patch.

Ciao,
Dscho
