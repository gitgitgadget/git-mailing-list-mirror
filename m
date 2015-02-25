From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Re: [RFH] GSoC 2015 application
Date: Wed, 25 Feb 2015 13:15:01 +0100
Organization: gmx
Message-ID: <ff84346567e67b0d46cb40efef31916d@www.dscho.org>
References: <20150218191417.GA7767@peff.net>
 <20150218193234.GA8298@peff.net>
 <5f6dbabdf4da3c3c757d92ba00a8b7d1@www.dscho.org>
 <20150224120607.GA1906@peff.net>
 <ed760450b06fd41c8bcaea7aaf526b94@www.dscho.org>
 <20150224122846.GA2631@peff.net>
 <1029c184eae22b9d27fae5de2c04238b@www.dscho.org>
 <614912493.13990870.1424859945767.JavaMail.zimbra@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, msysGit
 <msysgit@googlegroups.com>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: msysgit+bncBCZPH74Q5YNRBTHZW2TQKGQEUNV73VQ@googlegroups.com Wed Feb 25 13:15:12 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBTHZW2TQKGQEUNV73VQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-oi0-f56.google.com ([209.85.218.56])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBTHZW2TQKGQEUNV73VQ@googlegroups.com>)
	id 1YQart-0006Y2-PT
	for gcvm-msysgit@m.gmane.org; Wed, 25 Feb 2015 13:15:09 +0100
Received: by mail-oi0-f56.google.com with SMTP id x69sf874652oia.1
        for <gcvm-msysgit@m.gmane.org>; Wed, 25 Feb 2015 04:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to:cc
         :subject:organization:in-reply-to:references:message-id:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=9T+8ALz9pSINPrHL5H/pJFOS0q0xDIYvirbkGZt6rX0=;
        b=lgqnwy9d+HI4iOK6v/D0xl3zydKQAcD+b/Brega14klQbRKRSBPXmCgdO07+qcrt7n
         HcgqjouQ2Fxl29vHvHlll1uI5f7EkNoGbJw1eilkGA0WduQfDGpWyyp0VsDkx7qU9OV8
         qpRg5tMOvnKCt8PqrFfTzAP9aDNm+a6qfPzx2mVdjIvfIPfNVqMc2EL+hCRD6tkXLPA7
         mGVRxIRa6XsU+PmMu9DgChbUG7qeRumY10AuJ+x/boedie6QDPVLtXiXEtokuYNs9c0l
         EsqPlZ78UX8tanm/HA4/+sEqPVSFLGzPt7K7MrNgdnoqpSfA6VSNZChYBviJ/u1lGkxR
         Xj3A==
X-Received: by 10.182.97.200 with SMTP id ec8mr17155obb.20.1424866509114;
        Wed, 25 Feb 2015 04:15:09 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.246.137 with SMTP id xw9ls1026711obc.67.gmail; Wed, 25 Feb
 2015 04:15:08 -0800 (PST)
X-Received: by 10.182.148.164 with SMTP id tt4mr2530444obb.30.1424866508501;
        Wed, 25 Feb 2015 04:15:08 -0800 (PST)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.15])
        by gmr-mx.google.com with ESMTPS id kt5si7206791qcb.3.2015.02.25.04.15.08
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2015 04:15:08 -0800 (PST)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as permitted sender) client-ip=212.227.15.15;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MN1j6-1YSlfL1K7U-006drQ; Wed, 25 Feb 2015 13:15:03
 +0100
In-Reply-To: <614912493.13990870.1424859945767.JavaMail.zimbra@imag.fr>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:pSPbaGUxsnP18EnWhr0xfC4rZmrJ5lYPhcA7k3UX+rXuXIJpddG
 VyI0HiQtJte6OufwgzbSHaRvqblOy0JYagvRc1ratX5FmCJ7+tG9mjuLDETJr5nknbIFmpH
 +LYw4OkIdLVRgRnVV7TntrSZ5dUO9NwEwiME5d0Cm/IKm3PNFzvvIOLtsa0exdKOsODMbNa
 nJyYZvuZvC4lBanG+VnNw==
X-UI-Out-Filterresults: notjunk:1;
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.15.15 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264388>

Hi Matthieu,

On 2015-02-25 11:25, Matthieu Moy wrote:
> ----- Original Message -----

>> On 2015-02-24 13:28, Jeff King wrote:
>> > On Tue, Feb 24, 2015 at 01:25:32PM +0100, Johannes Schindelin wrote:
>> >
>> >> > Thanks! No rush, as we are not even accepted yet, but you can creat=
e a
>> >> > profile at:
>> >> >
>> >> >   http://google-melange.com
>> >> >
>> >> > and ask to join the "git" project as a mentor.
>> >>
>> >> I guess I can only ask that after the org is accepted, I will do so
>> >> when (and if) that is the case.
>> >
>> > I think you can do it now; I had to create the project profile in orde=
r
>> > to do the application. But again, no rush.
>>
>> I tried, but there are no orgs listed as of yet when I click "Make
>> connection".
>=20
> Not sure what it's supposed to look like, but I think if you give us
> your username we can invite you as mentor.

Thanks. My username is =E2=80=93 surprise! =E2=80=93 'dscho' ;-)

Ciao,
Dscho

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
