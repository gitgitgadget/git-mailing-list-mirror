From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 09:09:52 +0200
Message-ID: <517F6E40.1040606@alum.mit.edu>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com> <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 09:10:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UX4hN-0008D7-GG
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 09:10:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755527Ab3D3HJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 03:09:57 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:50823 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752965Ab3D3HJ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 03:09:56 -0400
X-AuditID: 1207440e-b7f2b6d00000094c-24-517f6e447f7b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id BE.D9.02380.44E6F715; Tue, 30 Apr 2013 03:09:56 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3U79rIe029820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 30 Apr 2013 03:09:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJKsWRmVeSWpSXmKPExsUixO6iqOuSVx9ocOsPs8WqmY/ZLQ4+zrNY
	8+I0s0XXlW4mi4beK8wWS+doW3RPecvowO7ROnkSs8fOWXfZPS5eUvb4vEkugCWK2yYpsaQs
	ODM9T98ugTvj97rnrAUtvBV3fz5lbmBcxdXFyMEhIWAiMfFFXBcjJ5ApJnHh3nq2LkYuDiGB
	y4wSX5uXMEE4x5kkVnR9YASp4hXQljjV+ZcZxGYRUJW4fGUFC4jNJqArsainmQnEFhUIk1i1
	fhkzRL2gxMmZT8BqRASUJN50bGMGGcossJxJ4sqxVrAGYQEDiU9HLjNDbOtjlDi95htYB6dA
	oMT6beuYQE5lFlCXWD9PCCTMLCAvsf3tHOYJjAKzkOyYhVA1C0nVAkbmVYxyiTmlubq5iZk5
	xanJusXJiXl5qUW6xnq5mSV6qSmlmxghgc63g7F9vcwhRgEORiUeXoHldYFCrIllxZW5hxgl
	OZiURHnFc+oDhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwRjsC5XhTEiurUovyYVLSHCxK4rxq
	S9T9hATSE0tSs1NTC1KLYLIyHBxKEryhuUCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJ
	pSUZ8aBIjS8GxipIigdorwVIO29xQWIuUBSi9RSjMcesrU9eM3KsvAIkhVjy8vNSpcR5P4Kc
	LwBSmlGaB7cIluJeMYoD/S3MqwkykAeYHuHmvQJaxQS0al5jNciqkkSElFQD45QAny36e4L0
	5hy9V7HSNZfL9+LvLYoxv2u8e6Xf2tw19zMJtN/v99I2T6hnRcJVVT3duKiF15W9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222915>

On 04/30/2013 07:54 AM, Duy Nguyen wrote:
> On Tue, Apr 30, 2013 at 2:35 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
>> use 'git show @~1', and all that goody goodness.
> 
> I like this. I haven't spent a lot of time on thinking about
> ambiguation. But I think we're safe there. '@' is not overloaded much
> like ':', '^' or '~'.
> 
>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>> 'master@'.
> 
> I'm a bit reluctant to this. It looks like incomplete syntax to me as
> '@' has always been followed by '{'. Can we have the lone '@' candy
> but reject master@ and HEAD@? There's no actual gain in writing
> master@ vs master@{0}.

According to git-check-ref-format(1), an "@" character is currently
legal in a reference name as long as it is not followed by "{".  As an
example, git-svn uses "@" in reference names (e.g.,
"refs/remotes/svn/tags/foo@56945"), I believe when a Subversion branch
or tag is deleted then re-created.

This is not to say that the rule can't be changed and/or that the
git-svn use of such tag names conflicts with the proposed new syntax.
But it can definitely not be excluded that the new pattern will be
ambiguous with refnames that are already in use "in the wild".

Amusingly, it is already possible to define a reference or symbolic
reference named "@".  So all that you need to do is type

    git symbolic-ref -m "Create @ alias for HEAD" @ HEAD

to get the shortcut that you want :-)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
