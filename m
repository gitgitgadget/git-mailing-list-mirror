From: Dongas <dongas86@gmail.com>
Subject: Re: A question about changing remote repo name
Date: Tue, 5 Jan 2010 10:25:34 +0800
Message-ID: <60ce8d251001041825i1bc85b19u201b7ccce0f0c29b@mail.gmail.com>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com>
	 <20100104200908.GS29803@genesis.frugalware.org>
	 <60ce8d251001041753y5fe37b9do8d4cffc477e58198@mail.gmail.com>
	 <40aa078e1001041757q137c9d1erf8f6793016d6a2c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Jan 05 03:27:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRz75-0003XY-QX
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 03:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab0AECZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 21:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463Ab0AECZf
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 21:25:35 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:38156 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab0AECZe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 21:25:34 -0500
Received: by ywh6 with SMTP id 6so15976288ywh.4
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 18:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=1LUEnooYL5pJk6nQw9jMSSby+rRywxpggOeiT8SiX4Q=;
        b=xT2e9uuoyw3yLk8zolwFE3u56WpzjIonrIWfkBUCHjI5hDBh0NQoOPB6TIjpjGjEva
         7V/NnsnxZbA0soyUlsd/ErT74P+0fxSdoEUPlefet+voQq4ZlVNzXzWWTyI9s66adED/
         Eq/29a011RU4/Py16zAD5Lhd1LXgjH+jHeBBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XnU9C3Hwz8L1lrYjmibdez26xb5UMFY+6uqPKUai7hq0jEkUsAfI+g/1udeJmQsZKE
         97CGLH/y/h8Xzk1+C0CRxGxlvPXjO4DdET69BfNhiftnrhrgIHF8o6C7Dm38+65WrWPP
         Zl42s+PcrBqlEhmDohh/sdd3ynfNTPZgUDwKU=
Received: by 10.90.23.30 with SMTP id 30mr5177792agw.117.1262658334091; Mon, 
	04 Jan 2010 18:25:34 -0800 (PST)
In-Reply-To: <40aa078e1001041757q137c9d1erf8f6793016d6a2c2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136155>

2010/1/5 Erik Faye-Lund <kusmabite@googlemail.com>:
> On Tue, Jan 5, 2010 at 2:53 AM, Dongas <dongas86@gmail.com> wrote:
>> 2010/1/5 Miklos Vajna <vmiklos@frugalware.org>:
>>> On Mon, Jan 04, 2010 at 02:45:09PM +0800, Dongas <dongas86@gmail.com> wrote:
>>>> I'm running ubuntu 9.04 and the git coming along with it doesn't
>>>> support git remote rename command.
>>>
>>> It first appeared in v1.6.1, about a year ago. What does 'git version'
>>> say?
>>
>> Thanks a lot for your reply.
>>
>> # git --version
>> git version 1.6.0.4
>>
>> It seems the ubuntu9.04 doesn't have the repo source to update to a
>> higher git version than 1.6.0.4,
>> i'd like to know if there's a manual way to rename the git remote name
>> with this version.
>>
>
> I know this isn't REALLY answering your question, but you should
> seriously consider upgrading. 1.6.0.4 is ancient.
>
Thanks a lot for your advices.
Unfortunately, all my team members are running ubuntu 9.04.
If i could find a easy way to upgrade it, it will take it.

Regards
Dongas
