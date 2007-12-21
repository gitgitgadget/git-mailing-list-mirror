From: Steffen Prohaska <prohaska-wjoc1KHpMeg@public.gmane.org>
Subject: msysgit Git-1.5.4-rc1 available
Date: Fri, 21 Dec 2007 11:05:59 +0100
Message-ID: <0F6939E0-686C-4526-85D1-447C080230A5@zib.de>
Reply-To: prohaska-wjoc1KHpMeg@public.gmane.org
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, msysGit <msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Fri Dec 21 11:06:08 2007
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wr-out-0708.google.com ([64.233.184.250])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5ekq-0003iy-32
	for gcvm-msysgit@m.gmane.org; Fri, 21 Dec 2007 11:05:53 +0100
Received: by wr-out-0708.google.com with SMTP id 56so1502513wra.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 21 Dec 2007 02:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:received:mime-version:content-type:message-id:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=yCwU0puACdLnB9agaI+uFdcosL5WmabY0t49KCRLfyk=;
        b=rSCslpQtlRT63KoyByvWD9X4K/U1eCBSatv6i+D1xnQtXmuYkLR7V+2S0stTbyR1ZAOowPH1j9PipO5VZXCyySb8Op/x5dXFRR7MR/PKrVvcYkLg79stSkI6vnmVWf4SXJ6DQu3BWLeB6HVVCmgLkRLwGTddaKxT4h+WvPF+cNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:mime-version:content-type:message-id:content-transfer-encoding:from:subject:date:to:x-mailer:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=3P5sCTYYIbB78xDodXExTXE989y9LQvlDEne/hd+pH/NyzomwzWXeUuYlX21CElutZpPWJBKZhweM42FUZyIK/jsBGK8eDE5vKXdeazNAGCzhwg1dwIXCYwg8bphqFlJcuKCrf/urykhB/QvDYOJ/myU7moenW0Jr2YP6VuVwQA=
Received: by 10.100.152.19 with SMTP id z19mr6955and.12.1198231495755;
        Fri, 21 Dec 2007 02:04:55 -0800 (PST)
Received: by 10.107.94.14 with SMTP id w14gr1273prl;
	Fri, 21 Dec 2007 02:04:55 -0800 (PST)
X-Sender: prohaska-wjoc1KHpMeg@public.gmane.org
X-Apparently-To: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.65.132.13 with SMTP id j13mr950973qbn.2.1198231495359; Fri, 21 Dec 2007 02:04:55 -0800 (PST)
Received: from mailer.zib.de (mailer.zib.de [130.73.108.11]) by mx.google.com with ESMTP id 20si4779749nzu.0.2007.12.21.02.04.54; Fri, 21 Dec 2007 02:04:55 -0800 (PST)
Received-SPF: pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) client-ip=130.73.108.11;
Authentication-Results: mx.google.com; spf=pass (google.com: best guess record for domain of prohaska-wjoc1KHpMeg@public.gmane.org designates 130.73.108.11 as permitted sender) smtp.mail=prohaska-wjoc1KHpMeg@public.gmane.org
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31]) by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lBLA4rxT025681; Fri, 21 Dec 2007 11:04:53 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185]) (authenticated bits=0) by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lBLA4qLp029434 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO); Fri, 21 Dec 2007 11:04:53 +0100 (MET)
X-Mailer: Apple Mail (2.752.3)
Sender: msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org;
	contact msysgit-owner-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <mailto:msysgit-help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69050>


for download from

http://msysgit.googlecode.com/files/Git-1.5.4-rc1-preview20071221.exe

	Steffen
