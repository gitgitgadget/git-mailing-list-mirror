From: Guanqun Lu <guanqun.lu@gmail.com>
Subject: Re: [PATCH 1/2] fix typo in Documentation
Date: Thu, 5 Feb 2009 14:27:41 +0800
Message-ID: <e57070790902042227r2d571b94h9b3a997d826a80d2@mail.gmail.com>
References: <1233781241-721-1-git-send-email-guanqun.lu@gmail.com>
	 <m38womwo2b.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 07:29:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUxjg-0004qk-Az
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 07:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbZBEG1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 01:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbZBEG1n
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 01:27:43 -0500
Received: from rv-out-0506.google.com ([209.85.198.237]:23476 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753908AbZBEG1m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 01:27:42 -0500
Received: by rv-out-0506.google.com with SMTP id k40so100061rvb.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 22:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xeAIjL0D8ekAEXBTlX9r/k+9enq5moV67oz+pMjbg6w=;
        b=NUwxl2cCYpux1O5pisA4Cg22ndtCjYF8OE7MVoVhkMaxGVnVEM7yofyBwdKQ2mbADb
         7uJUIO7uQPWhp4DK4Umpk8y24FpDjLGPBOle90GeCgnpMc+gTv3ilt01WziRsF+7kLpK
         Gy0r8qhlZqHaUB2PltWfUH9NISSVY598mmx14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f3WvN71iDiiFRmGyygfyRRESXbcCmiUWfTo4RoJXKhvVHYBvMVRob4Yk88gZOvH8XB
         ztddGVjYtbASLrDdbgqDrwKnXZyJ9KH/pRxs1Zxp6ZSiyzQlqd7wmUOfwLUaJf7w/B90
         ADk/g+LqNSJ3EmGoe2LEXFloDnP9oo6YTplvg=
Received: by 10.141.116.17 with SMTP id t17mr79503rvm.268.1233815261660; Wed, 
	04 Feb 2009 22:27:41 -0800 (PST)
In-Reply-To: <m38womwo2b.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108503>

On Wed, Feb 4, 2009 at 5:26 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Guanqun Lu <guanqun.lu@gmail.com> writes:
>
>> Signed-off-by: Guanqun Lu <guanqun.lu@gmail.com>
>> ---
>>  Documentation/technical/api-strbuf.txt |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> Minor nit: I would add _where_ did you fix typy, i.e. instead of just
>  fix typo in Documentation
> I'd use
>  fix typo in strbuf API documentation

OK. I'll keep an eye next time. And thanks for your advice.

>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>



-- 
Guanqun
