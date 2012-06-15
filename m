From: Konstantin Khomoutov <flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: Re: Re: how to get the formated patches from the merge id
Date: Fri, 15 Jun 2012 16:28:42 +0400
Message-ID: <20120615162842.90e63870.kostix@domain007.com>
References: <CAHsH0E98t7EcvXM0zSjMGHcd5u4_Lp6B7q9KAhcE0eyo-tXnWw@mail.gmail.com>
	<9579793f-d72f-424c-9546-f2caa1fbf847@googlegroups.com>
	<CAHsH0E995C2Fsiyr=MZOH2VyN=mFvnWjrV=6LWkfv-YLy+2RjQ@mail.gmail.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, tfnico-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lei yang <yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
X-From: git-users+bncCKyr74KVBBCA1ez-BBoERo-WBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Jun 15 14:28:49 2012
Return-path: <git-users+bncCKyr74KVBBCA1ez-BBoERo-WBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-fa0-f58.google.com ([209.85.161.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncCKyr74KVBBCA1ez-BBoERo-WBA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SfVdw-0006s9-QF
	for gcggu-git-users@m.gmane.org; Fri, 15 Jun 2012 14:28:48 +0200
Received: by faaa20 with SMTP id a20sf1450782faa.3
        for <gcggu-git-users@m.gmane.org>; Fri, 15 Jun 2012 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:date:from:to:cc:subject:message-id
         :in-reply-to:references:x-mailer:mime-version:x-original-sender
         :x-original-authentication-results:reply-to:precedence:mailing-list
         :list-id:x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=V3lXPhLr9QUSJ7K5dStbzHpW66lo5v4lVhHebO00ICo=;
        b=V8f413pDAXRXVklA+molwGVCeykBA1Rk2lT3ckDFb0AvpIQhepgp09AR+W42I6VLDd
         6+Y+qPU+zLvSS6R/qdAhRnhrzvkMWTT3+PgsaPFAjmoQ83KPEVKljITdNi6B0qmcD79P
         cjsSnEv/lgcLM1eWnVgVm1gm1BAX7yFzOQ+2s=
Received: by 10.204.155.143 with SMTP id s15mr319073bkw.3.1339763328669;
        Fri, 15 Jun 2012 05:28:48 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.204.8.149 with SMTP id h21ls1431809bkh.3.gmail; Fri, 15 Jun
 2012 05:28:46 -0700 (PDT)
Received: by 10.204.149.210 with SMTP id u18mr826196bkv.1.1339763326715;
        Fri, 15 Jun 2012 05:28:46 -0700 (PDT)
Received: by 10.204.149.210 with SMTP id u18mr826195bkv.1.1339763326688;
        Fri, 15 Jun 2012 05:28:46 -0700 (PDT)
Received: from mailhub.007spb.ru (mailhub.007spb.ru. [84.204.203.130])
        by gmr-mx.google.com with ESMTPS id p5si6994250bks.1.2012.06.15.05.28.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 05:28:46 -0700 (PDT)
Received-SPF: neutral (google.com: 84.204.203.130 is neither permitted nor denied by best guess record for domain of flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) client-ip=84.204.203.130;
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id q5FCSgZ9016841;
	Fri, 15 Jun 2012 16:28:43 +0400
In-Reply-To: <CAHsH0E995C2Fsiyr=MZOH2VyN=mFvnWjrV=6LWkfv-YLy+2RjQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
X-Mailer: Sylpheed 3.1.1 (GTK+ 2.10.14; i686-pc-mingw32)
X-Original-Sender: flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=neutral (google.com:
 84.204.203.130 is neither permitted nor denied by best guess record for
 domain of flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org) smtp.mail=flatworm-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Precedence: list
Mailing-list: list git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact git-users+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <git-users.googlegroups.com>
X-Google-Group-Id: 934228491576
List-Post: <http://groups.google.com/group/git-users/post?hl=en_US>, <mailto:git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:git-users+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/git-users?hl=en_US>
Sender: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/git-users/subscribe?hl=en_US>, <mailto:git-users+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/git-users/subscribe?hl=en_US>,
 <mailto:googlegroups-manage+934228491576+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200048>

On Fri, 15 Jun 2012 19:46:22 +0800
lei yang <yanglei.fage-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> I have a commit like below
> commit 0e93b4b304ae052ba1bc73f6d34a68556fe93429
> Merge: b724cc1 51bfd29
> 
> This commit done this work: merge b724cc1..51bfd29 commit,
This is a gross misunderstanding of how revision ranges work in Git.
Please read the "gitrevisions" manual page.
More precisely, the A..B notation means "All commits reachable from B
excluding those reachable from A".
A merge means that two lines of history (those ending with commits
b724cc1 and 51bfd29, respectively) are merged together.
Writing this as b724cc1..51bfd29 is incorrect and confusing for
the readers.

> The question is how could I *onlys* through
> 0e93b4b304ae052ba1bc73f6d34a68556fe93429 to get the formated patch for
> the commit(b724cc1..51bfd29)
This phrase again missies a predicate (a verb) so we consistently
fail to comprehend your intent.
You could try to find a colleague with a bit better English skill and
ask his/her to provide a better translation so we're able to understan
it.
Also try to get rid of that ".." notation as it seems to ruin your
attempts to get us understand the matter.

-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.
