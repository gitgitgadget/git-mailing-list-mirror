From: Stefan Saasen <ssaasen@atlassian.com>
Subject: Fwd: Add a bugzilla website
Date: Mon, 13 Jan 2014 12:06:54 +1100
Message-ID: <CADoxLGNY6mPNu=d-zXN_Tatp-LbfodWXWQWKZsvmDibqZhXCcQ@mail.gmail.com>
References: <20131115085326.GA2401@brouette> <551223703.314994127.1384508447263.JavaMail.root@zimbra35-e6.priv.proxad.net>
 <20131115135132.431d3e344dadee64e2be5127@domain007.com> <CAH5451=+N1vYoNeweQXe9vavjmRvkEzP=7U+mDf-0zH9OSpZPA@mail.gmail.com>
 <CADoxLGPnoo_fXsQXE2jb_H4Otf9eRWsN=nQP9smhPbt20H-72Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: andrew.ardill@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 13 02:08:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2W0W-00006R-LK
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 02:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbaAMBHg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jan 2014 20:07:36 -0500
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39207 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750899AbaAMBHf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 20:07:35 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]) (using TLSv1) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUtM8Vmi5A0Irkn0dHz61lEM0156OJpSL@postini.com; Sun, 12 Jan 2014 17:07:35 PST
Received: by mail-oa0-f54.google.com with SMTP id o6so7324775oag.41
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 17:07:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=98kQeBJ0AkvuIDp52TAKztpr99sexaNVevdPzCEtauM=;
        b=GJPPThofnlaCk94GMUNJLxqq2RN0/UrkHecffoYyOuzAWxwXLRrLCR9wjFuNuiv/gh
         6g+j3dmK18KW9tgv3MqfpSsrYett7Ir4bVZpjlsw8Yp4N66+d+lf/JyT/fSM/meM9Stf
         zuOp1FP7Df0VgBWj8KDovWvMS3sX4mcBTf04e/dUUTwiJYgnzCoMYIhi03uYb5PkXFsw
         6Wjq+awCNNiWrsgkBNOaPckwgHXl2/A+s56sneVUdME9X0T1wIT+sGUJsa1HWfnHrUK5
         Ryut/xadYH4NepsZPJKhjnovMSghaYWvWvVmira4t0nAB4ehu9H+4mCCq0jR/9WM9EHn
         Iq0g==
X-Gm-Message-State: ALoCoQlu2bJdE90N67r2w87hNIr/ed7a+3vfOjfVXVWzuJBMrUKIlaZdF41HFQglKZH2r3pidkDuCqypTbTIutYu6Sp6rnarv9XczafabOFFmUPskABZ7SXn/SfK0SSquIzOE9djMQXzazCNKcQ8IbUabBi/LrLTGA==
X-Received: by 10.182.43.161 with SMTP id x1mr18357095obl.5.1389575254264;
        Sun, 12 Jan 2014 17:07:34 -0800 (PST)
X-Received: by 10.182.43.161 with SMTP id x1mr18357090obl.5.1389575254177;
 Sun, 12 Jan 2014 17:07:34 -0800 (PST)
Received: by 10.76.80.10 with HTTP; Sun, 12 Jan 2014 17:06:54 -0800 (PST)
In-Reply-To: <CADoxLGPnoo_fXsQXE2jb_H4Otf9eRWsN=nQP9smhPbt20H-72Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240355>

> In any case, adding value to the existing process is hard (because it
> works quite well!) and probably requires significantly more work to
> even understand what that value might look like. This, I think, is th=
e
> key reason it is hard to truly get started with any bug tracking
> solution; the solution is not obvious, and the current (very
> customised) workflow is not supported directly by any tool.
>
> Regards,
>
> Andrew Ardill
>
> [1] https://git-scm.atlassian.net


I think you summarised the challenges very well and I don=E2=80=99t thi=
nk there is an
obvious answer to that.

I=E2=80=99d just like to offer any help that I or we (Atlassian) could =
give you. Given
your experience with JIRA I=E2=80=99m sure that you=E2=80=99ve got ever=
ything covered, but if
you need anything, please ping me.

Re-reading the old discussions there was a concern that the issue data =
was not
available, I just wanted to chime in and mention that if you are using =
a JIRA
OnDemand (e.g. the https://git-scm.atlassian.net) instance you can get =
the full
backup of your data (including any attachments, data available as XML) =
and
there is a JIRA REST API as well.

I know that this is just a very tangential concern given the challenges=
 of
making an issue tracker work with an email based workflow that has prov=
en quite
successful but I at least wanted to address that and offer any help you=
 might
need.


Cheers,
Stefan
