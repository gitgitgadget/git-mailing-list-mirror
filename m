From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Color support for "git-add -i"
Date: Wed, 5 Dec 2007 14:55:20 +0100
Message-ID: <EDEE4359-2706-4F8F-B8B8-A29334E752E2@wincent.com>
References: <7vbq95tnk7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dan Zwell <dzwell@zwell.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 14:56:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izuk6-0003d6-4w
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 14:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbXLEN43 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 08:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbXLEN43
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 08:56:29 -0500
Received: from wincent.com ([72.3.236.74]:37269 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbXLEN42 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 08:56:28 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB5DtL0w023085;
	Wed, 5 Dec 2007 07:55:21 -0600
In-Reply-To: <7vbq95tnk7.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67155>

El 5/12/2007, a las 11:59, Junio C Hamano escribi=F3:

> This is mostly lifted from earlier series by Dan Zwell, but updated t=
o
> use "git config --get-color" to make it simpler and more consistent =20
> with
> commands written in C.

Tested here and seems to work well. This is a nice little bit of =20
usability polish.

Cheers,
Wincent
