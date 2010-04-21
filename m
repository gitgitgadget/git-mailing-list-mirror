From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] date.c: print "1 second ago", not "1 seconds ago"
Date: Wed, 21 Apr 2010 08:13:17 +0200
Message-ID: <4BCE977D.9040700@viscovery.net>
References: <1271827860-20947-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?IsOYeXZpbmQgQS4gSG9sbSI=?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Wed Apr 21 08:13:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4TBh-000183-F2
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 08:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142Ab0DUGNV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 02:13:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53152 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912Ab0DUGNV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 02:13:21 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O4TBW-0005WB-5b; Wed, 21 Apr 2010 08:13:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C7A851660F;
	Wed, 21 Apr 2010 08:13:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <1271827860-20947-1-git-send-email-sunny@sunbase.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145407>

Am 4/21/2010 7:31, schrieb =C3=98yvind A. Holm:
> When using --date=3Drelative, print "1 second ago" instead of "1 seco=
nds
> ago".

Why do you care only about about "1 seconds", but not "1 minutes", "1
hours", etc? I mean, "1 seconds ago" is the most unlikely case of them =
all
that will happen in practice...

-- Hannes
