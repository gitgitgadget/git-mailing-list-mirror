From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] test_must_fail: 129 is a valid error code from  
 usage()
Date: Tue, 25 Mar 2008 20:27:18 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803252026390.10660@wbgn129.biozentrum.uni-wuerzburg.de>
References: <200803232150.29971.barra_cuda@katamail.com> <200803241502.21465.barra_cuda@katamail.com> <7vwsnrubmd.fsf@gitster.siamese.dyndns.org> <200803242218.44026.barra_cuda@katamail.com> <7vbq53nvaz.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803251100520.10660@wbgn129.biozentrum.uni-wuerzburg.de> <47E8E04E.6060606@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junio@pobox.com>,
	Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 25 20:30:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeEqX-0004Pv-3G
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 20:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760079AbYCYT1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 15:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760073AbYCYT1W
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 15:27:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:41744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760066AbYCYT1V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 15:27:21 -0400
Received: (qmail invoked by alias); 25 Mar 2008 19:27:19 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp032) with SMTP; 25 Mar 2008 20:27:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/+FkiIhZ/bH6CsJF2NMBi1IcNUInjS/S5HQxXvJ
	49gv+kK0jypUeg
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <47E8E04E.6060606@viscovery.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78211>

Hi,

On Tue, 25 Mar 2008, Johannes Sixt wrote:

> This command:
> 
>    git branch foo bar baz
> 
> exits with 129 both when invoked by bash ($?) and CMD (%ERRORLEVEL%).

Thanks,
Dscho
