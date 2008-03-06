From: "Jim Raden" <james.raden@gmail.com>
Subject: Re: The 8th airing of the msysGit herald
Date: Wed, 5 Mar 2008 21:03:27 -0500
Message-ID: <5fc54b450803051803t4dda4341ue3ac403c742f1903@mail.gmail.com>
References: <alpine.LSU.1.00.0803022329560.22527@racer.site> <200803030210.02223.jnareb@gmail.com> <47CBE85B.6060702@imap.cc> <7vablfiv42.fsf@gitster.siamese.dyndns.org> <47CC432B.8060502@imap.cc> <7v1w6rh1ru.fsf@gitster.siamese.dyndns.org> <46a038f90803031458t2b404212t10f6e9ae710dc408@mail.gmail.com> <47CF2F61.5060208@imap.cc> <alpine.LSU.1.00.0803060121360.15786@racer.site> <7vskz4heeg.fsf@gitster.siamese.dyndns.org>
Reply-To: james.raden@gmail.com
Mime-Version: 1.0
Content-Type: multipart/alternative;  boundary="----=_Part_8322_4597575.1204769007789"
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,  "Tilman Schmidt" <tilman@imap.cc>,  "Martin Langhoff" <martin.langhoff@gmail.com>,  "Jakub Narebski" <jnareb@gmail.com>, msysgit@googlegroups.com,  git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Thu Mar 06 03:04:12 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.243])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX5Sp-0004Yf-04
	for gcvm-msysgit@m.gmane.org; Thu, 06 Mar 2008 03:04:07 +0100
Received: by wa-out-0708.google.com with SMTP id n36so6079213wag.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 05 Mar 2008 18:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to:received:received:received-spf:authentication-results:received:dkim-signature:domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        bh=mjNNQL64qrxedAqYkFGG9eHpWkRoaFQQPuJrjG85s14=;
        b=nBCToYNhH79bMD5NLXcrXgf7cBdB3UiDhkU+dcLh1iDH98+AOHEjS44hBiNQ6PnrqlEAbJywrKBBUvp8cqC+Jn8Ux4qm5njiVRDZPChqxoK4hbqG/fu32KQH/RL4y/tr8szbsnRLZr3wpg4hVoXAp4EzKTwoAjl7T9bVNLSVFDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:dkim-signature:domainkey-signature:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references:reply-to:sender:precedence:x-google-loop:mailing-list:list-id:list-post:list-help:list-unsubscribe;
        b=3X6uzhs8pmy7FmxptXCgEtO2G/kxwL+7wFxlRHp/rku4YV97JPpcKLi1ZybTW3wxIIX5Mc9EmGWfj9Ntz8Mkk8DXas4+EqvUHqBInv7Vc+Ir6gJxjf6FjpjaNCg6GWWP6BDJ2CLcN7JisJKJ83ys5VZLhdyI09QBMQFFNpfahQo=
Received: by 10.114.25.3 with SMTP id 3mr162769way.22.1204769009826;
        Wed, 05 Mar 2008 18:03:29 -0800 (PST)
Received: by 10.106.191.30 with SMTP id o30gr1919prf.0;
	Wed, 05 Mar 2008 18:03:29 -0800 (PST)
X-Sender: james.raden@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.58.1 with SMTP id g1mr1662186waa.8.1204769008841; Wed, 05 Mar 2008 18:03:28 -0800 (PST)
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.186]) by mx.google.com with ESMTP id v36si5221792wah.3.2008.03.05.18.03.28; Wed, 05 Mar 2008 18:03:28 -0800 (PST)
Received-SPF: pass (google.com: domain of james.raden@gmail.com designates 64.233.170.186 as permitted sender) client-ip=64.233.170.186;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of james.raden@gmail.com designates 64.233.170.186 as permitted sender) smtp.mail=james.raden@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by rn-out-0910.google.com with SMTP id s28so742615rnb.20 for <msysgit@googlegroups.com>; Wed, 05 Mar 2008 18:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references; bh=IaDYN72fMuHm2yOLEqeULl8/pk3YBPuO9vK+/60thKk=; b=LxQ/cEZtLNkNb8ciF5AVYMzO1xjrP6aeTH54SxjsVoRxUaEcJDajoe5L8DqScpHt4uWxd3rFQZ9Id/VvgY9mN4Cm/wOJVkdv548e1MqamlYeFU0zE/AvLdYIudPuYWEEaABPCiLWqBIJDM2TMaAgSIDHDQMkHENgNb+0tIXCp88=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references; b=NiUbEHuggQfJnnrch5eOP/s+kkFLVesaWlSkSoOkUze/27ilSky1lQYvWuZp2EHQS0oHhocAjyeu4anVp4QxO+1I/H+/Hg+ipVp/2y8ddW35+sOGlZH+BHK9PdYnyDO1LaPmx4+PjqiLeEBI8yO3UwibjwEgWs5wcVURctZznVg=
Received: by 10.115.58.1 with SMTP id l1mr5806284wak.110.1204769007795; Wed, 05 Mar 2008 18:03:27 -0800 (PST)
Received: by 10.114.198.3 with HTTP; Wed, 5 Mar 2008 18:03:27 -0800 (PST)
In-Reply-To: <7vskz4heeg.fsf@gitster.siamese.dyndns.org>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76307>


