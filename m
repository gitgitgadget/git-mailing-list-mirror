From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 15:22:49 +0100
Message-ID: <adf1fd3d1003230722t338c140an527b77f4023c9729@mail.gmail.com>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com>
	 <1269353235.14299.0.camel@kheops>
	 <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: sylvain@abstraction.fr, git@vger.kernel.org
To: Howard Miller <howardsmiller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 15:27:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu54x-0006Pe-FU
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 15:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753834Ab0CWOWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 10:22:51 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:33159 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab0CWOWv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 10:22:51 -0400
Received: by ewy8 with SMTP id 8so466286ewy.28
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 07:22:50 -0700 (PDT)
Received: by 10.103.4.4 with SMTP id g4mr1367484mui.80.1269354169605; Tue, 23 
	Mar 2010 07:22:49 -0700 (PDT)
In-Reply-To: <26ae428a1003230713y12f0c74dh3b22c0d97565159b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143018>

On Tue, Mar 23, 2010 at 3:13 PM, Howard Miller
<howardsmiller@googlemail.com> wrote:
>>
>> git push origin +local_branch:remote_branch
>>
>
> Thanks!
>
> Tell me more about that '+'. I've never heard of it before. Can't see
> anything in the docs (although I'm probably not looking in the right
> place)

man git-push and search for '+', there is even an example like the
command above.

HTH,
Santi
