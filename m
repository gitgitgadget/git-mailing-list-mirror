From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/8] Make the "traditionally-supported" URLs a special 
	case
Date: Fri, 4 Sep 2009 12:47:14 +0200
Message-ID: <fabb9a1e0909040347i2a002c62h47f8d39596134095@mail.gmail.com>
References: <alpine.LNX.2.00.0909032213180.28290@iabervon.org> 
	<fabb9a1e0909032229k5e6e2ed5mc11e8ff9c16dfcc0@mail.gmail.com> 
	<20090904172345.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 04 12:47:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjWKU-0001WO-Mt
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 12:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755875AbZIDKre convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2009 06:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755319AbZIDKre
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 06:47:34 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:38215 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbZIDKrd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 06:47:33 -0400
Received: by ewy2 with SMTP id 2so309493ewy.17
        for <git@vger.kernel.org>; Fri, 04 Sep 2009 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qBuvHb66ZzglSGJsD63pEs9CTeLp4VujEZPeyGpQ9GI=;
        b=uk7DSZB8qH8CDW2xLltjzx+Txh9LrejQIeDHrGUQUcsIUXZ3LmoT6dhqSdqo7v1y39
         LGXXvhCtu3n9ewYLUBaXD1Fl5OAIgLs2KwPZ6iwS/vPMj5QdGtk1UoaBiIVbpyqIbLlL
         4pVc8hWiFTnkypVuexeFjRKIXGyHZ9gJPjhIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z7N0sGT7cCDjijl/29rVwFNXTY6y+gj7kdNehJra6ffFlpwSy5eu8BXEqocbvRM48J
         UJHz7GkxmNihiaQMGdQbcaJGo1gWoqMk5ODlN3Kn6bZ5Uzn44HRbNS6xui5K2fNX1iXF
         RfMQxZD3yzD+5qqiAEdTQ6rbCb1aEEf8hDD4o=
Received: by 10.216.54.207 with SMTP id i57mr816476wec.114.1252061254135; Fri, 
	04 Sep 2009 03:47:34 -0700 (PDT)
In-Reply-To: <20090904172345.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127709>

Heya,

On Fri, Sep 4, 2009 at 10:23, Nanako Shiraishi<nanako3@lavabit.com> wro=
te:
> =A0http://thread.gmane.org/gmane.comp.version-control.git/127121/focu=
s=3D127520

I don't see anything in that thread that convinces me why this is the
better solution. Unless I'm reading it wrong Junio said "so this is
how you're going to do it", and Daniel said "yup".

--=20
Cheers,

Sverre Rabbelier
