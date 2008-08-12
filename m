From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: [PATCH v2] Make cherry-pick use rerere for conflict resolution.
Date: Tue, 12 Aug 2008 08:04:11 +0530
Message-ID: <20080812023411.GA14831@toroid.org>
References: <1218368935-31124-1-git-send-email-ams@toroid.org> <alpine.DEB.1.00.0808110111430.24820@pacific.mpi-cbg.de.mpi-cbg.de> <20080811023053.GA9144@toroid.org> <7vmyjjxuca.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 04:35:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSjjS-000105-AE
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 04:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbYHLCeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 22:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbYHLCeQ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 22:34:16 -0400
Received: from fugue.toroid.org ([85.10.196.113]:41268 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705AbYHLCeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 22:34:16 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id B3AFA5583C5;
	Tue, 12 Aug 2008 04:34:14 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id D476BADC36D; Tue, 12 Aug 2008 08:04:11 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <7vmyjjxuca.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92062>

At 2008-08-11 11:47:01 -0700, gitster@pobox.com wrote:
>
> I do not think that story is a good example.

I agree, it's a stretch.

I can't think of any better rationale for the change than "It might
conceivably be convenient to someone at some point", which falls a
fair bit short of being convincing.

To be honest, it took so little time to implement this suggestion that
I didn't realise until later that there was no realistic use-case and
nothing to say about the patch.

Sorry for the noise.

-- ams
