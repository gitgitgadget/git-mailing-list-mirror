From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: core.whitespace space-in-indent feature request
Date: Wed, 19 Jan 2011 12:09:53 +0100
Message-ID: <4D36C681.7020400@viscovery.net>
References: <AANLkTikiHXofGVg9QECg9a4U4r4VGD1tb6oMV21nzd9W@mail.gmail.com> <1295380297.3778.47.camel@drew-northup.unet.maine.edu> <20205598.46894.1295382705010.JavaMail.trustmail@mail1.terreactive.ch> <09F2551C-40E6-40DC-BE97-8DCFF3601C8C@terreactive.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@terreactive.ch>
X-From: git-owner@vger.kernel.org Wed Jan 19 12:10:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfVvN-0006QM-Px
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 12:10:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab1ASLJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 06:09:56 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38595 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753650Ab1ASLJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 06:09:56 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PfVvG-0007gy-4h; Wed, 19 Jan 2011 12:09:54 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id DA5221660F;
	Wed, 19 Jan 2011 12:09:53 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <09F2551C-40E6-40DC-BE97-8DCFF3601C8C@terreactive.ch>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165262>

Am 1/19/2011 10:42, schrieb Victor Engmark:
> $ git config --add core.whitespace 'indent-with-non-tab,tabwidth=1'

tabwidth= is not in any released version of git, yet.

> Only the "SP HT" and "8 SP" indentations are colored; ...

This is no surprise, unless you are using a version that has commit
v1.7.4-rc0~52^2.

-- Hannes
