From: Andreas Ericsson <ae@op5.se>
Subject: Re: List of directories containing only ignored files
Date: Thu, 06 Oct 2011 16:03:52 +0200
Message-ID: <4E8DB548.5030108@op5.se>
References: <CAC9GOO__nN9W1vvoMxq2LKnn=YoFPjTE6jKPbQ2h7im3JtujQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?UTF-8?B?TWFyY2luIFdpxZtuaWNraQ==?= <mwisnicki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 16:04:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBoYZ-00007w-4o
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 16:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935159Ab1JFOEJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 10:04:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47893 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab1JFOEI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 10:04:08 -0400
Received: by bkbzt4 with SMTP id zt4so3489862bkb.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 07:04:06 -0700 (PDT)
Received: by 10.204.154.28 with SMTP id m28mr629841bkw.84.1317909845306;
        Thu, 06 Oct 2011 07:04:05 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPS id ex8sm5686858bkc.2.2011.10.06.07.04.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 07:04:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.22) Gecko/20110906 Fedora/3.1.14-1.fc14 Thunderbird/3.1.14 ThunderGit/0.1a
In-Reply-To: <CAC9GOO__nN9W1vvoMxq2LKnn=YoFPjTE6jKPbQ2h7im3JtujQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182953>

On 10/06/2011 03:56 PM, Marcin Wi=C5=9Bnicki wrote:
>
> Alternatively: how to remove such leftovers when switching branches ?

git clean -X -f

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
