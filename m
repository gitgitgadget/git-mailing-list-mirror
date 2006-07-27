From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: Git clone stalls at a read(3, ...) saw using strace
Date: Thu, 27 Jul 2006 12:43:36 -0400
Message-ID: <b8bf37780607270943w562ec21fuab0eb882b3ccffeb@mail.gmail.com>
References: <b8bf37780607270516i7fbd8844he03e107b15fd2ed7@mail.gmail.com>
	 <1154018302.13273.0.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 27 18:43:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G68xZ-0005Jj-Im
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 18:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbWG0Qni convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 27 Jul 2006 12:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWG0Qni
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 12:43:38 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:21597 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751732AbWG0Qnh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 12:43:37 -0400
Received: by py-out-1112.google.com with SMTP id s49so354212pyc
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 09:43:37 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j0AcpxHQkk8FAGF5tAGzJQnL4JINdAKeQ9NMw4E5Pq9BykUkvDQOwhxxuzPIwc92xQnOu/vK+U5DKLp3DK7AfQDk61II+Iu7y+jsHhIh1gwzuJVKJWyCGz0V//VYC7/GG16/O79oJHq0i68VyaYtiFMkHfjKH5X16f26w3SP7D8=
Received: by 10.35.106.15 with SMTP id i15mr13428139pym;
        Thu, 27 Jul 2006 09:43:37 -0700 (PDT)
Received: by 10.35.128.2 with HTTP; Thu, 27 Jul 2006 09:43:36 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1154018302.13273.0.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24299>

On 7/27/06, Pavel Roskin <proski@gnu.org> wrote:
> On Thu, 2006-07-27 at 08:16 -0400, Andr=E9 Goddard Rosa wrote:
> > Hi, all!
> >
> >     Please CC me as I'm not subscribed.
> >
> >     Using  GIT 1.4.1, I tried to get this repository:
>
> Please try git 1.4.1.1, it fixes git-clone.

Thank you so much, Pavel!

Downloading it right now!

Thanks a lot,
--=20
[]s,
Andr=E9 Goddard
