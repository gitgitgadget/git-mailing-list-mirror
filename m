From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git --version
Date: Wed, 31 May 2006 21:20:14 +0200
Message-ID: <4d8e3fd30605311220t17d319efyd5234dd4eb74fc96@mail.gmail.com>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	 <7vu077ywmw.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311158n9d669dgd6c392ee8d194b78@mail.gmail.com>
	 <7vac8yypxc.fsf@assigned-by-dhcp.cox.net>
	 <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 21:20:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlWEy-0000H8-DK
	for gcvg-git@gmane.org; Wed, 31 May 2006 21:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWEaTUT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 15:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWEaTUT
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 15:20:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:10023 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965112AbWEaTUR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 15:20:17 -0400
Received: by wr-out-0506.google.com with SMTP id 50so99093wri
        for <git@vger.kernel.org>; Wed, 31 May 2006 12:20:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rD6eUhDqnv8k0UfQNzpxysKaKmp1aeOKmCXcTAzVmtR7YlKVYHhfbEWt/loJbGm8k4D/fY2cOiqlsUCca8tvJ1x6WJi87SV2PMQz+5DCjK6UsrZOVNmToCBdUIWXA3KwW2fCXuGZzK/F/x7CL3yrl61yt9yOUL+e20yKEIOXWjE=
Received: by 10.64.112.8 with SMTP id k8mr165997qbc;
        Wed, 31 May 2006 12:20:14 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Wed, 31 May 2006 12:20:14 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <4d8e3fd30605311213m6f2f2660u90701ad6bd5daabc@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21078>

On 5/31/06, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
 > So yes, it's correctly installed (I pull, compile and install almost
> daily always without any problem).
>

Tried with:
 make clean
 make && sudo make install
 [...]
 paolo@Italia:~/git$ git --version
 git version 1.3.GIT
 paolo@Italia:~/git$ ./GIT-VERSION-GEN
 GIT_VERSION = 1.3.3.g2186

Puzzled.


-- 
Paolo
http://paolociarrocchi.googlepages.com
