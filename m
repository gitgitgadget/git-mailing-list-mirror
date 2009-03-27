From: "Etienne Vallette d'Osia" <dohzya@gmail.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 12:30:32 +0100
Message-ID: <49CCB8D8.2040603@gmail.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>, <20090327090554.5d6160f2@pc09.procura.nl> <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de> <49CCB129.1070606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "H.Merijn Brand" <h.m.brand@xs4all.nl>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Mar 27 12:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnAIB-0006nL-JH
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 12:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbZC0Lai convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 07:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbZC0Lah
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 07:30:37 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:31233 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbZC0Lah (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 07:30:37 -0400
Received: by fk-out-0910.google.com with SMTP id 18so429706fkq.5
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 04:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=WB9qGzekWls/VyVTyV/sqQGXGSZ14mAwjG5/Oj0Q8Ps=;
        b=aEvl5El85xCbydB7tSKd5xcj1a0YfEmAFLe98g96KMtPJwJjaFG7f/Xgb5Ggz47Q4H
         rGDPqBdo7Xq5vZVI8C5oF8LKYhKJc6jm8e8iTRY+ne9YhJWzZbiRo+wAKKv69EG/7ue4
         X/ESw4wZVidDOvod6nLRnCIJIs/YtzJUAYGw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=rFrVBNJKSIUnM02iP2inVP1jmSc49RQ8xk5Ct6S6r0hkZvGD9SmIMoWeD2MNO9YzhD
         Fj0tnko3cyjTdRLQAwlZCfGZzLRrtwIW0XDPG3lZTwIaq2xc4BVPEbQGHKhDa++Q/sAZ
         o+l4L3kM5ZUAIwE15pe1xg2si8xrXs2y48oe0=
Received: by 10.103.250.1 with SMTP id c1mr381700mus.64.1238153434176;
        Fri, 27 Mar 2009 04:30:34 -0700 (PDT)
Received: from schubby.inria.fr (schubby.inria.fr [138.96.218.89])
        by mx.google.com with ESMTPS id 14sm2934875muo.50.2009.03.27.04.30.33
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 27 Mar 2009 04:30:33 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <49CCB129.1070606@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114882>

Etienne Vallette d'Osia a =E9crit :
> Ulrich Windl a =E9crit :
>>>> 3) "git undo": If possible undo the effects of the last command.
>>
>> If impossible, add confirmations for some "dangerous" (non-obvious)=20
>> commands before doing possibly harmful things. Maybe adding a kind o=
f=20
>> "user-level setting" (novice, expert, guro) could control such=20
>> confirmations.
>>
> Why ?
Oops, I have readed "it is impossible"
