From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: git --version
Date: Wed, 31 May 2006 22:19:53 +0200
Message-ID: <4d8e3fd30605311319x19e07ff3u2f4cf144d6faa96c@mail.gmail.com>
References: <4d8e3fd30605301516l782ad81dk5b11074e88db90a4@mail.gmail.com>
	 <4d8e3fd30605311220t17d319efyd5234dd4eb74fc96@mail.gmail.com>
	 <Pine.LNX.4.64.0605311224360.24646@g5.osdl.org>
	 <4d8e3fd30605311230h53981e57x8a417b176bedba86@mail.gmail.com>
	 <Pine.LNX.4.64.0605311233030.24646@g5.osdl.org>
	 <4d8e3fd30605311243q5a93a7a9l827c55827817602f@mail.gmail.com>
	 <4d8e3fd30605311249l6ba4ff74l72778ffe60462263@mail.gmail.com>
	 <4d8e3fd30605311256o67e45d06ve0efeff65fcf4851@mail.gmail.com>
	 <4d8e3fd30605311308j6a784635g91e2721258f53c9f@mail.gmail.com>
	 <Pine.LNX.4.64.0605311311480.24646@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 31 22:20:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlXAb-0003lu-Q1
	for gcvg-git@gmane.org; Wed, 31 May 2006 22:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWEaUTz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 16:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWEaUTz
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 16:19:55 -0400
Received: from wr-out-0506.google.com ([64.233.184.238]:61285 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751075AbWEaUTy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 16:19:54 -0400
Received: by wr-out-0506.google.com with SMTP id 55so106296wri
        for <git@vger.kernel.org>; Wed, 31 May 2006 13:19:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gD3V3toTr5lArywUt7LynYwRFB3FiAOaH/tqbk80k2/4xr8bGSW23HgnMftTuXwvMTpLWzijwte+J5JSmHaFS9yUFbdfRPy1qt4u/kKl4lkV25NUIzXUAbIYiHA6dB/mUeOFDnQD9FndJy9OiQskkWl+rOqVYOAP+RbBbeWA2KU=
Received: by 10.64.178.10 with SMTP id a10mr773264qbf;
        Wed, 31 May 2006 13:19:53 -0700 (PDT)
Received: by 10.64.250.4 with HTTP; Wed, 31 May 2006 13:19:53 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605311311480.24646@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21092>

On 5/31/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Wed, 31 May 2006, Paolo Ciarrocchi wrote:
> >
> > Don't know whay $PATH are different
>
> See ENVIRONMENT in the sudo man-page:
>
>         PATH                   Set to a sane value if sudo was configured with
>                                the --with-secure-path option
>
> so apparently your distro builds sudo with "--with-secure-path".

Yup, you must be correct. Thanks.

My distro is Ubuntu Dapper.

Ciao,

-- 
Paolo
http://paolociarrocchi.googlepages.com
