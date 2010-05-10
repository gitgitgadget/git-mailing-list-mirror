From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix a false negative in t5512 when run using sh -x
Date: Mon, 10 May 2010 13:34:32 +0200
Message-ID: <4BE7EF48.2080905@viscovery.net>
References: <1273475946-2079-1-git-send-email-j6t@kdbg.org> <AANLkTilaZlku8eQpAjMPCPkzeVyg2u21KOcsZkxn4Kxd@mail.gmail.com> <20100510103427.GA4806@progeny.tock> <4BE7E7FD.7080607@viscovery.net> <20100510113113.GA5162@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 10 13:34:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBRFz-0008GM-3I
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 13:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab0EJLej (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 07:34:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29128 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab0EJLeh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 07:34:37 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OBRFp-0001Dj-45; Mon, 10 May 2010 13:34:33 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D4EFA1660F;
	Mon, 10 May 2010 13:34:32 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100510113113.GA5162@progeny.tock>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146799>

Am 5/10/2010 13:31, schrieb Jonathan Nieder:
> t9108 seems to have the same problem.  Maybe you skip svn tests?

Yes, I skip svn tests.

-- Hannes
