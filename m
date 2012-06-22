From: Phil Hord <phil.hord@gmail.com>
Subject: Re: Master and origin/master diverged
Date: Fri, 22 Jun 2012 18:10:44 -0400
Message-ID: <CABURp0rhVi+pi4YjCfQqMpcjV2rYKQHPQ3QUZ49h0gjERAS4Qg@mail.gmail.com>
References: <CAE1pOi1Ot0Fyv=2_XYKyUcsKp-m+CkT-miF=jC=wt9Rbz_dXqQ@mail.gmail.com>
 <CABURp0oCrmJzfFtX9UujMfoTPeCBPeuri6pb4nTq57XvuO98aQ@mail.gmail.com> <CAE1pOi3pe4KKeJ4B74T8besvbiJh-dJz5efB-qJLsbmK+f_YLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 23 00:11:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiC4N-0005Xf-On
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 00:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab2FVWLH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Jun 2012 18:11:07 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42473 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab2FVWLG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jun 2012 18:11:06 -0400
Received: by yenl2 with SMTP id l2so1956414yen.19
        for <git@vger.kernel.org>; Fri, 22 Jun 2012 15:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IqjLpYZKlwsEdSLjY4qXkH35dnFELVUw0GGjdRvc5aM=;
        b=SMrbtervn0Sw4pY4sOmCB+0bnGQQ6AdUNFjnt7WBWYvLKILf7w9Pu6TBz/XwbPJ0/B
         C/HEepl32rtorKU+jospO2a/mbNo53PigBn36j3C/vr5OtcmYQSWkGHeJk5CwXvwCqh6
         JbOPw9SIVwzuWXxfthgibp2y+N9BTBYWBrRyiWDZKLdefSmfcgKgTYk0+1vO30Qdpf1S
         06DRH0D+ghR7ecP8j7vS5kefzq9jlewQuCbbiiVF7wkXxLI9gyavu/MpBzjDXjjc5YyT
         OzfGzED1e6kzGTpbgejdsZWTQ+UlWPhQc7ItCltdW574b6oSLjvz95tEy/S5y2/6Qig9
         LY3Q==
Received: by 10.101.143.32 with SMTP id v32mr1343890ann.42.1340403065036; Fri,
 22 Jun 2012 15:11:05 -0700 (PDT)
Received: by 10.146.150.18 with HTTP; Fri, 22 Jun 2012 15:10:44 -0700 (PDT)
In-Reply-To: <CAE1pOi3pe4KKeJ4B74T8besvbiJh-dJz5efB-qJLsbmK+f_YLQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200476>

On Fri, Jun 22, 2012 at 4:14 PM, Hilco Wijbenga
<hilco.wijbenga@gmail.com> wrote:
>> You can also compare the commits to see what the differences are.
>> This may trigger =A0the developer's memory about how it might have
>> happened.
>
> The only differences seem to be the SHA-1s.


Can you tell me which SHA-1s they are?  It will be easier for me to
guess at the reflog contents, then.

Phil
