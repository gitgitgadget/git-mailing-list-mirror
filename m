From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (May 2011, #06; Fri, 13)
Date: Sun, 15 May 2011 18:50:05 +0200
Message-ID: <4DD0043D.1050101@web.de>
References: <7vd3jm74gv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 18:50:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLeWL-0004kY-3S
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 18:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760103Ab1EOQuO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 12:50:14 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:53984 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab1EOQuN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 12:50:13 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 907C218EB539F;
	Sun, 15 May 2011 18:50:08 +0200 (CEST)
Received: from [93.240.120.226] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QLeW8-0000JJ-00; Sun, 15 May 2011 18:50:08 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vd3jm74gv.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19Efo8x6WjKfTMOyTm9cJ6OrcdRBSCMGi3opapY
	L0Ix1IW/EpvAVP59T7FmHEElLZH+kvZdFClle5UB2Z6nEi7MHH
	Rvwjek3tsUjfg85onz/A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173640>

Am 13.05.2011 22:03, schrieb Junio C Hamano:
> * jl/read-tree-m-dry-run (2011-05-11) 1 commit
>  - Teach read-tree the -n|--dry-run option
> 
> Looked good. We _might_ want to make -n simply ignore -u, though.

Fine by me. Do you want me to send an updated version? If so,
should a warning be issued in that case or should that just
happen silently?
