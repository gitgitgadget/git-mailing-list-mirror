From: Raimund Bauer <ray007@gmx.net>
Subject: Re: [PATCH] Teach "git apply" to prepend a prefix with
	"--root=<root>"
Date: Tue, 01 Jul 2008 20:10:48 +0200
Message-ID: <1214935848.6619.1.camel@doriath>
References: <alpine.DEB.1.00.0807010043440.9925@racer>
	 <7vvdzqnemk.fsf@gitster.siamese.dyndns.org> <486A55B0.9050404@zytor.com>
	 <alpine.LSU.1.00.0807011835090.32725@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 01 20:12:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDkKU-00050x-KZ
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 20:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYGASKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 14:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbYGASKw
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 14:10:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:32999 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750976AbYGASKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 14:10:51 -0400
Received: (qmail invoked by alias); 01 Jul 2008 18:10:49 -0000
Received: from chello084112102232.8.11.vie.surfer.at (EHLO [192.168.1.100]) [84.112.102.232]
  by mail.gmx.net (mp021) with SMTP; 01 Jul 2008 20:10:49 +0200
X-Authenticated: #20693823
X-Provags-ID: V01U2FsdGVkX1/e9fpx3K/ewVNpSLoxKatCTDSuhGkKdBL/ifKURW
	VL3b8pDnWniPfH
In-Reply-To: <alpine.LSU.1.00.0807011835090.32725@wbgn129.biozentrum.uni-wuerzburg.de>
X-Mailer: Evolution 2.22.2 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87060>

On Tue, 2008-07-01 at 18:36 +0200, Johannes Schindelin wrote:
> > There is an analogous concept in patch(1), it's just implemented by 
> > cd'ing to a subdirectory first.  ;)
> 
> Hey, "--cd=" is free!  And it would make explaining easier why -p is 
> applied first.

patch uses -d or --directory

regards,
Ray