------=_Part_8322_4597575.1204769007789
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Perhaps adopting a convention for the subject line, like "Usage question:
xxxxxxxxxxxxxxxxxxxxx"? We're still a small list, so it wouldn't be horribly
cumbersome. If the list grew beyond 150 or
so<http://en.wikipedia.org/wiki/Dunbar%27s_number>active users, or if
the signal:noise ratio grew too low, perhaps then that
would be a good time to readdress the issue.

I confess that I haven't had to deal with such things before, so I'm not
familiar with the practices that may work in other groups faced with a
similar issue.

On Wed, Mar 5, 2008 at 7:41 PM, Junio C Hamano <gitster@pobox.com> wrote:

>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Thu, 6 Mar 2008, Tilman Schmidt wrote:
> >
> >> would it be possible to have separate mailing lists for usage topics
> and
> >> for discussions of ongoing development? I imagine that might help those
> >> who just want to use git (like me) to find their way around.
> >
> > AFAIAC you can have your "users-only" mailing list.  Personally, I will
> > never look at it, though, since all I am interested in is the
> development
> > of Git.  If that holds true for the majority of Git _developers_, it
> might
> > even be a bad idea to have a separate users' list, since then
> >
> > - no ideas from strictly-users would flow to the developers, and
> >
> > - new developments would not reach you, and
> >
> > - you would not get help by the people knowing the internals _deeply_.
>
> Personally, I suspect I would end up subscribing to both, but
> two mailing lists would make it much more cumbersome than
> necessary to correlate the original user "itch" request that
> triggered an enhancement, the discussion that clarified the
> design constraints and requirements, and the patch and the
> review comments that lead to the final implementation,
> especially if you do not encourage cross posting to both lists.
> And of course cross posting will make user-only list more
> technical which would defeat the original point of having two
> lists.
>
> "users-only" list could probably created by readers' MUA, by
> picking emails that do not have "diff --git" in its body; that
> would probably be a good enough approximation for people who are
> not interested in the technical discussions.
>

------=_Part_8322_4597575.1204769007789
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Perhaps adopting a convention for the subject line, like &quot;Usage question: xxxxxxxxxxxxxxxxxxxxx&quot;? We&#39;re still a small list, so it wouldn&#39;t be horribly cumbersome. If the list grew beyond <a href="http://en.wikipedia.org/wiki/Dunbar%27s_number">150 or so</a> active users, or if the signal:noise ratio grew too low, perhaps then that would be a good time to readdress the issue.<br>
<br>I confess that I haven&#39;t had to deal with such things before, so I&#39;m not familiar with the practices that may work in other groups faced with a similar issue.<br><br><div class="gmail_quote">On Wed, Mar 5, 2008 at 7:41 PM, Junio C Hamano &lt;<a href="mailto:gitster@pobox.com">gitster@pobox.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class="Ih2E3d"><br>
Johannes Schindelin &lt;<a href="mailto:Johannes.Schindelin@gmx.de">Johannes.Schindelin@gmx.de</a>&gt; writes:<br>
<br>
</div><div class="Ih2E3d">&gt; On Thu, 6 Mar 2008, Tilman Schmidt wrote:<br>
&gt;<br>
&gt;&gt; would it be possible to have separate mailing lists for usage topics and<br>
&gt;&gt; for discussions of ongoing development? I imagine that might help those<br>
&gt;&gt; who just want to use git (like me) to find their way around.<br>
&gt;<br>
&gt; AFAIAC you can have your &quot;users-only&quot; mailing list. &nbsp;Personally, I will<br>
&gt; never look at it, though, since all I am interested in is the development<br>
&gt; of Git. &nbsp;If that holds true for the majority of Git _developers_, it might<br>
&gt; even be a bad idea to have a separate users&#39; list, since then<br>
&gt;<br>
&gt; - no ideas from strictly-users would flow to the developers, and<br>
&gt;<br>
&gt; - new developments would not reach you, and<br>
&gt;<br>
&gt; - you would not get help by the people knowing the internals _deeply_.<br>
<br>
</div>Personally, I suspect I would end up subscribing to both, but<br>
two mailing lists would make it much more cumbersome than<br>
necessary to correlate the original user &quot;itch&quot; request that<br>
triggered an enhancement, the discussion that clarified the<br>
design constraints and requirements, and the patch and the<br>
review comments that lead to the final implementation,<br>
especially if you do not encourage cross posting to both lists.<br>
And of course cross posting will make user-only list more<br>
technical which would defeat the original point of having two<br>
lists.<br>
<br>
&quot;users-only&quot; list could probably created by readers&#39; MUA, by<br>
picking emails that do not have &quot;diff --git&quot; in its body; that<br>
would probably be a good enough approximation for people who are<br>
not interested in the technical discussions.<br>
</blockquote></div><br>

------=_Part_8322_4597575.1204769007789--
