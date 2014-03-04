From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: My advice for GSoC applicants
Date: Tue, 04 Mar 2014 08:58:15 +0100
Message-ID: <53158797.6040405@alum.mit.edu>
References: <53145D48.3040603@alum.mit.edu> <xmqqa9d6or0p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>,
	Dmitry Dolzhenko <dmitrys.dolzhenko@yandex.ru>,
	Sun He <sunheehnus@gmail.com>,
	Brian Gesiak <modocache@gmail.com>,
	Tanay Abhra <tanayabh@gmail.com>,
	Kyriakos Georgiou <kyriakos.a.georgiou@gmail.com>,
	Siddharth Goel <siddharth98391@gmail.com>,
	Guanglin Xu <mzguanglin@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Alberto Corona <albcoron@gmail.com>,
	Jacopo Notarstefano <jacopo.notarstefano@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 08:58:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKkFB-0006wX-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 08:58:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756331AbaCDH6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 02:58:24 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43497 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756576AbaCDH6V (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 02:58:21 -0500
X-AuditID: 1207440d-f79d86d0000043db-c2-5315879cede3
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 84.51.17371.C9785135; Tue,  4 Mar 2014 02:58:20 -0500 (EST)
Received: from [192.168.69.148] (p57A2482C.dip0.t-ipconnect.de [87.162.72.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s247wFmL030802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 4 Mar 2014 02:58:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <xmqqa9d6or0p.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsUixO6iqDunXTTYYP1FXouG7SsZLQ5uPc1u
	0XWlm8miofcKs8Xy+WtYLGZv2cBm8Xr6cnaLX4efsFus2TeXzeLp3RvMFm23tzNa/LrwntmB
	x2PnrLvsHhcvKXt83iTncbihnyWAJYrbJimxpCw4Mz1P3y6BO+Pd+T72gq38FVv6pjI1MK7m
	6WLk5JAQMJGYc2cSI4QtJnHh3nq2LkYuDiGBy4wSV1d9ZYVwzjJJzNzzCqyKV0Bb4uXGCUBV
	HBwsAqoSW9azg4TZBHQlFvU0M4HYogLBEqsvP2CBKBeUODnzCZgtIqAmMbHtEAvITGaBaSwS
	PddWsYEkhAW0JPr6Z4MNEhKIknj84y/YIE4Ba4m716exgOySEBCX6GkMAgkzC+hIvOt7wAxh
	y0tsfzuHeQKj4Cwk62YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl0jvdzMEr3U
	lNJNjJC44d3B+H+dzCFGAQ5GJR7eGdNEgoVYE8uKK3MPMUpyMCmJ8r5rFA0W4kvKT6nMSCzO
	iC8qzUktPsQowcGsJMIrpw+U401JrKxKLcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2Cycpw
	cChJ8Fq2ATUKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEgyI4vhgYwyApHqC9rSDt
	vMUFiblAUYjWU4y6HLfbfn1iFGLJy89LlRLnfdwKVCQAUpRRmge3ApYkXzGKA30szNsFMooH
	mGDhJr0CWsIEtMTMTwRkSUkiQkqqgTE1aOvVCzfULM4uUjs5p86uYMah6abf18kV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243326>

On 03/03/2014 11:29 PM, Junio C Hamano wrote:
> [...]
> Multiple students seem to be hitting the same microprojects (aka "we
> are running out of micros"), which might be a bit unfortunate.  I
> think the original plan might have been that for a student candidate
> to pass, his-or-her patch must hit my tree and queued somewhere, but
> with these duplicates I do not think it is fair to disqualify those
> who interacted with reviewers well but solved an already solved
> micro.
> 
> Even with the duplicates I think we are learning how well each
> student respond to reviews (better ones even seem to pick up lessons
> from reviews on others' threads that tackle micros different from
> their own) and what his-or-her general cognitive ability is.

So far the list contains 10 microprojects, and as of yesterday I had
seen 10 students attempt them.  If I had made it clear from the
beginning that each student should pick only one project, then we
wouldn't be in all that bad a situation.

I might have time today to look for some more microprojects for the list
and to mark the ones that have already been attempted.  But other list
regulars should FEEL ENCOURAGED to submit microprojects to add to the
list.  (Either submit them as a pull request to the GitHub repository
that contains the text [1] or to the mailing list with CC to me.)  I was
hoping that writing the text and adding the first batch of microprojects
would be enough to get the ball rolling, but I'm not sure I have enough
time to be the one and only microproject muse.

On the other hand I've been very happy and grateful that other people
have taken a lot of time to interact with the students and give them
feedback on the mailing list.  I definitely think the students are
getting a realistic taste of how our community works.

Michael

[1] https://github.com/git/git.github.io

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
