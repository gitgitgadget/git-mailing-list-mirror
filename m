From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] builtin-apply: fix typo leading to stack corruption
Date: Thu, 9 Oct 2008 09:04:28 -0700
Message-ID: <20081009160428.GB29829@spearce.org>
References: <48ed30f5.0707d00a.2994.6f1e@mx.google.com> <7v4p3mors6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Imre Deak <imre.deak@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 18:06:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kny1P-0000Yu-60
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 18:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757845AbYJIQEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 12:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757955AbYJIQEb
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 12:04:31 -0400
Received: from george.spearce.org ([209.20.77.23]:49212 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757725AbYJIQE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 12:04:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CC0E438377; Thu,  9 Oct 2008 16:04:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7v4p3mors6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97865>

Junio C Hamano <gitster@pobox.com> wrote:
> Looks good and would look better with a sign-off.

I'm holding off on applying this change for a little, hoping Imre
can give us a sign off, but really I don't think anyone can claim
copyright to the < sign.  If they can, we're in big trouble.  :-)

-- 
Shawn.
