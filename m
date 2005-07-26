From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Linux BKCVS kernel history git import..
Date: Tue, 26 Jul 2005 18:01:32 -0400
Message-ID: <42E6B2BC.6060709@gmail.com>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org> <20050726213643.7ca44e96.diegocg@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Jul 27 00:02:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxXV3-0002WV-GH
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 00:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVGZWBt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 26 Jul 2005 18:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVGZWBp
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 18:01:45 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:61301 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261910AbVGZWBj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2005 18:01:39 -0400
Received: by wproxy.gmail.com with SMTP id 57so44718wri
        for <git@vger.kernel.org>; Tue, 26 Jul 2005 15:01:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ME5mrMujYSqpM0CE98/SAuynL/5GygK/lQD9eonYlmibCqLTfUpsyLNxm41DT1qZvKCTiKZnA/Z/+UFdy3BSe7HD2C2kUwdyN/l06XUXvuX89YjEgqP4rjrdhYP0MjaLJFjIXLLmehsxf1flZtB3ieEMrrkJcgPrTbsd0NHlQWE=
Received: by 10.54.120.12 with SMTP id s12mr82782wrc;
        Tue, 26 Jul 2005 15:01:37 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id g5sm113491wra.2005.07.26.15.01.34;
        Tue, 26 Jul 2005 15:01:37 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <20050726213643.7ca44e96.diegocg@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Diego Calleja wrote:
> El Tue, 26 Jul 2005 11:57:43 -0700 (PDT),
> Linus Torvalds <torvalds@osdl.org> escribi=F3:
>=20
>>I'm planning on doing the 2.4 tree too some day - either as a separat=
e
>>branch in the same archive, or as a separate git archive, I haven't q=
uite
>=20
> It'd be great  to have the same thing but for the 1.0 - 2.2 tree. Of =
course
> there are no "changelogs" for that, but incremental patches are still
> available, and it'd be very interesting (for "historical reasons") to=
 see how
> things were added/removed

Also a really good stress test for the various git-blame/git-annotate
implementations.
