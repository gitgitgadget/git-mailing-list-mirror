From: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>
Subject: Re: Encoding problem on OSX?
Date: Tue, 10 Aug 2010 08:52:12 +0300
Message-ID: <AANLkTikqpYO9GG9PZD_==PyUSGRV8=L5LrZ0RVsESuXN@mail.gmail.com>
References: <AANLkTikh12guRxCK2Vf=WvshzX8P-fYTyu3qxYWNJ2px@mail.gmail.com> 
	<AANLkTiky2uUHfOsh8rNXZPEqTLcNSZowy=Qcm+4Hjn_n@mail.gmail.com> 
	<20100809234620.GA6418@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 07:52:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OihlP-0001tv-Fo
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 07:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261Ab0HJFwe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 01:52:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58470 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab0HJFwd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Aug 2010 01:52:33 -0400
Received: by iwn33 with SMTP id 33so4214422iwn.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 22:52:32 -0700 (PDT)
Received: by 10.231.183.134 with SMTP id cg6mr15404763ibb.197.1281419552404; 
	Mon, 09 Aug 2010 22:52:32 -0700 (PDT)
Received: by 10.231.206.198 with HTTP; Mon, 9 Aug 2010 22:52:12 -0700 (PDT)
In-Reply-To: <20100809234620.GA6418@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153077>

Hi;

On Tue, Aug 10, 2010 at 2:46 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
>
> =C2=A0locale
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf 'Th\360\235\204\236s\n' | sed 's/.*=
//g

[ismail@havana][08:50:45]
[~]>  locale
LANG=3D
LC_COLLATE=3D"en_US.UTF-8"
LC_CTYPE=3D"en_US.UTF-8"
LC_MESSAGES=3D"en_US.UTF-8"
LC_MONETARY=3D"en_US.UTF-8"
LC_NUMERIC=3D"en_US.UTF-8"
LC_TIME=3D"en_US.UTF-8"
LC_ALL=3D"en_US.UTF-8"

[ismail@havana][08:51:00]
[~]> printf 'Th\360\235\204\236s\n' | sed 's/.*//g'

[ismail@havana][08:51:06]
[~]>
