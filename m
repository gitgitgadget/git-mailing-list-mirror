From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: A question about changing remote repo name
Date: Tue, 5 Jan 2010 02:57:27 +0100
Message-ID: <40aa078e1001041757q137c9d1erf8f6793016d6a2c2@mail.gmail.com>
References: <60ce8d251001032245n4e0267b1o1ecc796f324f8179@mail.gmail.com>
	 <20100104200908.GS29803@genesis.frugalware.org>
	 <60ce8d251001041753y5fe37b9do8d4cffc477e58198@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Dongas <dongas86@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 02:57:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRyfu-0003vO-EI
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 02:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042Ab0AEB5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 20:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753884Ab0AEB5a
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 20:57:30 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:53295 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484Ab0AEB53 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 20:57:29 -0500
Received: by ewy19 with SMTP id 19so7976501ewy.21
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 17:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=yKV6zE2FjqnjqE3e7W5j5AtrOIfx+8lzOH3AK6coeaI=;
        b=SCj2F7zBt8wgWgaZ7MEOBKi9ho+Q+Hy6+JxpDtAlYb4PQBlLGMZaDcFCxN4jLJC+Yk
         Ri9WkQ1BxBhVIXV0Xl0+5fIZsTptOHklNVKWJe+y/pPVT7ISStLqyho6Mtz2/2nsgnRP
         Xs9XqkWNdqOqkeCE9psaEkAagOqjU0N24OQLg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=L16i/zBjtN78O8lcu/ve3mGkl9EfVH56q1hvQpzVrMsC+EJ8xZ0wt3zXMiyPDPV3/D
         ERZuFE4j06Rrkd5b0nYUSZDWBWHmaQQHRl8VQV1UhNgy/1buIywUCAMSydQY65J0BG52
         /7NiXudhHLhzx4W1WRAabvEtShS7348TQt5k4=
Received: by 10.216.87.136 with SMTP id y8mr2052444wee.43.1262656647431; Mon, 
	04 Jan 2010 17:57:27 -0800 (PST)
In-Reply-To: <60ce8d251001041753y5fe37b9do8d4cffc477e58198@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136152>

On Tue, Jan 5, 2010 at 2:53 AM, Dongas <dongas86@gmail.com> wrote:
> 2010/1/5 Miklos Vajna <vmiklos@frugalware.org>:
>> On Mon, Jan 04, 2010 at 02:45:09PM +0800, Dongas <dongas86@gmail.com> wrote:
>>> I'm running ubuntu 9.04 and the git coming along with it doesn't
>>> support git remote rename command.
>>
>> It first appeared in v1.6.1, about a year ago. What does 'git version'
>> say?
>
> Thanks a lot for your reply.
>
> # git --version
> git version 1.6.0.4
>
> It seems the ubuntu9.04 doesn't have the repo source to update to a
> higher git version than 1.6.0.4,
> i'd like to know if there's a manual way to rename the git remote name
> with this version.
>

I know this isn't REALLY answering your question, but you should
seriously consider upgrading. 1.6.0.4 is ancient.

-- 
Erik "kusma" Faye-Lund
