From: theProphet <dreamingforward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: git add "This file is for the blah class"
Date: Sun, 19 Aug 2012 11:45:46 -0700 (PDT)
Message-ID: <e0c6edc0-9ff5-491e-9e74-d91cd1330f47@googlegroups.com>
Reply-To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_1031_21777848.1345401946568"
Cc: git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: git-users+bncCLC3jq6SGBDd6MSBBRoE_ZaMeg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sun Aug 19 20:45:52 2012
Return-path: <git-users+bncCLC3jq6SGBDd6MSBBRoE_ZaMeg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcggu-git-users@m.gmane.org
Received: from mail-pb0-f58.google.com ([209.85.160.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-users+bncCLC3jq6SGBDd6MSBBRoE_ZaMeg-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1T3AVT-0004h8-Qu
	for gcggu-git-users@m.gmane.org; Sun, 19 Aug 2012 20:45:52 +0200
Received: by pbcmd12 with SMTP id md12sf3732156pbc.3
        for <gcggu-git-users@m.gmane.org>; Sun, 19 Aug 2012 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:date:from:to:cc:message-id:subject:mime-version
         :x-original-sender:x-original-authentication-results:reply-to
         :precedence:mailing-list:list-id:x-google-group-id:list-post
         :list-help:list-archive:sender:list-subscribe:list-unsubscribe
         :content-type;
        bh=pJCbSrLoPWPCZ/OCt9eUIvLgaDunlFJch3timKACFKc=;
        b=bqEY1baDKSWdArhETGrAIVhwfjiCiBi4X8xFrgaCdbAFg3ZpsvqRWwjY9s1cGm3swz
         JFwQ8Nqv8KvoRa/K8JJGaK5oyGA2SUJ1cPoVII4v64roRhn+myRvgQfviOBjNaP13w7a
         KAjKtf95q9Txx7DqM9V+Im1Tzeh9WSbO9a0CM=
Received: by 10.182.13.35 with SMTP id e3mr265874obc.12.1345401949059;
        Sun, 19 Aug 2012 11:45:49 -0700 (PDT)
X-BeenThere: git-users-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.182.47.99 with SMTP id c3ls3614952obn.0.gmail; Sun, 19 Aug
 2012 11:45:48 -0700 (PDT)
Received: by 10.182.11.40 with SMTP id n8mr262694obb.1.1345401948356;
        Sun, 19 Aug 2012 11:45:48 -0700 (PDT)
X-Original-Sender: dreamingforward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
X-Original-Authentication-Results: ls.google.com; spf=pass (google.com: domain of
 dreamingforward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org designates internal as permitted sender)
 smtp.mail=dreamingforward-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; dkim=pass
 header.i=@gmail.com
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203728>

------=_Part_1031_21777848.1345401946568
Content-Type: text/plain; charset=ISO-8859-1

I'm finding it annoying when browsing repositories at github and such that 
the description on every file and directory is only the last commit message 
given for that file.

I think it would be much more organizationally useful if the "git add" 
command accepted a message that will be associated with that file that 
describes its purpose.  A file name just isn't adequate to do the job and 
there's nowhere else where this is tracked.

Thanks guys!

mark
github/Social-Garden.


-- 
You received this message because you are subscribed to the Google Groups "Git for human beings" group.
To view this discussion on the web visit https://groups.google.com/d/msg/git-users/-/z8QL0uzNBCIJ.
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
To unsubscribe from this group, send email to git-users+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit this group at http://groups.google.com/group/git-users?hl=en.


------=_Part_1031_21777848.1345401946568
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I'm finding it annoying when browsing repositories at github and such that =
the description on every file and directory is only the last commit message=
 given for that file.<div><br></div><div>I think it would be much more orga=
nizationally useful if the "git add" command accepted a message that will b=
e associated with that file that describes its purpose. &nbsp;A file name j=
ust isn't adequate to do the job and there's nowhere else where this is tra=
cked.</div><div><br></div><div>Thanks guys!</div><div><br></div><div>mark</=
div><div>github/Social-Garden.</div><div><br></div><div><br></div>

<p></p>

-- <br />
You received this message because you are subscribed to the Google Groups "=
Git for human beings" group.<br />
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msg/git-users/-/z8QL0uzNBCIJ">https://groups.google.com/d/msg/git-user=
s/-/z8QL0uzNBCIJ</a>.<br />=20
To post to this group, send email to git-users-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org<br />
To unsubscribe from this group, send email to git-users+unsubscribe@googleg=
roups.com.<br />

For more options, visit this group at http://groups.google.com/group/git-us=
ers?hl=3Den.<br />



------=_Part_1031_21777848.1345401946568--
