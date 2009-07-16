From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: Make a non-bare repo bare.
Date: Thu, 16 Jul 2009 09:55:27 +0100
Message-ID: <e2b179460907160155g7c84b083u8a1dd6ba193f4531@mail.gmail.com>
References: <c115fd3c0907151443h49aaac60r3462c69f55ed2d9f@mail.gmail.com>
	 <7vbpnlbbln.fsf@alter.siamese.dyndns.org> <h3mpls$9dt$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 11:00:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRMlG-0005n0-9O
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 10:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbZGPIzb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jul 2009 04:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbZGPIza
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 04:55:30 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:37694 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145AbZGPIz2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jul 2009 04:55:28 -0400
Received: by fxm18 with SMTP id 18so3949284fxm.37
        for <git@vger.kernel.org>; Thu, 16 Jul 2009 01:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=efXVVUzfYCxHXTEKjPdMrlPgknqg+QOqV86TFg7849k=;
        b=tlkPGHg8wH1zHUzzqTXu4pJh77XKk8U3hun/xPcWXxKXFuPf1VA757fh+n/iDRXnJM
         aKNwevGPvac+2ysJ99SxtJiPGLGudbxvViXobF+85Dn+Ld+s70lN4QQfXqulDVpJch/f
         psZCNWuAhPHm51E5RDmFFFmkzG6rqdrcTg3dA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ijn/YkL0r7Ecng1K0cdD+eU+ZM6fnja0356O0Ns2QKKduuw60vq0dkrwjZpnO3WYTV
         7Z+VRVxQK/DiYkJkYvZn7T3G9xnnpjsTYGsVwMCKhgk/0RJT/mXRS0Q9xTsoJ+6L6Z13
         guk3AIE9ZqY9NFlVYxgs1KBjA/p6jBl/c7++Q=
Received: by 10.223.109.148 with SMTP id j20mr4477179fap.43.1247734527616; 
	Thu, 16 Jul 2009 01:55:27 -0700 (PDT)
In-Reply-To: <h3mpls$9dt$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123391>

2009/7/16 Graeme Geldenhuys <graemeg@gmail.com>:
> Junio C Hamano wrote:
>>
>> Funny.
>>
>> =C2=A0 =C2=A0http://article.gmane.org/gmane.comp.version-control.git=
/123303
>>
>> It is posed as a question but describes the correct (and officially
>> supported) procedure.
>
>
> Now it deserves to be in some Git FAQ. It seems the issue is more com=
mon
> than I thought. :-)

It already is

http://git.or.cz/gitwiki/GitFaq#HowdoImakeexistingnon-barerepositorybar=
e.3F

unless that's new?
