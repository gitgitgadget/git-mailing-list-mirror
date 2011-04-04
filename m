From: =?ISO-8859-1?Q?Sebasti=E1n_Ventura?= <lomegor@gmail.com>
Subject: Re: GSOC 2011: git on Android
Date: Mon, 4 Apr 2011 08:38:53 -0300
Message-ID: <BANLkTikJWmn6FJatTbuf7d67QF=xu6heRQ@mail.gmail.com>
References: <AANLkTikHieyRYPntivWa51fUBxXCJNzuHGy_AvU++=PN@mail.gmail.com> <20110403150108.GA1480@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 04 13:39:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6i7r-0005yc-Cg
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 13:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854Ab1DDLjP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Apr 2011 07:39:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57147 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab1DDLjO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Apr 2011 07:39:14 -0400
Received: by fxm17 with SMTP id 17so3822256fxm.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=JAvbHHYrBp3qW7cn8ljtjB15fk43xtWUdNb9eGZc4WU=;
        b=uqaHfmtgBNy9bipBnDyqhxliRCCNCezxXkow8wKDasQlVJ8pIMo4tAq4tPDSKujYun
         Wipo8w8DD7FO6XzBeLPYAKEHji7kWz8+fHIIblQVGLTXd+Ah2YWwQ7r3WInuEu559OzJ
         xh+PtcCrg3wk1ZLIQHo/GPR6Sp0+NO4qximfk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=oUNQAEyPKhPotF5V2JkLW4+JN1ROm9kDe5Z/pVyslRPv+LIcHhqDrzrEKWhYNyr+X3
         I3ouVp7gVIp5p4+jA8hXNGRr4Uu/rgBTaYqsEeDeg3zdgbl4ElCy+YgT5WHcKA31ee8S
         QXgeKXVnUEYGpAB8Bm627XyvscDC5cgZc1huo=
Received: by 10.223.76.205 with SMTP id d13mr3643713fak.110.1301917153057;
 Mon, 04 Apr 2011 04:39:13 -0700 (PDT)
Received: by 10.223.1.204 with HTTP; Mon, 4 Apr 2011 04:38:53 -0700 (PDT)
In-Reply-To: <20110403150108.GA1480@kytes>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170804>

Thanks for answering! I'd be very happy to help in this project.
Recently I asked in the jgit for ideas on the Android port and I
learned that someone has it almost done, so, I'm not sure if this
project is fit for GSOC then.

Again, thank you, and I'll be looking the list for ways to help.

Sebastian Ventura

On Sun, Apr 3, 2011 at 12:01 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Hi Sebasti=E1n,
>
> Sebasti=E1n Ventura writes:
>> My name is Sebasti=E1n Ventura and I would like to participate in
>> porting git to Android for GSOC 2011. I'm a 22 year old Computer
>> Sciences student from Uruguay, and I'd really like to start
>> contributing to open source but don't know where to start, and I thi=
nk
>> helping in this project is something I am able (and willing) to do.
>> Therefore I would like to ask the community how can I start helping
>> now to better understand the code. =A0But firstly, do you think this=
 is
>> a problem belonging to JGit (for making a native app) or that is
>> better suited for this mailing list?
>
> Thanks for writing. =A0I don't know much about the project, but I hop=
e
> this small disucssion on IRC will point you in the right direction
> [1]. =A0You should also try asking Shawn and the JGit community about
> this.
>
>> Besides that, and even if I don't enter GSOC, I want to help in an
>> Open Source project, so how can I help now? Is there any small probl=
em
>> that you think I can resolve?
>
> We don't have an official bug tracker, but there are plenty of small
> tasks you can pick up from threads on the mailing list [2], or from
> various distributions' bug trackers (like Debian BTS). =A0Idally, it
> would be nice if you work on a feature/ bugfix that you'd personally
> like to see.
>
> -- Ram
>
> [1]: http://colabti.org/irclogger/irclogger_log/git-devel?date=3D2011=
-03-31#l323
> [2]: http://article.gmane.org/gmane.comp.version-control.git/170670
>



--=20
Nai Eru varyuva le
