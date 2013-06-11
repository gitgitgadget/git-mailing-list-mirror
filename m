From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Documentation/CommunityGuidelines
Date: Tue, 11 Jun 2013 20:43:34 +0200
Message-ID: <51B76FD6.7070304@alum.mit.edu>
References: <CALkWK0mqk5sRPV8PHz8RqZH-Ln7TUtkHPVbvsJPKuVSXiUOiww@mail.gmail.com> <51B6AA7F.1060505@alum.mit.edu> <CALkWK0nNn8Rcu4JpV4r+0ct+_cuW3aUHXKV4bcB-Hn6Xg8Y+bA@mail.gmail.com> <87li6g969j.fsf@linux-k42r.v.cablecom.net> <CALkWK0kMvac7Sp3QwvEm+J_-Hj7JAn-AY-juDDw1HR3oQ+hamA@mail.gmail.com> <51B736FA.5010407@alum.mit.edu> <CALkWK0n=gbfeG87GCR0A=fZY5osjndLo9TPv1BH1uAf37eQ8=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	A Large Angry SCM <gitzilla@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 20:43:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmTXj-00016H-41
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 20:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab3FKSnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 14:43:39 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47653 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751494Ab3FKSni (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jun 2013 14:43:38 -0400
X-AuditID: 1207440e-b7f0f6d0000043b7-df-51b76fd9be9b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 32.02.17335.9DF67B15; Tue, 11 Jun 2013 14:43:37 -0400 (EDT)
Received: from [192.168.69.140] (p57A251F0.dip0.t-ipconnect.de [87.162.81.240])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5BIhYr3007152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Jun 2013 14:43:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <CALkWK0n=gbfeG87GCR0A=fZY5osjndLo9TPv1BH1uAf37eQ8=g@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsUixO6iqHszf3ugweQFBharZj5mt+i60s1k
	0dB7hdli2s9drBZvby5htLh7eRW7A5vHzll32T1uv57P7HHxkrLH501yASxR3DZJiSVlwZnp
	efp2CdwZK6YvYS+YylXRtv8LWwNjD0cXIyeHhICJxKHp15ggbDGJC/fWs3UxcnEICVxmlLjT
	d5oVwjnPJNE69z8LSBWvgLbEzq4OZhCbRUBV4uOvP2DdbAK6Eot6msFsUYEwiffLprJC1AtK
	nJz5BKiXg0MEqObZKm+QmcwCFxglTk7axAhSIyxgJnHsxUwWiGVdzBLdGz+wgSQ4BQIlTu6c
	yAzSzCygLrF+nhBImFlAXmL72znMExgFZiFZMQuhahaSqgWMzKsY5RJzSnN1cxMzc4pTk3WL
	kxPz8lKLdI31cjNL9FJTSjcxQkKcbwdj+3qZQ4wCHIxKPLwHzLYHCrEmlhVX5h5ilORgUhLl
	PZ8NFOJLyk+pzEgszogvKs1JLT7EKMHBrCTCq5sLlONNSaysSi3Kh0lJc7AoifOqLVH3ExJI
	TyxJzU5NLUgtgsnKcHAoSfDeygNqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdF
	anwxMFZBUjxAex+CtPMWFyTmAkUhWk8x6nLM+DH5HaMQS15+XqqUOC8PMCUJCYAUZZTmwa2A
	JbRXjOJAHwvzKoFU8QCTIdykV0BLmICWFGWALSlJREhJNTCGbl23RtPxx7S8XrHOQ4s9xfc5
	Szm/cAh/MHFGye17Hoa3bXSn3e3g/MGWlj7/w/P1Jmb7WP+4HiiN4o9/m70sh/n+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227493>

On 06/11/2013 08:16 PM, Ramkumar Ramachandra wrote:
> This is an exercise.  I can easily be more tactful (as evidenced by
> other threads), but I'm choosing not to be.  I want you to focus on
> the argument, and not the tone.

I stopped reading your email here.  I've read enough tactless emails
over the last few days, but to be asked to read an email that was
*intentionally* written tactlessly is too detrimental to my quality of life.

In German there is an expression "Der Ton macht die Musik": "the tone
makes the music", by which they mean that the *way* something is said is
at least as important as what is said.  The tone *is* an integral part
of the message and (1) the writer will be much more effective by making
the tone agree with the literal words of the message and (2) for this
particular reader, the effort of accommodating writers who are unwilling
to do so has become too exhausting.

I naively thought that I might be able to help calm the situation, but I
have concluded that nothing I can say or do will have that effect.
Therefore I bow out of this part of the conversation and hope either
that it will fizzle out or that perhaps a deus ex machina will appear.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
