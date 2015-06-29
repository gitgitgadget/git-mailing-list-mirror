From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: 4th release candidate of Git for Windows 2.x, was Re:
 3rd release candidate of Git for Windows 2.x
Date: Mon, 29 Jun 2015 16:37:54 +0200
Organization: gmx
Message-ID: <426859781bd04ca4ebb13719350537ed@www.dscho.org>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
 <b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
 <8224736a18724f751312d57e67967d69@www.dscho.org>
 <55910AE7.3000206@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Git Mailing List <git@vger.kernel.org>, msysgit@googlegroups.com,
 git-for-windows@googlegroups.com
To: =?UTF-8?Q?Stefan_N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: msysgit+bncBCZPH74Q5YNRBRFQYWWAKGQEA7NFKHI@googlegroups.com Mon Jun 29 16:37:59 2015
Return-path: <msysgit+bncBCZPH74Q5YNRBRFQYWWAKGQEA7NFKHI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-la0-f64.google.com ([209.85.215.64])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBRFQYWWAKGQEA7NFKHI@googlegroups.com>)
	id 1Z9aC5-0005c1-Uy
	for gcvm-msysgit@m.gmane.org; Mon, 29 Jun 2015 16:37:58 +0200
Received: by lamq1 with SMTP id q1sf13493980lam.0
        for <gcvm-msysgit@m.gmane.org>; Mon, 29 Jun 2015 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:content-type:content-transfer-encoding:date:from:to:cc
         :subject:organization:in-reply-to:references:message-id:user-agent
         :x-original-sender:x-original-authentication-results:precedence
         :mailing-list:list-id:x-spam-checked-in-group:list-post:list-help
         :list-archive:sender:list-subscribe:list-unsubscribe;
        bh=sKOAvq+Z5boRFTUNJtxUMu0jwC3BJWjGq4shu+HwkDg=;
        b=M6aGy29m4zHU6Z8CwrA285V/OeH6r4Exzw8iT9/Q7AruK5AV8Qp0+4F1iCd5UoeBpp
         N8QuhJyhiiyQAd9Tv9VIdC7AqAWDrgpz+LYXtm/O07QC4RYrcjqJBEHnrADPiJ6S8i26
         NAclHgKopPEHXw7RYwK4wDo8wpXqHHSEetOGPTnCbYOL1/2b1QPxxdOOcox5NrnQWpIg
         QhORKsHq+s1NGr+hCgd6OFBPl3Q7znaAVMSBTr8SERhk0+nGXrluw/47QGZpTyUHAc1P
         lo/LS04Pi/TILDu7vkjpA38U+6/ph2b5l1ncQJC3o8qwl1C8jp62ypDeZP5Tnyx8 
X-Received: by 10.180.20.110 with SMTP id m14mr15121wie.4.1435588677684;
        Mon, 29 Jun 2015 07:37:57 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.105.36 with SMTP id gj4ls596364wib.3.canary; Mon, 29 Jun
 2015 07:37:55 -0700 (PDT)
X-Received: by 10.180.37.198 with SMTP id a6mr8791398wik.7.1435588675873;
        Mon, 29 Jun 2015 07:37:55 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.17.22])
        by gmr-mx.google.com with ESMTPS id ec7si412280wib.3.2015.06.29.07.37.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 07:37:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as permitted sender) client-ip=212.227.17.22;
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lv8hi-1Z1RHE41b8-010LzJ; Mon, 29 Jun 2015 16:37:55
 +0200
In-Reply-To: <55910AE7.3000206@atlas-elektronik.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:4bs7L5j3f+fEoZLCRDeh4cwhm9WUv8Eaub9yb8R++9b/n8zWr8a
 NaT+VfJcoNKnvVpjRhMq6hmr6fcf5c1seKMM+cCSqT9j7WeElT+gG51MIIr+9ecN6rHnoYf
 EIDxuAEfDfAb11VifU0Q0MQ20CzG2fTe5EsbucNd0wnbeS7RYtLabldbbNUZRLBZHPKBLF7
 kObS31LKRBNPQ4v8p/0og==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PaX3jf7p2B4=:sd3F3Mz341PoSTpRFuVma2
 vkJfQh5H2hEu78xPWzNIEEaZW9/H4kiRpzL6mpD769WrqmvKrq94AWmgtNar4KuHc1wJi5i7H
 vGYBORHucyJEnqVfi+aQ5ZiYBMna1UnM7tDtEMVpvmxkBfJqSzxLHl//93ZyFc6ZTAI4z6nFJ
 xRCOJVajsTx0/CXKIg9VjI4NkqZny71f6ODIBJrozVaGkqiAaF3iF6RwKWiEI9NNwRb4o8W+a
 06kvFGaqpEgGnEJG3fLYn6GcltuEDbyCoLNv3uz54TOjEPBzBfGsWnpW0F63dikXzhmYGwLUX
 g+u0TKuZDMPnsJvSsSu/IrlybX8LySsjHhSdTibd9wtiSA/r90SWdvjpH+8XcDPzPGOSfitp2
 kRLv88/GPYZNbCJgZ/oDssoPIK6RM+HALomNtphLE7fsHOXa1FRXDTQRUnySrPYPNAb04wdBj
 ba402JIIRLgrwvXr8WnZusTCMNXAOk8DdonzNO54X8z1EU12LEFqWZ+b7U+pUphtgr7mIdlWi
 +8JpsS+VjCBKpBd3iJ8hl52UNJk9hCFaWOsd55JqZscCcMJwfBhbPbtJMRe13Bh1BBYcWH40U
 y0jln1prEqoDE9+MGrADXi2ZVpkAcSqZ3IwvvduxAHtmea6K6WM6cHFmMz7oSvgL1NKu1sKBx
 hwar0m4ETgTIOV3KHuPyf+fUfASFPRtMybQnBElIu7qnOE/e33rRQcNMvE25WE/EqBuU=
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of johannes.schindelin@gmx.de designates 212.227.17.22 as
 permitted sender) smtp.mail=johannes.schindelin@gmx.de
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Spam-Checked-In-Group: msysgit@googlegroups.com
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272951>

Hi Stefan,

On 2015-06-29 11:07, Stefan N=C3=A4we wrote:
> Am 29.06.2015 um 10:30 schrieb Johannes Schindelin:

>> I just uploaded the 4th release candidate for the upcoming Git for
>> Windows 2.x release. Please find the download link here:
>>
>> https://git-for-windows.github.io/#download
>>
>> The most important changes are the update to Git 2.4.5 and a fix for the=
 crash when running Git Bash
>> with a legacy `TERM` setting (this should help 3rd party software to upg=
rade to Git for Windows 2.x).
>=20
> Thanks.
> It seems that this link:
>=20
>    https://github.com/git-for-windows/git/releases/latest
>=20
> doesn't point to the latest release.
>=20
> Might be because the tags have the same date ?

Wooops. Sorry for being so slow (been interviewing today). It should be cor=
rect now, can you verify, please?

Thanks,
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
