From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] whitespace: reorganize initial-indent check
Date: Sun, 16 Dec 2007 11:02:32 +0100
Message-ID: <B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org> <1197776919-16121-1-git-send-email-bfields@citi.umich.edu> <1197776919-16121-2-git-send-email-bfields@citi.umich.edu> <1197776919-16121-3-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "J. Bruce Fields" <bfields@citi.umich.edu>
X-From: git-owner@vger.kernel.org Sun Dec 16 11:03:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3qKr-0001C8-NK
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 11:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757274AbXLPKCj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Dec 2007 05:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758772AbXLPKCj
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 05:02:39 -0500
Received: from wincent.com ([72.3.236.74]:55153 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756757AbXLPKCi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Dec 2007 05:02:38 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBGA2YGr010504;
	Sun, 16 Dec 2007 04:02:36 -0600
In-Reply-To: <1197776919-16121-3-git-send-email-bfields@citi.umich.edu>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68452>

El 16/12/2007, a las 4:48, J. Bruce Fields escribi=F3:

> Reorganize to emphasize the most complicated part of the code (the ta=
b
> case).

Any chance of either squashing this series into one patch seeing as =20
its all churning over the same part of the code, or resending it with =20
numbering? The patches seemed to arrive out of order in my mailbox and =
=20
I don't really know what order they're supposed to be applied in and =20
it's a bit hard to review.

Cheers,
Wincent
