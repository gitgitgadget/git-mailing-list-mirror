From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: less -F ubuntu dapper.
Date: Sat, 21 Oct 2006 09:47:06 -0700
Message-ID: <453A4F0A.9000003@gmail.com>
References: <cc723f590610210623sbee2075i5f2fd441cceb84ae@mail.gmail.com> <20061021200110.6aef96a4.vsu@altlinux.ru>
Reply-To: Git Mailing List <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sergey Vlasov <vsu@altlinux.ru>,
	Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 21 18:47:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbK0M-0004OS-31
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 18:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993132AbWJUQrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 12:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993133AbWJUQrW
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 12:47:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:54230 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S2993132AbWJUQrV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 12:47:21 -0400
Received: by ug-out-1314.google.com with SMTP id o38so955074ugd
        for <git@vger.kernel.org>; Sat, 21 Oct 2006 09:47:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GNfoFp9FMPI/PxcRT4W5qAOdmSlPHd7SFWtQx5zdeWg6ByIdXyh7nT1JSMqbziBV6TPNqC9wo012/Y1vb+fsaYIcbtrY+mf56/NFw/FzIJY/6DoWa2gXQak13gdaMfx4lJWuolMa4nmbIb90n0ZrNf48VCtnuFV8KK3frTuxZXo=
Received: by 10.78.149.13 with SMTP id w13mr4156905hud;
        Sat, 21 Oct 2006 09:47:19 -0700 (PDT)
Received: from ?10.0.0.6? ( [67.20.86.181])
        by mx.google.com with ESMTP id 15sm793448hui.2006.10.21.09.47.18;
        Sat, 21 Oct 2006 09:47:19 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20061021200110.6aef96a4.vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29634>

Sergey Vlasov wrote:
> On Sat, 21 Oct 2006 18:53:35 +0530 Aneesh Kumar wrote:
> 
>> -F option for less in ubuntu Dapper is broken. It doesn't display
>> anyting if the file can be displayed in one page.
> 
> Same here in ALT Linux (less-382-alt2).  The problem appears only
> when the terminal supports alternate screen, and less uses it.

Suse 9.3 has the same problem.
