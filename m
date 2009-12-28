From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH] Allow git to use any HTTP authentication method.
Date: Mon, 28 Dec 2009 20:10:12 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912282008320.5582@cone.home.martin.st>
References: <200912281154.09442.lenaic@lhuard.fr.eu.org> <alpine.DEB.2.00.0912281406210.5582@cone.home.martin.st> <be6fef0d0912280412w58401f10n972f9198144cd580@mail.gmail.com> <20091228153701.GA2252@spearce.org> <alpine.DEB.2.00.0912281745540.5582@cone.home.martin.st>
 <20091228155346.GB2252@spearce.org> <be6fef0d0912280915k1320110o6a361a0950aa60f6@mail.gmail.com> <7vd41zrn4n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	=?ISO-8859-15?Q?L=E9na=EFc_Huard?= <lenaic@lhuard.fr.eu.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 28 19:10:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPK3L-0004lW-Og
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 19:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbZL1SKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 13:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbZL1SKn
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 13:10:43 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:59458 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751394AbZL1SKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 13:10:43 -0500
Received: from [88.193.196.75] (88.193.196.75) by kirsi2.inet.fi (8.5.014)
        id 4B17EFA60105B95E; Mon, 28 Dec 2009 20:10:33 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <7vd41zrn4n.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135751>

On Mon, 28 Dec 2009, Junio C Hamano wrote:

> Would it be just a matter of queueing something like this on top of
> b8ac923 (Add an option for using any HTTP authentication scheme, not only
> basic, 2009-11-27)?

Looks good to me:

Acked-by: Martin Storsjo <martin@martin.st>

// Martin
