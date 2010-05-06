From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Any way to get complete diff up to a tag?
Date: Thu, 06 May 2010 15:03:40 +0200
Message-ID: <4BE2BE2C.8050403@viscovery.net>
References: <A612847CFE53224C91B23E3A5B48BAC74482E50D9F@xmail3.se.axis.com> <20100506094212.GB9921@atjola.homenet> <A612847CFE53224C91B23E3A5B48BAC74482E50DE7@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu May 06 15:04:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA0k9-0006oU-Tj
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 15:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758105Ab0EFNDp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 09:03:45 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58011 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758100Ab0EFNDo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 09:03:44 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OA0jt-00070f-Ce; Thu, 06 May 2010 15:03:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1F9541660F;
	Thu,  6 May 2010 15:03:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74482E50DE7@xmail3.se.axis.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146479>

Am 5/6/2010 13:20, schrieb Peter Kjellerstedt:
> Bj=F6rn Steinbrink
>> git internally knows about the empty tree, so you can use:
>> git diff 4b825dc642cb6eb9a060e54bf8d69288fbee4904 v1.7.1
>>
>> Bj=F6rn
>=20
> Thank you, that was useful. However, I need to be able to do this
> for an arbitrary repository, and that SHA seems to be specific for=20
> the git repository. How do I get the SHA for the empty tree in an=20
> arbitrary repository?

Aha, so you think Bj=F6rn et.al. were able to guess the SHA1 for your
specific repository? ;)

No, the empty tree is the empty tree, and its name is as cited above, n=
o
matter where in the universe you are.

-- Hannes
