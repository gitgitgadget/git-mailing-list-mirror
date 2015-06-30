From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: 4th release candidate of Git for Windows 2.x, was Re:
 3rd release candidate of Git for Windows 2.x
Date: Tue, 30 Jun 2015 20:15:23 +0300
Message-ID: <20150630201523.3a00a2afe9321fb28a6fc82d@domain007.com>
References: <d4680251b19275d9f243f8fe0ca383a4@www.dscho.org>
	<b085dab2e617742b690ccb99ba4a3076@www.dscho.org>
	<8224736a18724f751312d57e67967d69@www.dscho.org>
	<55910AE7.3000206@atlas-elektronik.com>
	<426859781bd04ca4ebb13719350537ed@www.dscho.org>
	<20150629185430.5dfbab069b5dbdf32398d290@domain007.com>
	<2abf219bf0235717eaa84889f94eb03c@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
        Stefan
 =?UTF-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
        Git Mailing List
 <git@vger.kernel.org>, msysgit@googlegroups.com,
        git-for-windows@googlegroups.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: msysgit+bncBCWKX34CSUCBBQM5ZOWAKGQE2BZOZJA@googlegroups.com Tue Jun 30 19:15:48 2015
Return-path: <msysgit+bncBCWKX34CSUCBBQM5ZOWAKGQE2BZOZJA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCWKX34CSUCBBQM5ZOWAKGQE2BZOZJA@googlegroups.com>)
	id 1Z9z8N-0004Z3-Q1
	for gcvm-msysgit@m.gmane.org; Tue, 30 Jun 2015 19:15:47 +0200
Received: by wggx12 with SMTP id x12sf7297386wgg.1
        for <gcvm-msysgit@m.gmane.org>; Tue, 30 Jun 2015 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-spam-checked-in-group:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe;
        bh=/6RjlyEBaOwxHZfmTW/7MzRZvP8vlW4eUEDBP5LP6QM=;
        b=DN8tYWazTf+0S5DZtYDvymiVh1ESEBXoh+wRklTzm2aC1olDH7/ehL1AKvEZjwvxb/
         MHPBz6CjUGZiNZ83/Yi+iTR09NIzxr2nVWH2mO2RYMz9qwm6DHDN94wmFncGGMkTgvCw
         H+Vne1cSwrZSLfsk3G4zmJ5PUiGYOounWomOsiAHLp4t83DLsjak4B0IyBcJnOe2ekY3
         7J8zMzxGTetzHltgMHddheEK4zmWTyjjhjSlZmb50SEcCOeGA8V2lPGApmufBpYYlbcZ
         yBkeYrj4Ju0JsRvDZp1Qrs9T5ViGuWsJljne7Y2e26hLcwdbAcnan8HmivGAxQByO/eu
         bBTw==
X-Received: by 10.152.8.39 with SMTP id o7mr206147laa.3.1435684547349;
        Tue, 30 Jun 2015 10:15:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.36.227 with SMTP id t3ls79260laj.72.gmail; Tue, 30 Jun
 2015 10:15:45 -0700 (PDT)
X-Received: by 10.112.200.163 with SMTP id jt3mr14586518lbc.17.1435684545206;
        Tue, 30 Jun 2015 10:15:45 -0700 (PDT)
Received: from mailhub.007spb.ru (mailhub.007spb.ru. [84.204.203.130])
        by gmr-mx.google.com with ESMTPS id h8si1626069lbd.3.2015.06.30.10.15.44
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 10:15:45 -0700 (PDT)
Received-SPF: neutral (google.com: 84.204.203.130 is neither permitted nor denied by best guess record for domain of flatworm@users.sourceforge.net) client-ip=84.204.203.130;
Received: from tigra.domain007.com ([192.168.2.102])
	(authenticated bits=0)
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id t5UHFODw026707
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 30 Jun 2015 20:15:25 +0300
In-Reply-To: <2abf219bf0235717eaa84889f94eb03c@www.dscho.org>
X-Mailer: Sylpheed 3.2.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-Original-Sender: flatworm@users.sourceforge.net
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 84.204.203.130 is neither permitted nor denied by best guess
 record for domain of flatworm@users.sourceforge.net) smtp.mail=flatworm@users.sourceforge.net
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273088>

On Mon, 29 Jun 2015 18:19:09 +0200
Johannes Schindelin <johannes.schindelin@gmx.de> wrote:

> > I've finally took time to switch from my old "msys1" release to this
> > RC4, and immediately got hit by the fact Git is now speaking to me
> > in Russian, which is not what I want (previously this behaviour was
> > only exhibited by `git gui` and `gitk`).
> > 
> > Should I make Git see LC_MESSAGES=en (or other thing like LANG) in
> > the environment or is there some Git-local method to affect this
> > behaviour? I tried to grep the release notes using relevant
> > keywords but was left empty-handed.
> 
> Personally, I would use LC_ALL=C. Maybe that's good for you, too?

After reading [1], I've ended up installing LANG=C into my user's
environment variables -- so far so good, thanks for the tip!

> I guess this would also make for a fine opportunity to add an option
> to the installer to switch the localization off?

I dunno.
While this definitely would be useful for some folks (mostly
old-school, like we do) but the problem with this setting is that it's
not specific to Git and can result in unpredictable behaviour in other
parts of the system.  Hence this option, if implemented, should somehow
be clearly marked as system-wide in the installer UI.

1. https://www.gnu.org/software/gettext/manual/html_node/Locale-Environment-Variables.html

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
