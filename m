From: Ittay Dror <ittay.dror@gmail.com>
Subject: Re: [OFF TOPIC] any views about the D programming language
Date: Thu, 26 Jun 2008 14:43:13 +0300
Message-ID: <486380D1.4090904@gmail.com>
References: <48635047.30707@gmail.com> <alpine.DEB.1.00.0806261210120.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 13:45:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBpuP-0007Sg-7R
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 13:45:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560AbYFZLoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 07:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755131AbYFZLoD
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 07:44:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:16614 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524AbYFZLoB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 07:44:01 -0400
Received: by ug-out-1314.google.com with SMTP id h2so229115ugf.16
        for <git@vger.kernel.org>; Thu, 26 Jun 2008 04:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=4UgaxUlloTo2FMyaktuM+lplPpT+aGAjrVZTLtf/MP8=;
        b=BNrxoHTf7IiT4Eu6Ceqz0wmfc3rUO3Xx8EcIgOdp2O8lJWp8wzqksUJaZGFh6zwgLH
         WAkLyUlOEEMdYwraki71xGNRaxtlcyezCoi785JY7csNyhRTupcco6dG0hHdWmgBzvU/
         ASu9a4ThzzyZTPRpGnWLoLY149uyowtc6DJK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=exwVWnFl26h7asVRxoyDZt4LSjs3UjZyOaWYE437tv5xrx/8R+sEj7PvXT2MaDVMRu
         1ZG92CBC3MNZSYB1txz9XMwVtKxXt9TUCKDPy9YBIROMImTl0+am5Ie8wCp3g5Eh+bVk
         lTkTvEgoc+2AQFIkRPoAQOkDYk6+Chor2ry/w=
Received: by 10.210.70.14 with SMTP id s14mr2898919eba.161.1214480638578;
        Thu, 26 Jun 2008 04:43:58 -0700 (PDT)
Received: from ?10.10.2.7? ( [212.143.191.180])
        by mx.google.com with ESMTPS id t12sm2947855gvd.10.2008.06.26.04.43.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Jun 2008 04:43:57 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0806261210120.9925@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86438>



Johannes Schindelin wrote:
> Hi,
>
> On Thu, 26 Jun 2008, Ittay Dror wrote:
>
>   
>> I've read the language war thread (C vs C++) and I'm wondering if 
>> someone would like to share their views about using D instead of C.
>>     
>
> I would like to ;-)
>
> This is open source.  You are free to do what you want to do.  You are 
> even welcome to do so.
>
> Just do not expect many people to be able to comment on your work, let 
> alone be enthusiastic to use it, if you use an obscure language.
>
> Just take Tcl as an example: it is not exactly obscure, has been around 
> for ages, and many commercial programs actually use it as a scripting 
> language.
>
> Yet, there are preciously few people who _ever_ contributed anything to 
> gitk or git-gui, and you hear that the main reason is the language.
>
> OTOH C is a common denominator, educates its users to exercise lots of 
> circumspection (which means that those users will invariably write less 
> buggy code, even using other languages), and the code in Git is already 
> written in it.  So why not stop bitching and just continue using it?
>
>   
Sorry, I wasn't bitching. In fact, I agree with most views about C vs 
C++ (especially Linus' post). I just wanted to see if people think, in 
general (not related to git) that D is better/worse than C. So if I were 
to start a new project, would they recommend using D. That's it.
> Ciao,
> Dscho
>
>   

-- 
--
Ittay Dror <ittay.dror@gmail.com>
