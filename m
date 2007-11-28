From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Link porcelain commands from gitexecdir to bindir
Date: Wed, 28 Nov 2007 12:11:20 -0800
Message-ID: <7v1waa5dw7.fsf@gitster.siamese.dyndns.org>
References: <20071128162629.GA5453@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 21:12:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxTGQ-0005Jt-VE
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 21:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758902AbXK1UL1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Nov 2007 15:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758214AbXK1UL1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 15:11:27 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:43340 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541AbXK1UL0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Nov 2007 15:11:26 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1121E2F9;
	Wed, 28 Nov 2007 15:11:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 44E0F9AAD6;
	Wed, 28 Nov 2007 15:11:45 -0500 (EST)
In-Reply-To: <20071128162629.GA5453@laptop> (=?utf-8?B?Tmd1eeG7hW4gVGg=?=
 =?utf-8?B?w6FpIE5n4buNYw==?= Duy's message of
	"Wed, 28 Nov 2007 23:26:29 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66419>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

>  The porcelain list needs eyeballs.

The source of porcelain list needs consolidation first.  See a patch
from me in the last couple of days to contrib/completion and
generate-cmdlist.sh for ideas, for example.
