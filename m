From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH] git-blame.el: Change how blame information is shown.
Date: Tue, 29 Sep 2009 15:39:21 +0200
Message-ID: <87ab0dj2eu.fsf@lysator.liu.se>
References: <1254230666-18283-1-git-send-email-davidk@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 29 15:59:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsdFF-0006ZO-MI
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 15:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbZI2N7r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Sep 2009 09:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbZI2N7r
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 09:59:47 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:54896 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbZI2N7r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 09:59:47 -0400
X-Greylist: delayed 1228 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2009 09:59:46 EDT
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 692344005A;
	Tue, 29 Sep 2009 15:38:37 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 5BD1A40072; Tue, 29 Sep 2009 15:38:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [62.20.90.206])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 1B3EF4005A;
	Tue, 29 Sep 2009 15:38:37 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 6829060E08; Tue, 29 Sep 2009 15:39:21 +0200 (CEST)
In-Reply-To: <1254230666-18283-1-git-send-email-davidk@lysator.liu.se>
	(David@krank.kagedal.org's message of "Tue, 29 Sep 2009 15:24:26
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129302>

>From: David@krank.kagedal.org, K=C3=A5gedal@krank.kagedal.org, davidk@=
lysator.liu.se

Sorry about the broken from address.

--=20
David K=C3=A5gedal
