From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] rebase -i: use 'read -r' to avoid backslash acting as an 
	escape character
Date: Wed, 7 Jul 2010 11:22:29 +0200
Message-ID: <AANLkTinFu08juNtz5eYyjzxuW6zbyGyn5f4S3wh0TI0E@mail.gmail.com>
References: <20100706225522.GA31048@genesis.frugalware.org> 
	<7vpqyz278o.fsf@alter.siamese.dyndns.org> <20100707091633.GB31048@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 11:22:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWQqI-0001CJ-4o
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 11:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab0GGJWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 05:22:53 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:59392 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab0GGJWw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 05:22:52 -0400
Received: by bwz1 with SMTP id 1so4059020bwz.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 02:22:51 -0700 (PDT)
Received: by 10.204.84.18 with SMTP id h18mr4843730bkl.41.1278494570223; Wed, 
	07 Jul 2010 02:22:50 -0700 (PDT)
Received: by 10.204.78.141 with HTTP; Wed, 7 Jul 2010 02:22:29 -0700 (PDT)
In-Reply-To: <20100707091633.GB31048@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150460>

On Wed, Jul 7, 2010 at 11:16 AM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Tue, Jul 06, 2010 at 10:25:43PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>> Why do I feel a deja-vu for this patch?
>>
>
> Maybe this one:
>
> http://thread.gmane.org/gmane.comp.version-control.git/146999

No. This one:

http://article.gmane.org/gmane.comp.version-control.git/150328

:-)

Santi
