From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Documentation: always respect core.worktree if set
Date: Tue, 29 Dec 2009 18:05:55 +0100
Message-ID: <200912291805.55272.robin.rosenberg@dewire.com>
References: <7viqbrv4pa.fsf@alter.siamese.dyndns.org> <1262072921-11280-1-git-send-email-pclouds@gmail.com> <7v7hs5hg46.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 18:06:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPfWL-0007X8-H0
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 18:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbZL2RGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 12:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752044AbZL2RGF
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 12:06:05 -0500
Received: from mail.dewire.com ([83.140.172.130]:25770 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808AbZL2RGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 12:06:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 8B5DA8026C6;
	Tue, 29 Dec 2009 18:05:58 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8L9+EZ8NMgmf; Tue, 29 Dec 2009 18:05:57 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.5])
	by dewire.com (Postfix) with ESMTP id 71AA8145A5B1;
	Tue, 29 Dec 2009 18:05:57 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-generic; KDE/4.3.2; i686; ; )
In-Reply-To: <7v7hs5hg46.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135815>

tisdagen den 29 december 2009 17.58.17 skrev  Junio C Hamano:
> Thanks; I'll take this "match documentation to reality with caveats" patch
> for now, but I personally think we should revisit the issue someday.
> 

I'm happy with this.

-- robin
