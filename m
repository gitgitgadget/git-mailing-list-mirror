From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Only update the cygwin-related configuration during
	state auto-setup
Date: Thu, 23 Oct 2008 20:36:30 +0200
Message-ID: <20081023183630.GA4905@blimp.localdomain>
References: <81b0412b0810230607sfea05ddm62bd03f837fc922e@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, spearce@spearce.org, dpotapov@gmail.com,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 23 20:37:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kt548-0002p0-FW
	for gcvg-git-2@gmane.org; Thu, 23 Oct 2008 20:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411AbYJWSgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 14:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755215AbYJWSgf
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 14:36:35 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:53743 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477AbYJWSge (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 14:36:34 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8A081of0=
Received: from tigra.home (Fac0e.f.strato-dslnet.de [195.4.172.14])
	by post.webmailer.de (klopstock mo31) (RZmta 17.14)
	with ESMTP id e040e7k9NHMNBJ ; Thu, 23 Oct 2008 20:36:30 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 8BD9A277C8;
	Thu, 23 Oct 2008 20:36:30 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 472A236D27; Thu, 23 Oct 2008 20:36:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0810230607sfea05ddm62bd03f837fc922e@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98981>

Err... It should be: "Only update the cygwin-related configuration
during stat auto-setup".
