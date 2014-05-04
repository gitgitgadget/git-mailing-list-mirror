From: James Denholm <nod.helm@gmail.com>
Subject: Re: Pull is Mostly Evil
Date: Sun, 04 May 2014 20:37:19 +1000
Message-ID: <2bbbfedd-b224-4ef0-a611-fe78d3446db8@email.android.com>
References: <5363BB9F.40102@xiplink.com> <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com> <5364A143.1060404@bbn.com> <87iopnwa2i.fsf@fencepost.gnu.org> <5364b11b4db8d_1996f531068@nysa.notmuch> <87eh0bw5gh.fsf@fencepost.gnu.org> <alpine.DEB.2.02.1405032129420.25156@nftneq.ynat.uz> <5365c45fd101d_6c25cd72ec2e@nysa.notmuch> <eae08db4-f59f-4237-8f04-ebf33dbf6f67@email.android.com> <53660d8d74c68_1c89b0930c53@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Richard Hansen <rhansen@bbn.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>,
	David Lang <david@lang.hm>, David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun May 04 12:37:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wgtnf-0005Z2-49
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 12:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbaEDKh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 06:37:29 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:48939 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbaEDKh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 06:37:29 -0400
Received: by mail-pd0-f175.google.com with SMTP id fp1so1506459pdb.6
        for <git@vger.kernel.org>; Sun, 04 May 2014 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=7aTsCmwD6L6wzjDpt3IlaJ530Rl7dh1KKSxTzGZWeVk=;
        b=TJeqskeXLOAkX/obNgvw7buMatE7SA2o2WNh44ZbMChfwwF96plUmpRgojtaxZHy9A
         8qlHmEPlqj/h+G5G66zVmW5SDVJguT6G0K23sEtxsyga+qZ1zvgDJdsektzL70gxVNmu
         WvB1e31zO4ssmxbhu8qPr7Smmm153p1Ek0rxp3a5B41zrykM08/Cw0PP4NuQpC0Rdwiy
         1CbDC7Yxbfe9Qep8xr9gmlRYXaFJvNrI9HNkezN3smiVjIdyP2BKAeXKFW2POYZnySLy
         b5PvPAVTxGOvcGR6wb216vjrGPwkfFVIu/Dk9EaIBgr9t1YjR0LqRxgSSJGWcLCMNlUC
         C+Ew==
X-Received: by 10.66.181.70 with SMTP id du6mr57739600pac.23.1399199848329;
        Sun, 04 May 2014 03:37:28 -0700 (PDT)
Received: from [10.85.81.43] ([101.119.28.191])
        by mx.google.com with ESMTPSA id yv7sm42206353pac.33.2014.05.04.03.37.24
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 04 May 2014 03:37:27 -0700 (PDT)
User-Agent: Kaiten Mail
In-Reply-To: <53660d8d74c68_1c89b0930c53@nysa.notmuch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248091>

On 4 May 2014 19:51:09 GMT+10:00, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>James Denholm wrote:
>> Felipe Contreras wrote:
>> >David Lang wrote:
>> >> the vast majority of people here do not take that attitude.
>> >
>> >It's actually the exact opposite. I don't care what is the track
>record
>> >of the people in the discussion.
>> 
>> Ah, yes, like that discussion we once had where you totally didn't
>run
>> `git log | grep James Denholm` at one point to demonstrate that I had
>> not yet made any contributions,instead of actually engaging in
>> discussion. Oh, wait.
>
>You mean this thread[1] in which I sent 14 mails directly to you? Yeah,
>I din't engage in that discussion at all!

Yeah, you didn't. Instead you danced, but I guess it's
really all said and done now so eh, have your point.

>> >If their argument is good, their argument is good.
>> 
>> The problem, though, is that time and time again you've shown that
>you
>> value your own arguments to the exclusion of all others. You can't
>> tell if someone else's argument is good, because it runs against
>> yours, and yours must be right because you hold it.
>
>I can show you evidence of how that's a blatant lie. Just two days ago
>I
>changed my mind because somebody provided a good argument.

And I can show you evidence of you being
indiscourseable on the topic of your pet proposals,
but I won't, because you're indiscourseable on the
meta similarly.

>But I'm not going to bother any more with you, you are just spreading
>lies and tainting the discussion.

Well, maybe we'll see what other folks think.

Regards,
James Denholm.
