From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/11 v2] Fix warnings in nedmalloc when compiling with GCC 4.4.0
Date: Tue, 9 Jun 2009 08:06:51 +0200
Message-ID: <CD46A3E1-A85C-4D03-854C-973B91ACC506@zib.de>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de> <1243786525-4493-2-git-send-email-prohaska@zib.de> <1243786525-4493-3-git-send-email-prohaska@zib.de> <1243786525-4493-4-git-send-email-prohaska@zib.de> <1243786525-4493-5-git-send-email-prohaska@zib.de> <1243786525-4493-6-git-send-email-prohaska@zib.de> <1243786525-4493-7-git-send-email-prohaska@zib.de> <1243786525-4493-8-git-send-email-prohaska@zib.de> <1243786525-4493-9-git-send-email-prohaska@zib.de> <1243786525-4493-10-git-send-email-prohaska@zib.de> <1243786525-4493-11-git-send-email-prohaska@zib.de> <7vhbz0mmai.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de> <7vr5y3lxrj.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906021448300.4440@intel-tinevez-2-302> <7viqjefxcv.fsf@alter.siame
 se.dyndns.org> <alpine.DEB.1.00.0906031455520.10241@intel-tinevez-2-302> <7vprdl9qon.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906081645490.4461@intel-tinevez-2-302> <7vzlcizn3w.fsf@a!
 lter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 08:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDuUS-0000OA-8X
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 08:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbZFIGHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 02:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbZFIGHL
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 02:07:11 -0400
Received: from mailer.zib.de ([130.73.108.11]:42184 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbZFIGHK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 02:07:10 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id n5966wK3008277;
	Tue, 9 Jun 2009 08:07:03 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db94a6f.pool.einsundeins.de [77.185.74.111])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id n5966vBq023670
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 9 Jun 2009 08:06:57 +0200 (MEST)
In-Reply-To: <7vzlcizn3w.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121141>


On Jun 8, 2009, at 6:50 PM, Junio C Hamano wrote:

> Steffen, can we move the series, with this patch replaced, to 'next'  
> now?
> I think it looks good (thanks!) but again it would not hurt to ask  
> just to
> make sure ;-).

I agree, it looks good.  Thanks.

	Steffen
