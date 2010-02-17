From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: make test fails with git 1.7.0 on my debian
Date: Wed, 17 Feb 2010 11:40:57 +0100
Message-ID: <4B7BC7B9.3040706@abstraction.fr>
References: <7fce93be1002160818p1095b251s281dcd0b644ca519@mail.gmail.com> <robbat2-20100216T162259-829076679Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 11:45:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhhPC-0002W9-UZ
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 11:45:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab0BQKpK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 05:45:10 -0500
Received: from lo.gmane.org ([80.91.229.12]:40283 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab0BQKpH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 05:45:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NhhP0-0002ND-8A
	for git@vger.kernel.org; Wed, 17 Feb 2010 11:45:06 +0100
Received: from laubervilliers-151-12-10-189.w193-252.abo.wanadoo.fr ([193.252.57.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 11:45:06 +0100
Received: from sylvain by laubervilliers-151-12-10-189.w193-252.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 11:45:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: laubervilliers-151-12-10-189.w193-252.abo.wanadoo.fr
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; fr; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <robbat2-20100216T162259-829076679Z@orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140230>

Le 16/02/2010 17:23, Robin H. Johnson a =E9crit :
> On Tue, Feb 16, 2010 at 05:18:07PM +0100, Sylvain Rabot wrote:
>> root@numerobis:~/src/git-1.7.0# uname -a
>> Linux numerobis 2.6.26-2-686 #1 SMP Wed Nov 4 20:45:37 UTC 2009 i686=
 GNU/Linux
>> root@numerobis:~/src/git-1.7.0# make test
> Don't run the tests as root.
>

My mistake.

Thank you.
