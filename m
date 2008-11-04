From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in packs
 with a .keep file
Date: Tue, 04 Nov 2008 14:01:34 -0600
Message-ID: <1ophgqBEnDgFkf-pSe86Z994lgPAXHwUH75NBIVGKfTk8Pz5M-x34Q@cipher.nrlssc.navy.mil>
References: <20081103161202.GJ15463@spearce.org> <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil> <49109FD4.30003@op5.se> <V78jOMhdYwpSlLU-YzsqEHZxJyrvKbXRQbKsuNPZOEtB8E0kZ5Wi7Q@cipher.nrlssc.navy.mil> <7vmygfqn92.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 21:04:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxS7X-0008Cx-RI
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 21:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753873AbYKDUCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 15:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbYKDUCJ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 15:02:09 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38117 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbYKDUCI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 15:02:08 -0500
Received: by mail.nrlssc.navy.mil id mA4K1ZLb005723; Tue, 4 Nov 2008 14:01:35 -0600
In-Reply-To: <7vmygfqn92.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 04 Nov 2008 20:01:35.0248 (UTC) FILETIME=[23CF9100:01C93EB8]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100101>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:

>>    sed -n -e '$q' -e 'p'
> 
> You surely meant "sed -e '$d'", right?

Your sed-fu is quite impressive.

-b
