From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: Call Me Gitless
Date: Mon, 18 Aug 2008 16:17:52 -0400
Message-ID: <48A9D8F0.9090309@gmail.com>
References: <4b6f054f0808171702q10d89dfey98afa65634d26e91@mail.gmail.com> <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Trans <transfire@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Aug 18 22:19:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVBBu-00052a-Lw
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 22:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbYHRUR5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Aug 2008 16:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbYHRUR5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 16:17:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:38704 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbYHRUR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 16:17:56 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2232035wri.5
        for <git@vger.kernel.org>; Mon, 18 Aug 2008 13:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=/qrxistU/8zq5v0pmNsv27xeoo21GlUcykIy/vZBupg=;
        b=xZ0TVq90zkQqpsLi3HrJwuLECqPa+TH5zPNnJnNlEu/t89LcZwU2kYR24C7jX3pku7
         DSOn3hSFoeJwvjtemulbaVlM3eFWAvorxcoT6q52ikFcobkS35oiXYY05nb7JGYeMuux
         5fFE2uBnICI3lkCWItqNvFDK3I/YfAOHuYOKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=rtT+6ptwEGLQeB19SNZWc8ZN+VAklgr7d8dOJdDWMIMeO7DQN0Kk8h1l6HMppthkZ6
         d+rfoi46HBxeMdzhw6izNfc3gS+A72yrYQgBckvPwltzqAiMooR+vWDLo2sIUlmqzpvw
         N7mvJUrLJsRNU/xaJ447gfeEZHiveaA4i9+Y8=
Received: by 10.90.36.16 with SMTP id j16mr1524665agj.50.1219090675516;
        Mon, 18 Aug 2008 13:17:55 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id l22sm3614403wrl.30.2008.08.18.13.17.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 18 Aug 2008 13:17:54 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <alpine.LNX.1.00.0808181512160.19665@iabervon.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92735>

Daniel Barkalow wrote:
>> Well, after a few days of using git, I've decide Linus is too smart =
to
>> be designing end-user interfaces.
>=20
> This is true, but hardly relevant. Git's end-user interface was almos=
t=20
> entirely designed by other people, using Linus's excellent=20
> script-developer API.

Blame the plumbers. :-P

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
