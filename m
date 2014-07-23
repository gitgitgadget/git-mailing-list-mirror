From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 1/3] completion: complete "unstuck" `git push
 --recurse-submodules`
Date: Wed, 23 Jul 2014 20:35:36 +0100
Message-ID: <20140723193536.GE26927@serenity.lan>
References: <e9576136c09dbf65c5e614f9272d2c2afa96f5b6.1405763157.git.john@keeping.me.uk>
 <8303c95dd3e3ee8d77d4b994bb2d33b6a155a17f.1406053442.git.john@keeping.me.uk>
 <xmqqr41df8hu.fsf@gitster.dls.corp.google.com>
 <20140722205730.GD26927@serenity.lan>
 <xmqqha29f606.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:38:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA2MR-0007LD-1E
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 21:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932997AbaGWThz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 15:37:55 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:33243 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387AbaGWThy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 15:37:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 0D6E922D4C;
	Wed, 23 Jul 2014 20:37:54 +0100 (BST)
X-Quarantine-ID: <k4etY1Ug7t-F>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id k4etY1Ug7t-F; Wed, 23 Jul 2014 20:37:49 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 7D99E22F69;
	Wed, 23 Jul 2014 20:35:38 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqha29f606.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254113>

On Tue, Jul 22, 2014 at 02:17:13PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Do you want me to re-roll with this change or can you replace the patch
> > while applying?
> 
> I think I had to flip the third one to adjust to the change I
> suggested to this; the result will be on 'pu', so please double
> check when I push it out.

The result on jk/more-push-completion looks good.  Thanks.
