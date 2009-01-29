From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: do you recommend "git" (over svn) for a 1-person team???
Date: Thu, 29 Jan 2009 02:38:45 +0100
Message-ID: <bd6139dc0901281738j54ee2fe3uca432cef806ec4af@mail.gmail.com>
References: <d30068860901281718x363348caya2dc94e798cc8091@mail.gmail.com>
	 <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Greg Hauptmann <greg.hauptmann.ruby@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 02:40:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSLtO-0000I6-SC
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 02:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbZA2Bis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 20:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbZA2Bis
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 20:38:48 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:10376 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302AbZA2Bir (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 20:38:47 -0500
Received: by yw-out-2324.google.com with SMTP id 9so3133425ywe.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 17:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=eXyPfnzKxQHsDbOEjXfYW6NxrjLwEj5DWYgeBIbbLzs=;
        b=HbTQi5PsllSMsn9yKHIlllgdHTNNhkcnrD/ALN2PJTTTmHVNRhR5A5iwY7REi/uvd7
         JSUiOwdNcyyLhNy6WqmLjkVgHjqgTTbYjuJGx0rTEmvO+/m3nMATGWsM3n6uzOocWxad
         sUbcfnfXKEH49+edXik7bYPnc98yjKAfnMsZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=A0/JU39NkkfnpUgA6Mfd9vNU/tnw2iUrfbQ+HePzLgQKangB3WZBC8694Ai8sEouti
         sr9675UsoIzddL4s2gxtkjVyAxkeV6cv4pzZ6SjSc0+roK8q1y2kWryJUUJxqKQYlZX5
         KBiw4wqZBsyjKgI+3tfId5AYT0Nvx0nND9WcM=
Received: by 10.150.158.10 with SMTP id g10mr1599494ybe.211.1233193125813; 
	Wed, 28 Jan 2009 17:38:45 -0800 (PST)
In-Reply-To: <d30068860901281725t14d19c1vc0557182bca3eb8d@mail.gmail.com>
X-Google-Sender-Auth: 833b55a117058a4c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107608>

Heya,

On Thu, Jan 29, 2009 at 02:25, Greg Hauptmann
<greg.hauptmann.ruby@gmail.com> wrote:
> Do you recommend "git" (over svn) for a 1-person team???   (the
> ability to commit whilst offline on my laptop sounds potentially
> enough reason)

Are you seriously asking if you should git instead of svn on the git
mailing list, or am I missing something? :P.

Seriously though, yes, git works very nicely for 1-person teams as
well as for large teams. Especially the ability to "git init && git
add . && git commit -m 'got part of the assignment done'" has helped
me a lot.
Before I started using git I would come to the point where I thought
'ah, good, it almost works, now all I have to do is add feature x, and
then 10 minutes later I'd be wishing I had used some form of revision
control so I could go back to that working version!

</testemonial>

-- 
Cheers,

Sverre Rabbelier
