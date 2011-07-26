From: =?ISO-8859-2?Q?Tajti_=C1kos?= <akos.tajti@intland.com>
Subject: ls-tree with non-english characters
Date: Tue, 26 Jul 2011 11:38:59 +0200
Message-ID: <4E2E8B33.6070900@intland.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 11:39:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qle6a-0008Uh-3v
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 11:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266Ab1GZJjG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 05:39:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:61390 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab1GZJjE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 05:39:04 -0400
Received: from [192.168.1.100] (77-234-81-149.pool.digikabel.hu [77.234.81.149])
	by mrelayeu.kundenserver.de (node=mreu2) with ESMTP (Nemesis)
	id 0MTtPJ-1Qup3F2ia9-00Qhaa; Tue, 26 Jul 2011 11:39:01 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; hu; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
X-Provags-ID: V02:K0:1kzLuRKu5uVvHTmV3eHrzKMuXLqDnm78Kz1rbXii+wr
 PtcAlTY9suLwVqD3zg5eXdjKRYgfk7X6L0A44h4mT/8Lcg8P7f
 7304l5bE8oMckeYqhWG0mgaIAvBJFjnzXumc0frAt4nPtDmYRf
 XXVYT6iHDDHrps6mAz8L0NB1qxVPNz4dWdCXOBIEkTnaOr5fVa
 1vT9ZC08w5OJ2dbLT5vKSRqtrH7SFVvbxwOLaB01MA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177849>

Dear List,

I tried to use git ls-tree but on blob names containing non-english
characters I get a strange output. For example:

=E1kos=FB -> \303\241kos\305\261

There's no mention of this format in the manual of ls-tree. Could you p=
lease
help me on resolving this cryptic string to the original form?

Thanks in advance,
=C1kos Tajti
