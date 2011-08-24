From: =?UTF-8?B?QWRhbSBLxYJvYnVrb3dza2k=?= <adamklobukowski@gmail.com>
Subject: Re: Problem with S_IFGITLINK
Date: Wed, 24 Aug 2011 17:26:05 +0200
Message-ID: <4E55180D.1040207@gmail.com>
References: <4E54F364.7000503@gmail.com> <4E55115D.9000909@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 17:26:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwFLK-00019i-Q4
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 17:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734Ab1HXP0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Aug 2011 11:26:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45764 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893Ab1HXP0I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 11:26:08 -0400
Received: by fxh19 with SMTP id 19so1051688fxh.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5w/+rnasJl2SE0diLyq+YoCIeqWwxhle2T3tgB+HELw=;
        b=EOoHBJ6cNhFBnsOuR9u0ZnUyXBDB8qloLajPgvJGF0q0BJcy1cXfAUQZeQdIjzIxtL
         dnNYtq0XS8vWuQ8NhtabYPF5yRW+K5WR+fvjWRPl6y53ugfin9vMo/hGOO5MYC6+T/Nn
         cd6AjMRFx9khMjcmEVS47Ov2SZGc2n+EDYbE4=
Received: by 10.223.58.73 with SMTP id f9mr7423332fah.149.1314199567750;
        Wed, 24 Aug 2011 08:26:07 -0700 (PDT)
Received: from [192.168.0.102] (89-72-179-1.dynamic.chello.pl [89.72.179.1])
        by mx.google.com with ESMTPS id q23sm916209faa.30.2011.08.24.08.26.06
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Aug 2011 08:26:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
In-Reply-To: <4E55115D.9000909@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180008>

W dniu 24.08.2011 16:57, Michael Schubert pisze:
> On 08/24/2011 02:49 PM, Adam K=C5=82obukowski wrote:
>> I'm trying to compile git on some very exotic u*ix flavor (FreeMiNT
>> anyone? :)) [...]
>
> Out of interest: just for fun?

Hobby. There are still active developers and users, but they're 'ugly=20
and stupid' ;) (I mean: using CVS) for FreeMiNT kernel development. I=20
would like to propose to switch ti GIT, but I need to be able to compil=
e=20
native binary first.

AdamK
