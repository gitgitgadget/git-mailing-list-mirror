From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Mon, 22 Feb 2010 11:01:14 +0100
Message-ID: <201002221101.15195.trast@student.ethz.ch>
References: <7vtytacebd.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.1002220936030.20986@pacific.mpi-cbg.de> <201002221048.59188.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: =?iso-8859-15?q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 22 12:34:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjV6V-0004Km-St
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 11:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab0BVKBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 05:01:23 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:45083 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab0BVKBW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 05:01:22 -0500
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 11:01:16 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Mon, 22 Feb
 2010 11:01:15 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <201002221048.59188.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140663>

On Monday 22 February 2010 10:48:58 Thomas Rast wrote:
> 
> You mean this one?
> 
>   http://permalink.gmane.org/gmane.comp.version-control.git/108330

And I forgot to add... yes, it's in contrib (contrib/git-resurrect.sh)
since 1.6.2.  It can be used to figure out topic heads from pu, even
thought that's not really resurrecting them.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
